#ifndef __DRAMSIM3__H
#define __DRAMSIM3__H

#include "champsim_constants.h"
#include "memory_class.h"
#include "operable.h"
#include "dramsim3.h"
#include "util.h"

namespace dramsim3 {
    class MemorySystem;
};

extern uint8_t all_warmup_complete;

// This is a wrapper so DRAMSim (which only returns trans. addr) can communicate
// with ChampSim API (which requires explicit packet->to_return->return_data calls)
// We maintain a "Meta-RQ" to send callbacks to LLC (relies on LLC MSHR to merge duplicate reqs)
class DRAMSim3_DRAM: public champsim::operable, public MemoryRequestConsumer
{
public:
    DRAMSim3_DRAM(double freq_scale, const std::string& config_file, const std::string& output_dir):
        champsim::operable(freq_scale), 
        MemoryRequestConsumer(std::numeric_limits<unsigned>::max()) {
            memory_system_ = new dramsim3::MemorySystem(config_file, output_dir,
                                            std::bind(&DRAMSim3_DRAM::ReadCallBack, this, std::placeholders::_1),
                                            std::bind(&DRAMSim3_DRAM::WriteCallBack, this, std::placeholders::_1));
            std::cout << "DRAMSim3_DRAM init -- fixed meta-RQ size" << std::endl;   
            memory_system_->RegisterACTCallback(std::bind(&DRAMSim3_DRAM::ACTCallBack, this, 
                                                std::placeholders::_1, std::placeholders::_2, 
                                                std::placeholders::_3, std::placeholders::_4,
                                                std::placeholders::_5, std::placeholders::_6,
                                                std::placeholders::_7));
            if (HYDRA_ENABLE) {
                std::cout << "[RH_DEFENSE] HydraVicRef ENABLED" << std::endl;
                detector = new Hydra(HYDRA_ROW_GROUP_SIZE, RH_THRESHOLD/2, DRAM_ROWS, 
                                    DRAM_BANKS, DRAM_RANKS, DRAM_CHANNELS);
                ((Hydra *)detector)->RCC = new Functional_Cache(HYDRA_RCC_SETS, 16 /* ways */);
                std::cout << "[RH_DEFENSE] RTH " << RH_THRESHOLD << " ROW_GROUP_SIZE " 
                            << HYDRA_ROW_GROUP_SIZE << " RCC_SETS " << HYDRA_RCC_SETS << std::endl;
            }
            if (GRAPHENE_ENABLE) {
                std::cout << "[RH_DEFENSE] Graphene + iRFM enabled" << std::endl;
                auto mg_threshold = (RH_THRESHOLD/3);
                auto num_entries = 650000/mg_threshold;
                if (ID_ENABLE) {
                    mg_threshold /= (1+IMPRESS_ALPHA);
                    num_entries *= (1+IMPRESS_ALPHA);
                }
                detector = new Misra_Gries(num_entries, mg_threshold, DRAM_ROWS, 
                                            DRAM_BANKS, DRAM_RANKS, DRAM_CHANNELS);
                std::cout << "[RH_DEFENSE] RTH " << mg_threshold 
                            << " NUM_ENTRIES " << num_entries << std::endl;
            }
            if (PARA_ENABLE) {
                std::cout << "[RH_DEFENSE] PARA + iRFM enabled" << std::endl;
            }
            if (RAA_RFM_ENABLE) {
                std::cout << "[RH_DEFENSE] RAA + iRFM enabled" << std::endl;
            }
            numPPages = DRAM_CHANNELS * DRAM_RANKS * DRAM_BANKS 
                                * DRAM_ROWS * DRAM_COLUMNS * BLOCK_SIZE / PAGE_SIZE;
            procPageAccess = new bool[numPPages]{false};
        }


    int add_rq(PACKET* packet) override {
        if (all_warmup_complete <= NUM_CPUS) {
            for (auto ret : packet->to_return)
                ret->return_data(packet);

            return -1; // Fast-forward
        }

        procPageAccess[packet->address/PAGE_SIZE] = true;

        // Check for duplicates
        auto rq_it = std::find_if(std::begin(RQ), std::end(RQ), 
                                    eq_addr<PACKET>(packet->address, LOG2_BLOCK_SIZE));
        if (rq_it != std::end(RQ)) { // Duplicate found
            // std::cout << "[Meta-RQ] duplicate rq_it->type: " << int(rq_it->type) 
            //             << " rq_it->address: " << rq_it->address
            //             << " rq_it->cpu: " << rq_it->cpu
            //             << " pkt->type: " << int(packet->type) 
            //             << " pkt->address: " << packet->address
            //             << " pkt->cpu: " << packet->cpu << std::endl;
            if (rq_it->type >= RH_MITIGATION) {
                if (packet->type < RH_MITIGATION) { // rq_it: RH-access and pkt: proc access
                    if (rq_it->type == RH_UPDATE) { // Ensure write is performed (later)
                        rhActions.push_back(std::make_pair(rq_it->address, RH_WRITE));
                    }
                    rq_it->scheduled = packet->scheduled;
                    rq_it->asid[0] = packet->asid[0], rq_it->asid[1] = packet->asid[1];
                    rq_it->type = packet->type;
                    rq_it->fill_level = packet->fill_level;
                    rq_it->pf_origin_level = packet->pf_origin_level;
                    rq_it->pf_metadata = packet->pf_metadata;
                    rq_it->cpu = packet->cpu;
                    rq_it->address = packet->address;
                    rq_it->v_address = packet->v_address;
                    rq_it->data = packet->data;
                    rq_it->instr_id = packet->instr_id;
                    rq_it->ip = packet->ip;
                    rq_it->event_cycle = packet->event_cycle;
                    rq_it->cycle_enqueued = packet->cycle_enqueued;
                    rq_it->to_return.clear();
                    rq_it->lq_index_depend_on_me.clear();
                    rq_it->sq_index_depend_on_me.clear();
                    rq_it->instr_depend_on_me.clear();
                    rq_it->translation_level = packet->translation_level;
                    rq_it->init_translation_level = packet->init_translation_level;
                    packet_dep_merge(rq_it->lq_index_depend_on_me, packet->lq_index_depend_on_me);
                    packet_dep_merge(rq_it->sq_index_depend_on_me, packet->sq_index_depend_on_me);
                    packet_dep_merge(rq_it->instr_depend_on_me, packet->instr_depend_on_me);
                    packet_dep_merge(rq_it->to_return, packet->to_return);
                    return 0; // Merged
                }
                else { // rq_it: RH-access and pkt: RH-access
                    if (packet->type == RH_UPDATE || rq_it->type == RH_UPDATE) {
                        rq_it->type = RH_UPDATE;
                    }
                    return 0;
                }
            }
            else if (packet->type >= RH_MITIGATION) { // rq_it: proc access and pkt: RH-access
                if (packet->type == RH_UPDATE) { // incoming-pkt is RH-update
                    rhActions.push_back(std::make_pair(rq_it->address, RH_WRITE));
                }
                return 0;
            }
            else { // rq_it: proc access and pkt: proc access
                // We shouldn't get duplicates as LLC MSHR handles it
                std::cout << "[PANIC] DRAM RQ already contains packet! pkt: " << int(packet->type) 
                            << " rq_it: " << int(rq_it->type) << ". Exiting..." << std::endl;
                assert(0);
            }
        }
        
        // Find empty slot
        rq_it = std::find_if_not(std::begin(RQ), std::end(RQ), is_valid<PACKET>());
        if (rq_it == std::end(RQ) || memory_system_->WillAcceptTransaction(packet->address, false) == false) {
			std::cout<<"[PANIC] RQ cannot accept entries or DRAMSim3 cannot accept transaction!"<<std::endl;
            assert(0); // This should not happen as we check occupancy before calling add_rq
        }
        // Call to DRAMSim
        memory_system_->AddTransaction(packet->address, false, (packet->type == RH_MITIGATION));

        // Add to RQ
        // Remember this packet to later return data
        // *rq_it = *packet;

        rq_it->scheduled = packet->scheduled;
        rq_it->asid[0] = packet->asid[0], rq_it->asid[1] = packet->asid[1];
        rq_it->type = packet->type;
        rq_it->fill_level = packet->fill_level;
        rq_it->pf_origin_level = packet->pf_origin_level;
        rq_it->pf_metadata = packet->pf_metadata;
        rq_it->cpu = packet->cpu;
        rq_it->address = packet->address;
        rq_it->v_address = packet->v_address;
        rq_it->data = packet->data;
        rq_it->instr_id = packet->instr_id;
        rq_it->ip = packet->ip;
        rq_it->event_cycle = packet->event_cycle;
        rq_it->cycle_enqueued = packet->cycle_enqueued;
        rq_it->to_return.clear();
        rq_it->lq_index_depend_on_me.clear();
        rq_it->sq_index_depend_on_me.clear();
        rq_it->instr_depend_on_me.clear();
        rq_it->translation_level = packet->translation_level;
        rq_it->init_translation_level = packet->init_translation_level;
        packet_dep_merge(rq_it->lq_index_depend_on_me, packet->lq_index_depend_on_me);
        packet_dep_merge(rq_it->sq_index_depend_on_me, packet->sq_index_depend_on_me);
        packet_dep_merge(rq_it->instr_depend_on_me, packet->instr_depend_on_me);
        packet_dep_merge(rq_it->to_return, packet->to_return);
    
        return std::count_if(std::begin(RQ), std::end(RQ), is_valid<PACKET>());
    }

    int add_wq(PACKET* packet) override {
        if (all_warmup_complete <= NUM_CPUS)
            return -1; // Fast-forward

        procPageAccess[packet->address/PAGE_SIZE] = true;

        // If DRAMSim cannot take new req, return
        if (!memory_system_->WillAcceptTransaction(packet->address, true)) {
            return -2;
        }
        // Avoid delaying WB before sending them to memory by just not doing WB at all
        if (BLOCKHAMMER || BH_BASELINE) {
            return 0;
        }
        // Call to DRAMSim
        memory_system_->AddTransaction(packet->address, true, (packet->type == RH_MITIGATION));
        return 0;
    }

    int add_pq(PACKET* packet) override {
        return add_rq(packet);
    }

    void operate() override {
        memory_system_->ClockTick();
    }
    uint32_t get_occupancy(uint8_t queue_type, uint64_t address) override {
        if (queue_type == 1) {
            if (!memory_system_->WillAcceptTransaction(address, false)) {
                // DRAMSim cannot accept transaction, this addr must not be inserted
                return RQ.size();
            }
            else {
                return std::count_if(std::begin(RQ), std::end(RQ), is_valid<PACKET>());
            }
        }
        else if (queue_type == 2) {
            return memory_system_->WillAcceptTransaction(address, true) ? 0 : RQ.size();
        }
        else if (queue_type == 3)
            return get_occupancy(1, address);

        return -1;        
    }
    uint32_t get_size(uint8_t queue_type, uint64_t address) override {
        if (queue_type == 1)
            return RQ.size();
        else if (queue_type == 2)
            return RQ.size();
        else if (queue_type == 3)
            return get_size(1, address);
        return -1;
    }

    void ReadCallBack(uint64_t addr) { 
        auto rq_pkt = std::find_if(std::begin(RQ), std::end(RQ), 
                                    eq_addr<PACKET>(addr, LOG2_BLOCK_SIZE));
        if (rq_pkt != std::end(RQ)) {
            for (auto ret : rq_pkt->to_return) 
                ret->return_data(&(*rq_pkt));
            *rq_pkt = {};
        }
        else {
            std::cout << "[PANIC] RQ packet not found on DRAMSim req completion for addr " 
                      << addr << ". Skipping callback to LLC..." << std::endl;
            // assert(0);
        }
    }

    void SendRFM(int ba, int ra, int ch) override {
        memory_system_->iRFMToBank(ba, ra, ch);
    }

    void WriteCallBack(uint64_t addr) { return; }
    void ACTCallBack(uint64_t ch, uint64_t ra, uint64_t ba, uint64_t ro,
                        uint64_t tON, uint64_t tPRE, uint64_t tRC) {
        if ((tON != uint64_t(-1) && ID_ENABLE && GRAPHENE_ENABLE) ||
            (tON != uint64_t(-1) && ID_ENABLE && PARA_ENABLE) ||
            (tON != uint64_t(-1) && IP_ENABLE && GRAPHENE_ENABLE) ||
            (tON != uint64_t(-1) && IP_ENABLE && PARA_ENABLE)) {
            // std::cout << "ACT-callback recv ch " << ch << " ra " << ra << " ba "
            //             << ba << " ro " << ro << " tON " << tON << std::endl;
            ACTs.push_back(ACTInfo(ch, ra, ba, ro, tON, tPRE, tRC));
        }
        else if (tON != uint64_t(-1)) {
            return;
        }
        ACTs.push_back(ACTInfo(ch, ra, ba, ro));
        //DEBUG std::cout << "[ACT] Ch-" << ch << " Ra-" << ra << " Ba-" << ba << " Ro-" << ro << std::endl;
    }
    void PrintStats() { memory_system_->PrintStats(); }
protected:
    dramsim3::MemorySystem* memory_system_;
    std::vector<PACKET> RQ{DRAM_RQ_SIZE*DRAM_CHANNELS}; // Meta-RQ for callbacks
};

#endif

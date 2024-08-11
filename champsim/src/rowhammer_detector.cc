#include "rowhammer_detector.h"

Misra_Gries::Misra_Gries(uint32_t __numEntries, uint32_t __threshold, uint32_t __numRows,
                        uint8_t __numBanks, uint8_t __numRanks, uint8_t __numChannels){
    trackers  = (Tracker ***) calloc (__numChannels, sizeof(Tracker **));
    for (int ii = 0; ii < __numChannels; ii++) {
        trackers[ii] = (Tracker **) calloc (__numRanks, sizeof(Tracker *));
        for (int jj = 0; jj < __numRanks; jj++) {
            trackers[ii][jj] = new Tracker[__numBanks];
            for (int kk = 0; kk < __numBanks; kk++) {
                trackers[ii][jj][kk].entries = (Tracker_Entry *) calloc (__numEntries, sizeof(Tracker_Entry));
                trackers[ii][jj][kk].rowHasEntry = (uint32_t *) calloc(__numRows, sizeof(uint32_t));
            }
        }
    }
    threshold = __threshold;
    numEntries = __numEntries;
    numBanks = __numBanks;
    numRanks = __numRanks;
    numChannels = __numChannels;
    numRows = __numRows;
    s_numUniqRows = 0;
}

void Misra_Gries::reset(){
    for (int ii = 0; ii < numChannels; ii++) {
        for (int jj = 0; jj < numRanks; jj++) {
            for (int kk = 0; kk < numBanks; kk++) {
                trackers[ii][jj][kk].s_num_reset++;
                trackers[ii][jj][kk].s_glob_spill_count += trackers[ii][jj][kk].spill_counter;
                trackers[ii][jj][kk].spill_counter = 0;
                for (int ll = 0; ll < numEntries; ll++) {
                    trackers[ii][jj][kk].entries[ll].valid = false;
                    trackers[ii][jj][kk].entries[ll].count = 0;
                    trackers[ii][jj][kk].entries[ll].addr = 0;
                }
                std::fill_n(trackers[ii][jj][kk].rowHasEntry, numRows, 0);
            }

        }
    }
}

bool Misra_Gries::access(Addr rowAddr, uint8_t bankID, uint8_t rankID, 
                            uint8_t channelID,  bool isFuncLookup = false) {
    Tracker *tracker = &(trackers[channelID][rankID][bankID]);
    if (isFuncLookup == false) tracker->s_num_access++;
    bool aggressor_detected = false;
    bool entry_found = false;

    if (tracker->rowHasEntry[rowAddr]) {
        uint32_t entryID = tracker->rowHasEntry[rowAddr]-1;
        if (!(tracker->entries[entryID].valid == true && 
                tracker->entries[entryID].addr == rowAddr)) {
            assert(0);
        }

        if (isFuncLookup == false) {
            tracker->entries[entryID].count++;
            if (tracker->entries[entryID].count % threshold == 0) {
                aggressor_detected = true;
                if (tracker->uniq_rows.insert(rowAddr).second) {
                    s_numUniqRows++;
                }
            }
        }
        entry_found = true;
    }

    if (entry_found == false && isFuncLookup == false) {
        for (uint32_t ii = 0; ii < numEntries; ii++) {
            if (tracker->entries[ii].count == tracker->spill_counter) {
                if (tracker->entries[ii].valid) {
                    tracker->rowHasEntry[tracker->entries[ii].addr] = 0;
                }
                tracker->entries[ii].addr = rowAddr;
                tracker->entries[ii].count++;
                tracker->entries[ii].valid = true;
                tracker->s_num_install++;
                tracker->rowHasEntry[rowAddr] = ii+1;
                if (tracker->entries[ii].count % threshold == 0) {
                    aggressor_detected = true;
                    if (tracker->uniq_rows.insert(rowAddr).second) {
                        s_numUniqRows++;
                    }
                }
                entry_found = true;
                break;
            }
            else if (tracker->entries[ii].valid == false) {
                assert(0);
            }
        }
        if (entry_found == false) {
            // Table is full and entries have value greater than spill counter
            tracker->spill_counter++;
        }
    }

    if(aggressor_detected == true && isFuncLookup == false) {
        tracker->s_aggressors++;
    }
    
    if (isFuncLookup == false) {
        return aggressor_detected;
    }
    else {
        return entry_found;
    }
}

void Misra_Gries::print_stats(){
    ;
}

Hydra::Hydra(uint32_t __rowGroupSize, uint32_t __threshold, uint32_t __numRows,
                        uint8_t __numBanks, uint8_t __numRanks, uint8_t __numChannels) {
    numDRAMRows = __numRows*__numBanks*__numRanks*__numChannels;
    threshold = __threshold;
    rowGroupSize = __rowGroupSize;
    numBanks = __numBanks;
    numRanks = __numRanks;
    numChannels = __numChannels;
    numRows = __numRows;
    s_numUniqRows = 0;
    groupThreshold = uint32_t(0.5*float(threshold));

    if (threshold > 256) {
        ctrsPerCLine = 32;
    }
    else {
        ctrsPerCLine = 64;
    }
    numGCTEntries = numDRAMRows/rowGroupSize;

    GCT = (uint32_t *) calloc (numGCTEntries, sizeof(uint32_t));
    RCT = (uint32_t *) calloc (numDRAMRows, sizeof(uint32_t));
    RowGroupInit = (bool *) calloc (numGCTEntries, sizeof(uint32_t));

    s_dirty_evict = 0;
    s_rcc_miss = 0;
    s_mitigations = 0;
    s_gct_only = 0;
    s_rcc_acc = 0;
    s_rct_init = 0;
}

bool Hydra::access(Addr DRAMRowID, uint8_t bankID, uint8_t rankID, uint8_t channelID, bool isFuncLookup) {
    uint32_t GCTIndex = DRAMRowID/rowGroupSize;
    RowGroupInitPenalty = 0;
    CtrRdPenalty = 0;
    CtrMdPenalty = 0;
    bool mitigate = false;
    if (GCT[GCTIndex] < groupThreshold) {
        GCT[GCTIndex]++;
        s_gct_only++;
    }
    else {
        s_rcc_acc++;
        Addr ctrID = DRAMRowID; // Maintain compatability with func cache API (block_offset = 0)
        if (RCC->Lookup(ctrID, LOOKUP_AND_UPDATE) == RCC->m_ways) { // RCC Miss
            s_rcc_miss++;
            if (RowGroupInit[GCTIndex]) {
                CtrRdPenalty = DRAMRowID; // Penalty to fetch counter
            }
            uint64_t vicCtrWay = RCC->Find_Victim(ctrID);
            if (RCC->Is_Block_Valid(ctrID, vicCtrWay)) {
                CtrMdPenalty = RCC->Get_Block_Addr(ctrID, vicCtrWay); // RMW dirty counter back to DRAM
                s_dirty_evict++;
                RCC->Invalidate(ctrID, vicCtrWay);
            }
            RCC->Fill(ctrID, vicCtrWay);
        }
        if (RowGroupInit[GCTIndex] == false) {
            RowGroupInit[GCTIndex] = true;
            s_rct_init++;
            RowGroupInitPenalty = DRAMRowID; // DRAM Rd-Md-Wr counter lines in group to TG Penalty 
        }
        if (RCT[DRAMRowID] == 0) {
            RCT[DRAMRowID] = groupThreshold;
        }
        RCT[DRAMRowID]++;
        if (RCT[DRAMRowID] >= threshold) {
            RCT[DRAMRowID] = 1;
            s_mitigations++;
            mitigate = true;
        }
    }
    return mitigate;
}

void Hydra::reset() {
    for (uint32_t i = 0; i < numGCTEntries; i++) {
        GCT[i] = 0;
        RowGroupInit[i] = false;
    }
    for (uint32_t i = 0; i < numDRAMRows; i++) {
        RCT[i] = 0;
    }
    RCC->Reset();
}

void Hydra::print_stats(){
    std::cout << "HYDRA_VR STATS\n"
              << "H_GCT_ONLY " << s_gct_only << "\n"
              << "H_RCC_ACC " << s_rcc_acc << "\n"
              << "H_RCC_MISS " << s_rcc_miss << "\n"
              << "H_DIRTY_EVICTS " << s_dirty_evict << "\n"
              << "H_MITIGATIONS " << s_mitigations << "\n"
              << "H_RCT_INIT " << s_rct_init << std::endl;
}

/***************************************************************************
 * FUNCTIONAL CACHE BEGINS
 * *************************************************************************/

/**************************************************
 * Constructs a set-associative cache level
**************************************************/
Functional_Cache::Functional_Cache(uint32_t sets, uint32_t ways){
    m_blk_offset = 0 /* BLK_OFFSET */;
    m_sets = sets;
    m_ways = ways;

    m_cache = (FuncCacheBlock **)calloc(sets, sizeof(FuncCacheBlock *));
    assert (m_cache != NULL);
    for (int i = 0; i < m_sets; i++){
        m_cache[i] = (FuncCacheBlock *)calloc(ways, sizeof(FuncCacheBlock));
    }

    s_lookups = 0;
    s_hits = 0;
    s_fills = 0;
    s_invalidations = 0;
    s_evictions = 0;
}

/**************************************************
 * Returns blk_way if addr exists in cache and updates 
 * LRU if lookup_type == LOOKUP_AND_UPDATE
**************************************************/
uint32_t Functional_Cache::Lookup(uint64_t addr, uint32_t lookup_type = LOOKUP_AND_UPDATE){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    uint64_t tag_bits = addr;
    bool hit = false;
    uint32_t blk_way = m_ways;

    for (int way = 0; way < m_ways; way++){
        if (m_cache[set][way].valid && m_cache[set][way].tag == tag_bits){
            hit = true;
            blk_way = way;
            break;
        }
    }

    if (lookup_type == LOOKUP_AND_UPDATE){
        s_lookups++;
        if (hit){
            s_hits++;
            m_cache[set][blk_way].rrip = 3;
        }
    }

    return blk_way;
}

/**************************************************
 * Returns blk_way if addr exists in cache 
**************************************************/
uint32_t Functional_Cache::PartialLookup(uint64_t addr){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    uint64_t partial_tag = addr/partial_lookup_factor;
    uint32_t blk_way = m_ways;

    for (int way = 0; way < m_ways; way++){
        if (m_cache[set][way].valid && 
            (m_cache[set][way].tag/partial_lookup_factor) == partial_tag){
            blk_way = way;
            break;
        }
    }

    if (blk_way < m_ways) {
        m_cache[set][blk_way].rrip = 3;
    }

    return blk_way;
}

/**************************************************
 * Updates LRU and fills block at (set, blk_way)
**************************************************/
void Functional_Cache::Fill(uint64_t addr, uint32_t blk_way){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    uint64_t tag_bits = addr;
    assert(m_cache[set][blk_way].valid == false);

    m_cache[set][blk_way].valid = true;
    m_cache[set][blk_way].tag = tag_bits;
    m_cache[set][blk_way].rrip = 1;
    m_cache[set][blk_way].dirty = false;
    m_cache[set][blk_way].onlyOneRowRemapped = true;
    s_fills++;

    return;
}

/**************************************************
 * Updates LRU and invalidates block at (set, blk_way)
**************************************************/
void Functional_Cache::Invalidate(uint64_t addr, uint32_t blk_way){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    if (m_cache[set][blk_way].valid == false){
        return;
    }

    m_cache[set][blk_way].valid = false;
    m_cache[set][blk_way].tag = 0;
    m_cache[set][blk_way].rrip = 0;
    m_cache[set][blk_way].dirty = false;
    m_cache[set][blk_way].onlyOneRowRemapped = false;
    s_invalidations++;

    return;
}

/**************************************************
 * Returns victim way in set which is either any one
 * invalid way or LRU way if none are invalid
**************************************************/
uint32_t Functional_Cache::Find_Victim(uint64_t addr){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    uint32_t victim_way = m_ways;

    for (int way = 0; way < m_ways; way++){
        if (m_cache[set][way].valid == false){
            victim_way = way;
            break;
        }
    }

    if (victim_way == m_ways){
        s_evictions++;
        int loop_count = 4;
        while (loop_count) {
            for (int way = 0; way < m_ways; way++){
                if (m_cache[set][way].rrip == 0){
                    victim_way = way;
                    break;
                }
            }
            if (victim_way < m_ways) {
                break;
            }
            for (int way = 0; way < m_ways; way++){
                m_cache[set][way].rrip--;
            }
            loop_count--;
        }
    }

    assert(victim_way < m_ways);

    return victim_way;
}

/**************************************************
 * Returns true if block at (set, blk_way) is valid
**************************************************/
bool Functional_Cache::Is_Block_Valid(uint64_t addr, uint32_t blk_way){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    
    return m_cache[set][blk_way].valid;
}

/**************************************************
 * Returns block aligned address
 * the block at (set, blk_way) must be valid
**************************************************/
uint64_t Functional_Cache::Get_Block_Addr(uint64_t addr, uint32_t blk_way){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    assert(m_cache[set][blk_way].valid == true);

    return (m_cache[set][blk_way].tag);
}

/**************************************************
 * Returns the way of block corresponding to addr
 * the block must exist in the set
**************************************************/
uint32_t Functional_Cache::Get_Block_Way(uint64_t addr){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    uint64_t tag_bits = addr;
    uint32_t blk_way = m_ways;

    for (int way = 0; way < m_ways; way++){
        if (m_cache[set][way].valid && m_cache[set][way].tag == tag_bits){
            blk_way = way;
            break;
        }
    }
    assert (blk_way < m_ways);
    return blk_way;
}

/**************************************************
 * Invalidates all lines in the cache 
**************************************************/
void Functional_Cache::Reset() {
    for (int set = 0; set < m_sets; set++) {
        for (int way = 0; way < m_ways; way++) {
            m_cache[set][way].valid = false;
            m_cache[set][way].tag = 0;
            m_cache[set][way].rrip = 0;
            m_cache[set][way].dirty = false;
            m_cache[set][way].onlyOneRowRemapped = false;
        }
    }
}

void Functional_Cache::SetORRBit(uint64_t addr, bool bitvalue){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    uint64_t partial_tag = addr/partial_lookup_factor;
    for (int way = 0; way < m_ways; way++){
        if (m_cache[set][way].valid && 
            (m_cache[set][way].tag/partial_lookup_factor) == partial_tag){
            m_cache[set][way].onlyOneRowRemapped = bitvalue;
        }
    }
}

bool Functional_Cache::QueryORRBit(uint64_t addr, uint32_t blk_way){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    assert(m_cache[set][blk_way].valid == true);
    return m_cache[set][blk_way].onlyOneRowRemapped;
}

void Functional_Cache::SetDirtyBit(uint64_t addr, uint32_t blk_way){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    assert(m_cache[set][blk_way].valid == true);
    m_cache[set][blk_way].dirty = true;
}

bool Functional_Cache::QueryDirtyBit(uint64_t addr, uint32_t blk_way){
    uint32_t set = (addr >> m_blk_offset) % m_sets;
    assert(m_cache[set][blk_way].valid == true);
    return m_cache[set][blk_way].dirty;
}

void Functional_Cache::Print_Stats(uint32_t level){
    // cout << right << setw(15) << "L" << level << " Stats" << endl;
    // cout << left;
    // cout << setw(30) << "Lookups: " << s_lookups << endl;
    // cout << setw(30) << "Hits: " << s_hits << endl;
    // cout << setw(30) << "Misses: " << s_lookups - s_hits << endl;
    // cout << setw(30) << "Fills: " << s_fills << endl;
    // cout << setw(30) << "Evictions: " << s_evictions << endl;
    // cout << setw(30) << "Invalidations: " << s_invalidations << endl;
}

/***************************************************************************
 * FUNCTIONAL CACHE ENDS
 * *************************************************************************/
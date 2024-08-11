/*
 *    Copyright 2023 The ChampSim Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "cache.h"

#include <algorithm>
#include <iterator>
#include "champsim.h"
#include "champsim_constants.h"
#include "util.h"
#include "vmem.h"

#ifndef SANITY_CHECK
#define NDEBUG
#endif

#define MEM_BYTES (DRAM_CHANNELS * DRAM_RANKS * DRAM_BANKS * DRAM_ROWS * DRAM_COLUMNS * BLOCK_SIZE)

extern VirtualMemory vmem;
extern uint8_t warmup_complete[NUM_CPUS];
extern uint8_t all_warmup_complete;

void CACHE::handle_fill()
{
  while (writes_available_this_cycle > 0) {
    auto fill_mshr = MSHR.begin();
    if (fill_mshr == std::end(MSHR) || fill_mshr->event_cycle > current_cycle)
      return;

    // find victim
    uint32_t set = get_set(fill_mshr->address);

    auto set_begin = std::next(std::begin(block), set * NUM_WAY);
    uint64_t max_way = get_max_way(set);
    auto set_end = std::next(set_begin, max_way); // set ends before first reserved way
    auto first_inv = std::find_if_not(set_begin, set_end, is_valid<BLOCK>());
    uint32_t way = std::distance(set_begin, first_inv);
    if (way == max_way) // invalid way not found
      way = impl_replacement_find_victim(fill_mshr->cpu, fill_mshr->instr_id, set, &block.data()[set * NUM_WAY], fill_mshr->ip, fill_mshr->address,
                                         fill_mshr->type);

    bool success = filllike_miss(set, way, *fill_mshr);
    if (!success)
      return;

    if (way != max_way) { // Found a non-reserved way
      // update processed packets
      fill_mshr->data = block[set * NUM_WAY + way].data;

      for (auto ret : fill_mshr->to_return)
        ret->return_data(&(*fill_mshr));
    }

    MSHR.erase(fill_mshr);
    writes_available_this_cycle--;
  }
}

void CACHE::handle_writeback()
{
  while (writes_available_this_cycle > 0) {
    if (!WQ.has_ready())
      return;

    // handle the oldest entry
    PACKET& handle_pkt = WQ.front();

    // access cache
    uint32_t set = get_set(handle_pkt.address);
    uint32_t way = get_way(handle_pkt.address, set);

    BLOCK& fill_block = block[set * NUM_WAY + way];

    uint64_t max_way = get_max_way(set);

    if (way < max_way) // HIT
    {
      impl_replacement_update_state(handle_pkt.cpu, set, way, fill_block.address, handle_pkt.ip, 0, handle_pkt.type, 1);

      // COLLECT STATS
      sim_hit[handle_pkt.cpu][handle_pkt.type]++;
      sim_access[handle_pkt.cpu][handle_pkt.type]++;

      // mark dirty
      fill_block.dirty = 1;
    } else // MISS
    {
      bool success;
      if (handle_pkt.type == RFO && handle_pkt.to_return.empty()) {
        success = readlike_miss(handle_pkt);
      } else {
        // find victim
        auto set_begin = std::next(std::begin(block), set * NUM_WAY);
        auto set_end = std::next(set_begin, max_way);
        auto first_inv = std::find_if_not(set_begin, set_end, is_valid<BLOCK>());
        way = std::distance(set_begin, first_inv);
        if (way == max_way)
          way = impl_replacement_find_victim(handle_pkt.cpu, handle_pkt.instr_id, set, &block.data()[set * NUM_WAY], handle_pkt.ip, handle_pkt.address,
                                             handle_pkt.type);

        success = filllike_miss(set, way, handle_pkt);
      }

      if (!success)
        return;
    }

    // remove this entry from WQ
    writes_available_this_cycle--;
    WQ.pop_front();
  }
}

void CACHE::handle_read()
{
  while (reads_available_this_cycle > 0) {

    if (!RQ.has_ready())
      return;

    // handle the oldest entry
    PACKET& handle_pkt = RQ.front();

    // A (hopefully temporary) hack to know whether to send the evicted paddr or
    // vaddr to the prefetcher
    ever_seen_data |= (handle_pkt.v_address != handle_pkt.ip);

    uint32_t set = get_set(handle_pkt.address);
    uint32_t way = get_way(handle_pkt.address, set);

    uint64_t max_way = get_max_way(set);

    if (way < max_way) // HIT
    {
      readlike_hit(set, way, handle_pkt);
    } else {
      bool success = readlike_miss(handle_pkt);
      if (!success)
        return;
    }

    // remove this entry from RQ
    RQ.pop_front();
    reads_available_this_cycle--;
  }
}

void CACHE::handle_prefetch()
{
  while (reads_available_this_cycle > 0) {
    if (!PQ.has_ready())
      return;

    // handle the oldest entry
    PACKET& handle_pkt = PQ.front();

    uint32_t set = get_set(handle_pkt.address);
    uint32_t way = get_way(handle_pkt.address, set);

    uint64_t max_way = get_max_way(set);

    if (way < max_way) // HIT
    {
      readlike_hit(set, way, handle_pkt);
    } else {
      bool success = readlike_miss(handle_pkt);
      if (!success)
        return;
    }

    // remove this entry from PQ
    PQ.pop_front();
    reads_available_this_cycle--;
  }
}

void CACHE::readlike_hit(std::size_t set, std::size_t way, PACKET& handle_pkt)
{
  DP(if (warmup_complete[handle_pkt.cpu]) {
    std::cout << "[" << NAME << "] " << __func__ << " hit";
    std::cout << " instr_id: " << handle_pkt.instr_id << " address: " << std::hex << (handle_pkt.address >> OFFSET_BITS);
    std::cout << " full_addr: " << handle_pkt.address;
    std::cout << " full_v_addr: " << handle_pkt.v_address << std::dec;
    std::cout << " type: " << +handle_pkt.type;
    std::cout << " cycle: " << current_cycle << std::endl;
  });

  BLOCK& hit_block = block[set * NUM_WAY + way];

  handle_pkt.data = hit_block.data;

  // update prefetcher on load instruction
  if (should_activate_prefetcher(handle_pkt.type) && handle_pkt.pf_origin_level < fill_level) {
    cpu = handle_pkt.cpu;
    uint64_t pf_base_addr = (virtual_prefetch ? handle_pkt.v_address : handle_pkt.address) & ~bitmask(match_offset_bits ? 0 : OFFSET_BITS);
    handle_pkt.pf_metadata = impl_prefetcher_cache_operate(pf_base_addr, handle_pkt.ip, 1, handle_pkt.type, handle_pkt.pf_metadata);
  }

  // update replacement policy
  impl_replacement_update_state(handle_pkt.cpu, set, way, hit_block.address, handle_pkt.ip, 0, handle_pkt.type, 1);

  // COLLECT STATS
  sim_hit[handle_pkt.cpu][handle_pkt.type]++;
  sim_access[handle_pkt.cpu][handle_pkt.type]++;

  for (auto ret : handle_pkt.to_return)
    ret->return_data(&handle_pkt);

  // update prefetch stats and reset prefetch bit
  if (hit_block.prefetch) {
    pf_useful++;
    hit_block.prefetch = 0;
  }
}

bool CACHE::readlike_miss(PACKET& handle_pkt)
{
  DP(if (warmup_complete[handle_pkt.cpu]) {
    std::cout << "[" << NAME << "] " << __func__ << " miss";
    std::cout << " instr_id: " << handle_pkt.instr_id << " address: " << std::hex << (handle_pkt.address >> OFFSET_BITS);
    std::cout << " full_addr: " << handle_pkt.address;
    std::cout << " full_v_addr: " << handle_pkt.v_address << std::dec;
    std::cout << " type: " << +handle_pkt.type;
    std::cout << " cycle: " << current_cycle << std::endl;
  });

  // check mshr
  auto mshr_entry = std::find_if(MSHR.begin(), MSHR.end(), eq_addr<PACKET>(handle_pkt.address, OFFSET_BITS));
  bool mshr_full = (MSHR.size() == MSHR_SIZE);

  if (mshr_entry != MSHR.end()) // miss already inflight
  {
    // update fill location
    mshr_entry->fill_level = std::min(mshr_entry->fill_level, handle_pkt.fill_level);

    packet_dep_merge(mshr_entry->lq_index_depend_on_me, handle_pkt.lq_index_depend_on_me);
    packet_dep_merge(mshr_entry->sq_index_depend_on_me, handle_pkt.sq_index_depend_on_me);
    packet_dep_merge(mshr_entry->instr_depend_on_me, handle_pkt.instr_depend_on_me);
    packet_dep_merge(mshr_entry->to_return, handle_pkt.to_return);

    if (mshr_entry->type == PREFETCH && handle_pkt.type != PREFETCH) {
      // Mark the prefetch as useful
      if (mshr_entry->pf_origin_level == fill_level)
        pf_useful++;

      uint64_t prior_event_cycle = mshr_entry->event_cycle;
      *mshr_entry = handle_pkt;

      // in case request is already returned, we should keep event_cycle
      mshr_entry->event_cycle = prior_event_cycle;
    }
  } else {
    if (mshr_full)  // not enough MSHR resource
      return false; // TODO should we allow prefetches anyway if they will not
                    // be filled to this level?

    bool is_read = prefetch_as_load || (handle_pkt.type != PREFETCH);

    // check to make sure the lower level queue has room for this read miss
    int queue_type = (is_read) ? 1 : 3;
    if (lower_level->get_occupancy(queue_type, handle_pkt.address) == lower_level->get_size(queue_type, handle_pkt.address))
      return false;

    // Allocate an MSHR
    if (handle_pkt.fill_level <= fill_level) {
      auto it = MSHR.insert(std::end(MSHR), handle_pkt);
      it->cycle_enqueued = current_cycle;
      it->event_cycle = std::numeric_limits<uint64_t>::max();
    }

    if (handle_pkt.fill_level <= fill_level)
      handle_pkt.to_return = {this};
    else
      handle_pkt.to_return.clear();

    if (!is_read)
      lower_level->add_pq(&handle_pkt);
    else
      lower_level->add_rq(&handle_pkt);
  }

  // update prefetcher on load instructions and prefetches from upper levels
  if (should_activate_prefetcher(handle_pkt.type) && handle_pkt.pf_origin_level < fill_level) {
    cpu = handle_pkt.cpu;
    uint64_t pf_base_addr = (virtual_prefetch ? handle_pkt.v_address : handle_pkt.address) & ~bitmask(match_offset_bits ? 0 : OFFSET_BITS);
    handle_pkt.pf_metadata = impl_prefetcher_cache_operate(pf_base_addr, handle_pkt.ip, 0, handle_pkt.type, handle_pkt.pf_metadata);
  }

  return true;
}

bool CACHE::filllike_miss(std::size_t set, std::size_t way, PACKET& handle_pkt)
{
  DP(if (warmup_complete[handle_pkt.cpu]) {
    std::cout << "[" << NAME << "] " << __func__ << " miss";
    std::cout << " instr_id: " << handle_pkt.instr_id << " address: " << std::hex << (handle_pkt.address >> OFFSET_BITS);
    std::cout << " full_addr: " << handle_pkt.address;
    std::cout << " full_v_addr: " << handle_pkt.v_address << std::dec;
    std::cout << " type: " << +handle_pkt.type;
    std::cout << " cycle: " << current_cycle << std::endl;
  });

  uint64_t max_way = get_max_way(set);

  bool bypass = (way == max_way);
#ifndef LLC_BYPASS
  assert(!bypass);
#endif
  assert(handle_pkt.type != WRITEBACK || !bypass);

  BLOCK& fill_block = block[set * NUM_WAY + way];
  bool evicting_dirty = !bypass && (lower_level != NULL) && fill_block.dirty;
  uint64_t evicting_address = 0;

  if (!bypass) {
    if (evicting_dirty) {
      PACKET writeback_packet;

      writeback_packet.fill_level = lower_level->fill_level;
      writeback_packet.cpu = handle_pkt.cpu;
      writeback_packet.address = fill_block.address;
      writeback_packet.data = fill_block.data;
      writeback_packet.instr_id = handle_pkt.instr_id;
      writeback_packet.ip = 0;
      writeback_packet.type = WRITEBACK;

      auto result = lower_level->add_wq(&writeback_packet);
      if (result == -2)
        return false;

      if (VWQ_ENABLE && NAME == "LLC") {
        // Write up-to 32 dirty lines in nearby 16 sets from same page 
        int max_nearby_writebacks = 32;
        int max_sets_per_side = 16;
        uint32_t wq_set_begin = (set > max_sets_per_side) ? set - max_sets_per_side : 0,
                 wq_set_end = (set < NUM_SET - max_sets_per_side) ? set + max_sets_per_side : NUM_SET;
        uint64_t max_way = get_max_way(set);
        for (uint32_t i = wq_set_begin; (i < wq_set_end) && max_nearby_writebacks; i++) {
          for (uint32_t j = i*NUM_WAY; (j < i*NUM_WAY + max_way) && max_nearby_writebacks; j++) {
            if (!(i == set && j == way) && block[j].valid && block[j].dirty
                && (block[j].address >> LOG2_PAGE_SIZE) == (fill_block.address >> LOG2_PAGE_SIZE)) {
              PACKET nearby_writeback_packet;

              nearby_writeback_packet.fill_level = lower_level->fill_level;
              nearby_writeback_packet.cpu = block[j].cpu;
              nearby_writeback_packet.address = block[j].address;
              nearby_writeback_packet.data = block[j].data;
              nearby_writeback_packet.instr_id = block[j].instr_id;
              nearby_writeback_packet.ip = 0;
              nearby_writeback_packet.type = WRITEBACK;
              nearby_writeback_packet.to_return = {this};

              if (lower_level->add_wq(&nearby_writeback_packet) != -2) {
                max_nearby_writebacks--;
                s_early_writebacks++;
                block[j].dirty = false;
              }
              else {
                max_nearby_writebacks = 0; // WQ is full, no need to search for more lines
              }
            }
          }
        }
      }
    }

    if (ever_seen_data)
      evicting_address = fill_block.address & ~bitmask(match_offset_bits ? 0 : OFFSET_BITS);
    else
      evicting_address = fill_block.v_address & ~bitmask(match_offset_bits ? 0 : OFFSET_BITS);

    if (fill_block.prefetch)
      pf_useless++;

    if (handle_pkt.type == PREFETCH)
      pf_fill++;

    fill_block.valid = true;
    fill_block.prefetch = (handle_pkt.type == PREFETCH && handle_pkt.pf_origin_level == fill_level);
    fill_block.dirty = (handle_pkt.type == WRITEBACK || (handle_pkt.type == RFO && handle_pkt.to_return.empty()));
    fill_block.address = handle_pkt.address;
    fill_block.v_address = handle_pkt.v_address;
    fill_block.data = handle_pkt.data;
    fill_block.ip = handle_pkt.ip;
    fill_block.cpu = handle_pkt.cpu;
    fill_block.instr_id = handle_pkt.instr_id;
  }

  if (warmup_complete[handle_pkt.cpu] && (handle_pkt.cycle_enqueued != 0))
    total_miss_latency += current_cycle - handle_pkt.cycle_enqueued;

  // update prefetcher
  cpu = handle_pkt.cpu;
  handle_pkt.pf_metadata =
      impl_prefetcher_cache_fill((virtual_prefetch ? handle_pkt.v_address : handle_pkt.address) & ~bitmask(match_offset_bits ? 0 : OFFSET_BITS), set, way,
                                 handle_pkt.type == PREFETCH, evicting_address, handle_pkt.pf_metadata);

  // update replacement policy
  impl_replacement_update_state(handle_pkt.cpu, set, way, handle_pkt.address, handle_pkt.ip, 0, handle_pkt.type, 0);

  // COLLECT STATS
  sim_miss[handle_pkt.cpu][handle_pkt.type]++;
  sim_access[handle_pkt.cpu][handle_pkt.type]++;

  return true;
}

void CACHE::operate()
{
  operate_writes();
  operate_reads();

  impl_prefetcher_cycle_operate();
}

void CACHE::operate_writes()
{
  // perform all writes
  writes_available_this_cycle = MAX_WRITE;
  handle_fill();
  handle_writeback();

  WQ.operate();
}

void CACHE::operate_reads()
{
  // perform all reads
  reads_available_this_cycle = MAX_READ;
  handle_read();
  va_translate_prefetches();
  handle_prefetch();

  if (NAME == "LLC") {
    if (current_cycle - last_tracker_reset >= 64000000ul) {
      s_resets++;
      memset((void *)CRA_ctr, 0, sizeof(uint64_t) * DRAM_CHANNELS * DRAM_RANKS * DRAM_BANKS * DRAM_ROWS);
      memset((void *)CRA_ctr_set, 0, sizeof(uint64_t) * NUM_SET);
      memset((void *)per_set_tracker_state, 0, sizeof(uint64_t) * NUM_SET);
      memset((void *)row_ACT, 0, sizeof(uint64_t) * 100);
      memset((void *)sets_in_state, 0, sizeof(uint64_t) * 4);
      if (ART_LITE) {
        // LITE_CONFIG: Reset cached ctrs in LLC set
        for (int i = 0; i < NUM_SET; i++)
          cachedCtrs[i].clear();
      }
      last_tracker_reset = current_cycle;
      uniq_rows_ACT = 0;
      num_ACT = 0;
      num_mits = 0;
      if (HYDRA_ENABLE)
        lower_level->detector->reset();
      if (GRAPHENE_ENABLE)
        lower_level->detector->reset();
    }
    if (BLOCKHAMMER && all_warmup_complete > NUM_CPUS && current_cycle % 10000000 == 0) {
      std::cout << "[Cycle-" << current_cycle << "] LLC_BH_STATS:- NUM_DELAY: " 
                << s_BH_num_delay 
                << " SUM_DELAY: " << s_BH_sum_delay
                << " MAX_DELAY: " << s_BH_max_delay << std::endl;
    }
    performRHActions();
    recvACTInfo();
  }

  RQ.operate();
  PQ.operate();
  VAPQ.operate();
}

uint32_t CACHE::get_set(uint64_t address) { return ((address >> OFFSET_BITS) & bitmask(lg2(NUM_SET))); }

uint32_t CACHE::get_way(uint64_t address, uint32_t set)
{
  auto begin = std::next(block.begin(), set * NUM_WAY);
  uint64_t max_way = get_max_way(set);

  auto end = std::next(begin, max_way);
  return std::distance(begin, std::find_if(begin, end, eq_addr<BLOCK>(address, OFFSET_BITS)));
}

int CACHE::invalidate_entry(uint64_t inval_addr)
{
  uint32_t set = get_set(inval_addr);
  uint32_t way = get_way(inval_addr, set);
  uint64_t max_way = get_max_way(set);
  if (way < max_way)
    block[set * NUM_WAY + way].valid = 0;

  return way;
}

int CACHE::add_rq(PACKET* packet)
{
  assert(packet->address != 0);
  RQ_ACCESS++;

  DP(if (warmup_complete[packet->cpu]) {
    std::cout << "[" << NAME << "_RQ] " << __func__ << " instr_id: " << packet->instr_id << " address: " << std::hex << (packet->address >> OFFSET_BITS);
    std::cout << " full_addr: " << packet->address << " v_address: " << packet->v_address << std::dec << " type: " << +packet->type
              << " occupancy: " << RQ.occupancy();
  })

  // check for the latest writebacks in the write queue
  champsim::delay_queue<PACKET>::iterator found_wq = std::find_if(WQ.begin(), WQ.end(), eq_addr<PACKET>(packet->address, match_offset_bits ? 0 : OFFSET_BITS));

  if (found_wq != WQ.end()) {

    DP(if (warmup_complete[packet->cpu]) std::cout << " MERGED_WQ" << std::endl;)

    packet->data = found_wq->data;
    for (auto ret : packet->to_return)
      ret->return_data(packet);

    WQ_FORWARD++;
    return -1;
  }

  // check for duplicates in the read queue
  auto found_rq = std::find_if(RQ.begin(), RQ.end(), eq_addr<PACKET>(packet->address, OFFSET_BITS));
  if (found_rq != RQ.end()) {

    DP(if (warmup_complete[packet->cpu]) std::cout << " MERGED_RQ" << std::endl;)

    packet_dep_merge(found_rq->lq_index_depend_on_me, packet->lq_index_depend_on_me);
    packet_dep_merge(found_rq->sq_index_depend_on_me, packet->sq_index_depend_on_me);
    packet_dep_merge(found_rq->instr_depend_on_me, packet->instr_depend_on_me);
    packet_dep_merge(found_rq->to_return, packet->to_return);

    RQ_MERGED++;

    return 0; // merged index
  }

  // check occupancy
  if (RQ.full()) {
    RQ_FULL++;

    DP(if (warmup_complete[packet->cpu]) std::cout << " FULL" << std::endl;)

    return -2; // cannot handle this request
  }

  // if there is no duplicate, add it to RQ
  if (warmup_complete[cpu])
    RQ.push_back(*packet);
  else
    RQ.push_back_ready(*packet);

  DP(if (warmup_complete[packet->cpu]) std::cout << " ADDED" << std::endl;)

  RQ_TO_CACHE++;
  return RQ.occupancy();
}

int CACHE::add_wq(PACKET* packet)
{
  WQ_ACCESS++;

  DP(if (warmup_complete[packet->cpu]) {
    std::cout << "[" << NAME << "_WQ] " << __func__ << " instr_id: " << packet->instr_id << " address: " << std::hex << (packet->address >> OFFSET_BITS);
    std::cout << " full_addr: " << packet->address << " v_address: " << packet->v_address << std::dec << " type: " << +packet->type
              << " occupancy: " << RQ.occupancy();
  })

  // check for duplicates in the write queue
  champsim::delay_queue<PACKET>::iterator found_wq = std::find_if(WQ.begin(), WQ.end(), eq_addr<PACKET>(packet->address, match_offset_bits ? 0 : OFFSET_BITS));

  if (found_wq != WQ.end()) {

    DP(if (warmup_complete[packet->cpu]) std::cout << " MERGED" << std::endl;)

    WQ_MERGED++;
    return 0; // merged index
  }

  // Check for room in the queue
  if (WQ.full()) {
    DP(if (warmup_complete[packet->cpu]) std::cout << " FULL" << std::endl;)

    ++WQ_FULL;
    return -2;
  }

  // if there is no duplicate, add it to the write queue
  if (warmup_complete[cpu])
    WQ.push_back(*packet);
  else
    WQ.push_back_ready(*packet);

  DP(if (warmup_complete[packet->cpu]) std::cout << " ADDED" << std::endl;)

  WQ_TO_CACHE++;
  WQ_ACCESS++;

  return WQ.occupancy();
}

int CACHE::prefetch_line(uint64_t pf_addr, bool fill_this_level, uint32_t prefetch_metadata)
{
  pf_requested++;

  PACKET pf_packet;
  pf_packet.type = PREFETCH;
  pf_packet.fill_level = (fill_this_level ? fill_level : lower_level->fill_level);
  pf_packet.pf_origin_level = fill_level;
  pf_packet.pf_metadata = prefetch_metadata;
  pf_packet.cpu = cpu;
  pf_packet.address = pf_addr;
  pf_packet.v_address = virtual_prefetch ? pf_addr : 0;

  if (virtual_prefetch) {
    if (!VAPQ.full()) {
      VAPQ.push_back(pf_packet);
      return 1;
    }
  } else {
    int result = add_pq(&pf_packet);
    if (result != -2) {
      if (result > 0)
        pf_issued++;
      return 1;
    }
  }

  return 0;
}

int CACHE::prefetch_line(uint64_t ip, uint64_t base_addr, uint64_t pf_addr, bool fill_this_level, uint32_t prefetch_metadata)
{
  static bool deprecate_printed = false;
  if (!deprecate_printed) {
    std::cout << "WARNING: The extended signature CACHE::prefetch_line(ip, "
                 "base_addr, pf_addr, fill_this_level, prefetch_metadata) is "
                 "deprecated."
              << std::endl;
    std::cout << "WARNING: Use CACHE::prefetch_line(pf_addr, fill_this_level, "
                 "prefetch_metadata) instead."
              << std::endl;
    deprecate_printed = true;
  }
  return prefetch_line(pf_addr, fill_this_level, prefetch_metadata);
}

void CACHE::va_translate_prefetches()
{
  // TEMPORARY SOLUTION: mark prefetches as translated after a fixed latency
  if (VAPQ.has_ready()) {
    VAPQ.front().address = vmem.va_to_pa(cpu, VAPQ.front().v_address).first;

    // move the translated prefetch over to the regular PQ
    int result = add_pq(&VAPQ.front());

    // remove the prefetch from the VAPQ
    if (result != -2)
      VAPQ.pop_front();

    if (result > 0)
      pf_issued++;
  }
}

int CACHE::add_pq(PACKET* packet)
{
  assert(packet->address != 0);
  PQ_ACCESS++;

  DP(if (warmup_complete[packet->cpu]) {
    std::cout << "[" << NAME << "_WQ] " << __func__ << " instr_id: " << packet->instr_id << " address: " << std::hex << (packet->address >> OFFSET_BITS);
    std::cout << " full_addr: " << packet->address << " v_address: " << packet->v_address << std::dec << " type: " << +packet->type
              << " occupancy: " << RQ.occupancy();
  })

  // check for the latest wirtebacks in the write queue
  champsim::delay_queue<PACKET>::iterator found_wq = std::find_if(WQ.begin(), WQ.end(), eq_addr<PACKET>(packet->address, match_offset_bits ? 0 : OFFSET_BITS));

  if (found_wq != WQ.end()) {

    DP(if (warmup_complete[packet->cpu]) std::cout << " MERGED_WQ" << std::endl;)

    packet->data = found_wq->data;
    for (auto ret : packet->to_return)
      ret->return_data(packet);

    WQ_FORWARD++;
    return -1;
  }

  // check for duplicates in the PQ
  auto found = std::find_if(PQ.begin(), PQ.end(), eq_addr<PACKET>(packet->address, OFFSET_BITS));
  if (found != PQ.end()) {
    DP(if (warmup_complete[packet->cpu]) std::cout << " MERGED_PQ" << std::endl;)

    found->fill_level = std::min(found->fill_level, packet->fill_level);
    packet_dep_merge(found->to_return, packet->to_return);

    PQ_MERGED++;
    return 0;
  }

  // check occupancy
  if (PQ.full()) {

    DP(if (warmup_complete[packet->cpu]) std::cout << " FULL" << std::endl;)

    PQ_FULL++;
    return -2; // cannot handle this request
  }

  // if there is no duplicate, add it to PQ
  if (warmup_complete[cpu])
    PQ.push_back(*packet);
  else
    PQ.push_back_ready(*packet);

  DP(if (warmup_complete[packet->cpu]) std::cout << " ADDED" << std::endl;)

  PQ_TO_CACHE++;
  return PQ.occupancy();
}

uint32_t CACHE::num_reserved_ways_in_state_3() {
  // Only need to reserve 4 untagged ways if TRH <= 32
  uint32_t max_reserve_ways = (RH_THRESHOLD/2 <= 16) ? 4 : 8;
  if (NUM_SET == 32768 && NUM_WAY == 12) {
    // 24 MB LLC, only need to reserve 1/3rd capacity
    max_reserve_ways = 4;
  }
  if (ART_LITE) {
    // LITE_CONFIG: 1 way allocated in state-3 (direct transition from s-0 -> s-3)
    assert(ART_MM);
    max_reserve_ways = 1;
  }
  return max_reserve_ways;
}

uint32_t CACHE::get_max_way(uint64_t set) {
  if (NAME != "LLC" || !ART_ENABLE) {
    return NUM_WAY;
  }
  else if (ART_1B) { // 1bit tracker
    return NUM_WAY - (per_set_tracker_state[set] ? 8 : 1);
  }
  else { // 2bit tracker
    // 0-1-2-8 ways reserved (4 is TRH <= 32)
    switch(per_set_tracker_state[set]) {
      case 0:
        return NUM_WAY;
      case 1:
        return (NUM_WAY - 1);
      case 2:
        return (NUM_WAY - 2);
      case 3: 
        return (NUM_WAY - num_reserved_ways_in_state_3());
      default:
        std::cout << "[WARNING] Unrecognized tracker state\n";
        return NUM_WAY;
    }
  }

}

void CACHE::free_up_ctr_ways(uint64_t set) {
  if (NAME != "LLC" || !ART_ENABLE) {
    return;
  }
  uint32_t max_way = get_max_way(set);
  for (uint32_t w = max_way; w < NUM_WAY; w++) {
    if (block[set * NUM_WAY + w].valid && block[set * NUM_WAY + w].dirty) {
      // writeback dirty way
      s_ctr_way_data_wb++;
      lower_level->rhActions.push_back(std::make_pair(block[set * NUM_WAY + w].address, RH_WRITE));
    }
    // invalidate way
    block[set * NUM_WAY + w].valid = false;
    block[set * NUM_WAY + w].dirty = false;
    block[set * NUM_WAY + w].address = 0;
  }
}

void CACHE::performRHActions() {
  if (all_warmup_complete <= NUM_CPUS)
    return;

  int max_actions = 2;

  for (auto it = lower_level->rhActions.begin(); it != lower_level->rhActions.end();) {
    assert(ART_ENABLE || HYDRA_ENABLE || IDEAL_TRACKER 
            || GRAPHENE_ENABLE || PARA_ENABLE || RAA_RFM_ENABLE);
    PACKET handle_pkt;

    handle_pkt.cpu = 0;
    handle_pkt.address = it->first;
    handle_pkt.data = 0;
    handle_pkt.instr_id = 0;
    handle_pkt.ip = 0;
    handle_pkt.type = it->second;
    if (it->second == RH_WRITE) {
      handle_pkt.fill_level = lower_level->fill_level;
      handle_pkt.to_return.clear();
      if (lower_level->add_wq(&handle_pkt) == -2)
        return;
    }
    else {
      handle_pkt.fill_level = fill_level;
      handle_pkt.to_return = {this};
      if (lower_level->get_occupancy(1, it->first) == lower_level->get_size(1, it->second))
        return;
      else
        lower_level->add_rq(&handle_pkt);
    }

    it = lower_level->rhActions.erase(it);
    max_actions--;
    if (max_actions == 0) {
      break;
    }
  } 
}

void CACHE::recvACTInfo() {
  if (all_warmup_complete <= NUM_CPUS)
    return;
  
  for (auto it = lower_level->ACTs.begin(); it != lower_level->ACTs.end();) {
    uint64_t ch = it->ch, ra = it->ra, ba = it->ba, ro = it->ro;
    uint64_t CRA_idx = ro * (DRAM_CHANNELS * DRAM_BANKS * DRAM_RANKS)
                        + ra * (DRAM_CHANNELS * DRAM_BANKS)
                        + ba * (DRAM_CHANNELS)
                        + ch;
    if (!RAA_RFM_ENABLE && (CRA_idx * DRAM_COLUMNS * BLOCK_SIZE) >= (MEM_BYTES - RESERVE_RH_CAPACITY)) {
      // Ignore accesses to RCT
      it = lower_level->ACTs.erase(it);
      continue;
    }
    if (!RAA_RFM_ENABLE && ro == -1) {
      // Ignore bank refresh notification
      it = lower_level->ACTs.erase(it);
      continue;
    }

    if (ART_ENABLE && (writes_available_this_cycle == 0 || reads_available_this_cycle == 0)) {
      // Don't have cache bandwidth, try next cycle...
      break;
    }
    if (ART_ENABLE) { // ART tracker
      writes_available_this_cycle--;
      reads_available_this_cycle--;
      s_num_ACT++;
      num_ACT++;
      if (isUniqRow[CRA_idx] == false) {
        s_uniq_rows_touched++;
      }
      isUniqRow[CRA_idx] = true;
      uint64_t set_idx = CRA_idx/rows_per_set;
      if (CRA_ctr[CRA_idx] == 0) { // New ctr required
        s_uniq_rows_ACT++;
        uniq_rows_ACT++;
        if (ART_1B) { // 1bit tracker
          if (CRA_ctr_set[set_idx] == ART_CTR_PER_WAY) { // transition from 1 to 8 ways
            assert(per_set_tracker_state[set_idx] == 0);
            per_set_tracker_state[set_idx] = 1;
            s_sets_in_state[1]++;
            sets_in_state[1]++;
            free_up_ctr_ways(set_idx); // WB dirty ways if any
          }
        }
        else { // 2bit tracker
          // If all ctr slots are occupied, perform way transition
          // Unless we are already in state-3, in which case no action required
          if ((CRA_ctr_set[set_idx] == 
              (NUM_WAY - get_max_way(set_idx)) * ART_CTR_PER_WAY) &&
              per_set_tracker_state[set_idx] < 3) {
                uint32_t curr_state = per_set_tracker_state[set_idx];
                // LITE_CONFIG: advance directly to state 3 (1 way allocated)
                uint32_t adv_next_state = (ART_LITE) ? 3 : 1;
                per_set_tracker_state[set_idx] += adv_next_state;
                s_sets_in_state[curr_state + adv_next_state]++;
                sets_in_state[curr_state + adv_next_state]++;
                free_up_ctr_ways(set_idx);
          }
        }
        // More ctrs in set than state-3 ways can hold: consult MTT
        if (ART_MM && CRA_ctr_set[set_idx] >= 
            num_reserved_ways_in_state_3() * ART_CTR_PER_WAY) {
          // Writeback (rd-mod-wr) dirty counter
          uint64_t op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + 2*CRA_idx;
          lower_level->rhActions.push_back(std::make_pair(op_addr, RH_UPDATE));
          // Fetch missing counter
          op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + 2*CRA_idx + 64;
          lower_level->rhActions.push_back(std::make_pair(op_addr, RH_READ));
          if (ART_LITE) {
            // LITE_CONFIG: Erase pseudo-random element from set of cached counters
            cachedCtrs[set_idx].erase(cachedCtrs[set_idx].begin());
          }
          s_mm_set_evicts++;
        }
        CRA_ctr_set[set_idx]++; // Update rows-per-set
        if (ART_LITE) {
          cachedCtrs[set_idx].insert(CRA_idx); // Insert new ctr in LLC set
          assert(cachedCtrs[set_idx].size() <= num_reserved_ways_in_state_3() * ART_CTR_PER_WAY);
        }
      }
      else if (ART_MM && CRA_ctr_set[set_idx] > 
                num_reserved_ways_in_state_3() * ART_CTR_PER_WAY) { // Consult MTT
        if (ART_LITE) { // LITE_CONFIG
          if (cachedCtrs[set_idx].find(CRA_idx) == cachedCtrs[set_idx].end()) {
            // Cache miss - writeback dirty counter
            uint64_t op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + 2*CRA_idx;
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_UPDATE));
            // Fetch missing counter
            op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + 2*CRA_idx + 64;
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_READ));
            s_mm_set_misses++;
            // LITE_CONFIG: Update LLC set cached counters (random evict, insert ctr)
            cachedCtrs[set_idx].erase(cachedCtrs[set_idx].begin());
            cachedCtrs[set_idx].insert(CRA_idx);
            assert(cachedCtrs[set_idx].size() == num_reserved_ways_in_state_3() * ART_CTR_PER_WAY);
          }
        }
        else {
          // Simulate ctr-cache misses and replacement (random eviction) probabilistically
          uint32_t randVal = std::rand() % CRA_ctr_set[set_idx]; 
          uint32_t numUncachedCtrs = CRA_ctr_set[set_idx] 
                                      - num_reserved_ways_in_state_3() * ART_CTR_PER_WAY;
          if (randVal < numUncachedCtrs) {
            // Cache miss - writeback dirty counter
            uint64_t op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + 2*CRA_idx;
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_UPDATE));
            // Fetch missing counter
            op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + 2*CRA_idx + 64;
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_READ));
            s_mm_set_misses++;
          }
        }
      }
      CRA_ctr[CRA_idx]++;
      if (CRA_ctr[CRA_idx] % (RH_THRESHOLD/2) == 0) { // Issue mitigation
        s_num_mits++;
        num_mits++;
        uint64_t op_addr;
        for (int i = 0; i < RH_BLAST_RADIUS; i++) {
          if (ro > i) {
            op_addr = BLOCK_SIZE * DRAM_COLUMNS * 
                      (ch + DRAM_CHANNELS * (ba + DRAM_BANKS * (ra + DRAM_RANKS * (ro - (i + 1)))));
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
          }
          if (ro < DRAM_ROWS - (i + 1)) {
            op_addr = BLOCK_SIZE * DRAM_COLUMNS * 
                      (ch + DRAM_CHANNELS * (ba + DRAM_BANKS * (ra + DRAM_RANKS * (ro + i + 1))));
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
          }
        }
      }
      if ((CRA_ctr[CRA_idx]-1)%10 == 0) { // Histogram
        row_ACT[CRA_ctr[CRA_idx]/10 > 99 ? 99 : CRA_ctr[CRA_idx]/10]++;
        s_row_ACT[CRA_ctr[CRA_idx]/10 > 99 ? 99 : CRA_ctr[CRA_idx]/10]++;
      }
    }
    else if (HYDRA_ENABLE) {
      uint64_t hydra_idx = CRA_idx;
      bool mitigate = lower_level->detector->access(hydra_idx, 0, 0, 0);
      uint64_t UpdateGrpIdx = lower_level->detector->RowGroupInitPenalty;
      uint64_t CacheCtrIdx = lower_level->detector->CtrRdPenalty;
      uint64_t DirtyCtrIdx = lower_level->detector->CtrMdPenalty;
      uint64_t op_addr = -1;
      if (mitigate) { // Issue mitigation
        //DEBUG std::cout << "[HYDRA] Mitigation reqd for idx " << hydra_idx << std::endl;
        for (int i = 0; i < RH_BLAST_RADIUS; i++) {
          if (ro > i) {
            op_addr = BLOCK_SIZE * DRAM_COLUMNS * 
                      (ch + DRAM_CHANNELS * (ba + DRAM_BANKS * (ra + DRAM_RANKS * (ro - (i + 1)))));
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
          }
          if (ro < DRAM_ROWS - (i + 1)) {
            op_addr = BLOCK_SIZE * DRAM_COLUMNS * 
                      (ch + DRAM_CHANNELS * (ba + DRAM_BANKS * (ra + DRAM_RANKS * (ro + i + 1))));
            lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
          }
        }
      }
      if (HYDRA_DO_MITS) {
        if (UpdateGrpIdx) { // row-group init in RCT
          // Row-group init -> rd-mod-wr operation (assume 1B counter)
          op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + UpdateGrpIdx;
          lower_level->rhActions.push_back(std::make_pair(op_addr, RH_UPDATE));
        }
        if (CacheCtrIdx) { // row-ctr miss, fetch from RCT
          op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + CacheCtrIdx;
          lower_level->rhActions.push_back(std::make_pair(op_addr, RH_READ));
        }
        if (DirtyCtrIdx) { // writeback dirty row-ctr in RCT
          op_addr = (MEM_BYTES - RESERVE_RH_CAPACITY) + DirtyCtrIdx;
          lower_level->rhActions.push_back(std::make_pair(op_addr, RH_UPDATE));
        }
      }
    }
    else if (GRAPHENE_ENABLE) {
      if (IP_ENABLE) {
        int effectiveACT = 1;
        if (it->tON != -1) {
          // rounding up tON
          effectiveACT = float(it->tON + it->tRC - 1)/float(it->tRC);
          s_mg_ip_rp_acts += effectiveACT;
        }
        while (effectiveACT) {
          s_mg_acts++;
          bool mitigate = lower_level->detector->access(ro, ba, ra, ch, false);
          if (mitigate) {
            s_mg_mits++;
            // Refresh neighbours: rorababgcoch or rohirababgchlo
            for (int i = 0; i < RH_BLAST_RADIUS; i++) {
              if (ro > i) {
                uint64_t op_addr = InverseAddressMapping(ro - (i + 1), ra, ba, ch);
                lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
              }
              if (ro < DRAM_ROWS - (i + 1)) {
                uint64_t op_addr = InverseAddressMapping(ro + i + 1, ra, ba, ch);
                lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
              }
            }
            break;
          }          
          effectiveACT--;
        }
      }
      else {
        if (it->tON != -1) {
          // std::cout << "ID-ACT recv for ch " << ch << " ra " << ra 
          //           << " ba " << ba  << " ro " << ro << std::endl;
          s_mg_id_rp_acts++;
        }
        s_mg_acts++;
        bool mitigate = lower_level->detector->access(ro, ba, ra, ch, false);
        if (mitigate) {
          s_mg_mits++;
          // Refresh neighbours: rorababgcoch or rohirababgchlo
          for (int i = 0; i < RH_BLAST_RADIUS; i++) {
            if (ro > i) {
              uint64_t op_addr = InverseAddressMapping(ro - (i + 1), ra, ba, ch);
              lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
            }
            if (ro < DRAM_ROWS - (i + 1)) {
              uint64_t op_addr = InverseAddressMapping(ro + i + 1, ra, ba, ch);
              lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
            }
          }
        }
      }
    }
    else if (PARA_ENABLE) {
      if (IP_ENABLE) {
        if (it->tON == -1) {
          // It's an activation, discard: we instead wait for IP-ACT
          s_para_acts++;
        }
        else {
          s_para_num_eacts++;
          // It's an IP-ACT, probabilistically send RFM 
          float effectiveACT = float(it->tON + it->tPRE)/float(it->tRC);
          s_para_sum_eacts += effectiveACT;
          int fullACTRounds = int(effectiveACT);
          float partialACTRound = effectiveACT - fullACTRounds;
          bool RFMSent = false;
          // std::cout << "IP-ACT EACT " << effectiveACT << std::endl;
          while (fullACTRounds) {
            if (mtrand->rand() < para_p) {
              s_para_mits++;
              // Refresh neighbours: rorababgcoch or rohirababgchlo
              for (int i = 0; i < RH_BLAST_RADIUS; i++) {
                if (ro > i) {
                  uint64_t op_addr = InverseAddressMapping(ro - (i + 1), ra, ba, ch);
                  lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
                }
                if (ro < DRAM_ROWS - (i + 1)) {
                  uint64_t op_addr = InverseAddressMapping(ro + i + 1, ra, ba, ch);
                  lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
                }
              }
              RFMSent = true;
              break;
            }
            fullACTRounds--;
          }
          if (RFMSent == false && mtrand->rand() < para_p * partialACTRound) {
            s_para_mits++;
            // Refresh neighbours: rorababgcoch or rohirababgchlo
            for (int i = 0; i < RH_BLAST_RADIUS; i++) {
              if (ro > i) {
                uint64_t op_addr = InverseAddressMapping(ro - (i + 1), ra, ba, ch);
                lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
              }
              if (ro < DRAM_ROWS - (i + 1)) {
                uint64_t op_addr = InverseAddressMapping(ro + i + 1, ra, ba, ch);
                lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
              }
            }
          }
        }
      }
      else {
        s_para_acts++;
        if (it->tON != -1) {
          // It's ID-ACT
          s_para_sum_eacts++;
        }
        if (mtrand->rand() < para_p) {
          s_para_mits++;
            // Refresh neighbours: rorababgcoch or rohirababgchlo
            for (int i = 0; i < RH_BLAST_RADIUS; i++) {
              if (ro > i) {
                uint64_t op_addr = InverseAddressMapping(ro - (i + 1), ra, ba, ch);
                lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
              }
              if (ro < DRAM_ROWS - (i + 1)) {
                uint64_t op_addr = InverseAddressMapping(ro + i + 1, ra, ba, ch);
                lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
              }
            }
        }
      }
    }
    else if (RAA_RFM_ENABLE) {
      // std::cout << "RAA ch " << ch << " ra " << ra << " ba " << ba  << " ro " << ro << std::endl;
      if (ro == -1 && ba == -1) {
        // std::cout << "RAA-REF ch " << ch << " ra " << ra << " ba " << ba << " ro " << ro << std::endl;
        // it's a refresh
        for (int i = 0; i < DRAM_BANKS; i++) {
          if (raa_ctr[ch][ra][i] < REF_TH)
            raa_ctr[ch][ra][i] = 0;
          else 
            raa_ctr[ch][ra][i] -= REF_TH;
        }
      }
      else {
        // it's an ACT
        raa_ctr[ch][ra][ba]++;
        if (raa_ctr[ch][ra][ba] >= RFM_TH) {
          raa_ctr[ch][ra][ba] -= RFM_TH;
          lower_level->SendRFM(ba, ra, ch);
        }
      }
    }
    else { // Record basic stats and implement IT mitigations if required
      s_num_ACT++;
      num_ACT++;
      if (isUniqRow[CRA_idx] == false) {
        s_uniq_rows_touched++;
      }
      isUniqRow[CRA_idx] = true;
      if (CRA_ctr[CRA_idx] == 0) { 
        s_uniq_rows_ACT++;
        uniq_rows_ACT++;
      }
      CRA_ctr[CRA_idx]++;
      if (CRA_ctr[CRA_idx] % (RH_THRESHOLD/2) == 0) {
        s_num_mits++;
        num_mits++;
        if (IDEAL_TRACKER) { // IT launches mitigations
          uint64_t op_addr = -1;
          for (int i = 0; i < RH_BLAST_RADIUS; i++) {
            if (ro > i) {
              op_addr = BLOCK_SIZE * DRAM_COLUMNS * 
                        (ch + DRAM_CHANNELS * (ba + DRAM_BANKS * (ra + DRAM_RANKS * (ro - (i + 1)))));
              lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
            }
            if (ro < DRAM_ROWS - (i + 1)) {
              op_addr = BLOCK_SIZE * DRAM_COLUMNS * 
                        (ch + DRAM_CHANNELS * (ba + DRAM_BANKS * (ra + DRAM_RANKS * (ro + i + 1))));
              lower_level->rhActions.push_back(std::make_pair(op_addr, RH_MITIGATION));
            }
          }
        }
      }
      if ((CRA_ctr[CRA_idx]-1)%10 == 0) {
        row_ACT[CRA_ctr[CRA_idx]/10 > 99 ? 99 : CRA_ctr[CRA_idx]/10]++;
        s_row_ACT[CRA_ctr[CRA_idx]/10 > 99 ? 99 : CRA_ctr[CRA_idx]/10]++;
      }
    }
    it = lower_level->ACTs.erase(it);
  }
}

void CACHE::return_data(PACKET* packet)
{
  if (NAME == "LLC") {
    if (packet->type == RH_MITIGATION)
      return;
    else if (packet->type == RH_UPDATE) {
      lower_level->rhActions.push_back(std::make_pair(packet->address, RH_WRITE));
      return;
    }
    else if (packet->type == RH_READ) 
      return;
    else if (packet->type == RH_WRITE)
      assert(0);
  }
  // check MSHR information
  auto mshr_entry = std::find_if(MSHR.begin(), MSHR.end(), eq_addr<PACKET>(packet->address, OFFSET_BITS));
  auto first_unreturned = std::find_if(MSHR.begin(), MSHR.end(), [](auto x) { return x.event_cycle == std::numeric_limits<uint64_t>::max(); });

  // sanity check
  if (mshr_entry == MSHR.end()) {
    std::cerr << "[" << NAME << "_MSHR] " << __func__ << " instr_id: " << packet->instr_id << " cannot find a matching entry!";
    std::cerr << " address: " << std::hex << packet->address;
    std::cerr << " v_address: " << packet->v_address;
    std::cerr << " address: " << (packet->address >> OFFSET_BITS) << std::dec;
    std::cerr << " event: " << packet->event_cycle << " current: " << current_cycle << std::endl;
    assert(0);
  }

  // MSHR holds the most updated information about this request
  mshr_entry->data = packet->data;
  mshr_entry->pf_metadata = packet->pf_metadata;
  mshr_entry->event_cycle = current_cycle + (warmup_complete[cpu] ? FILL_LATENCY : 0);

  if (NAME == "LLC" && BLOCKHAMMER && all_warmup_complete > NUM_CPUS) {
    uint64_t delay = 0;
    if (CRA_ctr[packet->address/(DRAM_COLUMNS * BLOCK_SIZE)] > (RH_THRESHOLD/4)) {
      uint64_t diff = CRA_ctr[packet->address/(DRAM_COLUMNS * BLOCK_SIZE)] - (RH_THRESHOLD/4);
      uint64_t est_start_time = last_tracker_reset + ((diff - 1) * (256*1000*1000ull)/(RH_THRESHOLD/4));
      if (est_start_time > current_cycle) {
        delay = est_start_time - current_cycle;
        if (delay >= (256*1000*1000)) {
          std::cout << "[PANIC] Delay of more than 64ms in BH! curr_cycle: " << current_cycle
                    << " est_start: " << est_start_time << " delay: " << delay
                    << " CRA_ctr: " << CRA_ctr[packet->address/(DRAM_COLUMNS * BLOCK_SIZE)] << std::endl;
          delay = 8000000ul; // Max delay of 8 Mn cycles (2ms which is max theoretical delay at T=128)
        }
      }
    }
    if (delay) {
      s_BH_num_delay++;
      s_BH_sum_delay += delay;
      s_BH_max_delay = (s_BH_max_delay > delay) ? s_BH_max_delay : delay;
      mshr_entry->event_cycle = current_cycle + delay;
    }
  }

  DP(if (warmup_complete[packet->cpu]) {
    std::cout << "[" << NAME << "_MSHR] " << __func__ << " instr_id: " << mshr_entry->instr_id;
    std::cout << " address: " << std::hex << (mshr_entry->address >> OFFSET_BITS) << " full_addr: " << mshr_entry->address;
    std::cout << " data: " << mshr_entry->data << std::dec;
    std::cout << " index: " << std::distance(MSHR.begin(), mshr_entry) << " occupancy: " << get_occupancy(0, 0);
    std::cout << " event: " << mshr_entry->event_cycle << " current: " << current_cycle << std::endl;
  });

  // Order this entry after previously-returned entries, but before non-returned
  // entries
  std::iter_swap(mshr_entry, first_unreturned);
}

uint32_t CACHE::get_occupancy(uint8_t queue_type, uint64_t address)
{
  if (queue_type == 0)
    return std::count_if(MSHR.begin(), MSHR.end(), is_valid<PACKET>());
  else if (queue_type == 1)
    return RQ.occupancy();
  else if (queue_type == 2)
    return WQ.occupancy();
  else if (queue_type == 3)
    return PQ.occupancy();

  return 0;
}

uint32_t CACHE::get_size(uint8_t queue_type, uint64_t address)
{
  if (queue_type == 0)
    return MSHR_SIZE;
  else if (queue_type == 1)
    return RQ.size();
  else if (queue_type == 2)
    return WQ.size();
  else if (queue_type == 3)
    return PQ.size();

  return 0;
}

bool CACHE::should_activate_prefetcher(int type) { return (1 << static_cast<int>(type)) & pref_activate_mask; }

void CACHE::print_deadlock()
{
  if (!std::empty(MSHR)) {
    std::cout << NAME << " MSHR Entry" << std::endl;
    std::size_t j = 0;
    for (PACKET entry : MSHR) {
      std::cout << "[" << NAME << " MSHR] entry: " << j++ << " instr_id: " << entry.instr_id;
      std::cout << " address: " << std::hex << (entry.address >> LOG2_BLOCK_SIZE) << " full_addr: " 
      << entry.address << std::dec << " type: " << +entry.type;
      std::cout << " fill_level: " << +entry.fill_level << " event_cycle: " << entry.event_cycle << std::endl;
    }
  } else {
    std::cout << NAME << " MSHR empty" << std::endl;
  }
}

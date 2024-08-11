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

#include <algorithm>
#include <array>
#include <fstream>
#include <functional>
#include <getopt.h>
#include <iomanip>
#include <signal.h>
#include <string.h>
#include <vector>

#include "cache.h"
#include "champsim.h"
#include "champsim_constants.h"
// #include "dram_controller.h"
#include "dramsim3_wrapper.hpp"
#include "ooo_cpu.h"
#include "operable.h"
#include "tracereader.h"
#include "vmem.h"

uint8_t warmup_complete[NUM_CPUS] = {}, simulation_complete[NUM_CPUS] = {}, all_warmup_complete = 0, all_simulation_complete = 0,
        MAX_INSTR_DESTINATIONS = NUM_INSTR_DESTINATIONS, knob_cloudsuite = 0, knob_low_bandwidth = 0;

char knob_cs_traces[NUM_CPUS] = {'n'};

uint64_t warmup_instructions = 1000000, simulation_instructions = 10000000;

auto start_time = time(NULL);

// For backwards compatibility with older module source.
champsim::deprecated_clock_cycle current_core_cycle;

// extern MEMORY_CONTROLLER DRAM;
extern DRAMSim3_DRAM DRAM;
extern VirtualMemory vmem;
extern std::array<O3_CPU*, NUM_CPUS> ooo_cpu;
extern std::array<CACHE*, NUM_CACHES> caches;
extern std::array<champsim::operable*, NUM_OPERABLES> operables;

std::vector<tracereader*> traces;

uint64_t champsim::deprecated_clock_cycle::operator[](std::size_t cpu_idx)
{
  static bool deprecate_printed = false;
  if (!deprecate_printed) {
    std::cout << "WARNING: The use of 'current_core_cycle[cpu]' is deprecated." << std::endl;
    std::cout << "WARNING: Use 'this->current_cycle' instead." << std::endl;
    deprecate_printed = true;
  }
  return ooo_cpu[cpu_idx]->current_cycle;
}

void record_roi_stats(uint32_t cpu, CACHE* cache)
{
  for (uint32_t i = 0; i < NUM_TYPES; i++) {
    cache->roi_access[cpu][i] = cache->sim_access[cpu][i];
    cache->roi_hit[cpu][i] = cache->sim_hit[cpu][i];
    cache->roi_miss[cpu][i] = cache->sim_miss[cpu][i];
  }
}

void print_roi_stats(uint32_t cpu, CACHE* cache)
{
  uint64_t TOTAL_ACCESS = 0, TOTAL_HIT = 0, TOTAL_MISS = 0;

  for (uint32_t i = 0; i < NUM_TYPES; i++) {
    TOTAL_ACCESS += cache->roi_access[cpu][i];
    TOTAL_HIT += cache->roi_hit[cpu][i];
    TOTAL_MISS += cache->roi_miss[cpu][i];
  }

  if (TOTAL_ACCESS > 0) {
    cout << cache->NAME;
    cout << " TOTAL     ACCESS: " << setw(10) << TOTAL_ACCESS << "  HIT: " << setw(10) << TOTAL_HIT << "  MISS: " << setw(10) << TOTAL_MISS << endl;

    cout << cache->NAME;
    cout << " LOAD      ACCESS: " << setw(10) << cache->roi_access[cpu][0] << "  HIT: " << setw(10) << cache->roi_hit[cpu][0] << "  MISS: " << setw(10)
         << cache->roi_miss[cpu][0] << endl;

    cout << cache->NAME;
    cout << " RFO       ACCESS: " << setw(10) << cache->roi_access[cpu][1] << "  HIT: " << setw(10) << cache->roi_hit[cpu][1] << "  MISS: " << setw(10)
         << cache->roi_miss[cpu][1] << endl;

    cout << cache->NAME;
    cout << " PREFETCH  ACCESS: " << setw(10) << cache->roi_access[cpu][2] << "  HIT: " << setw(10) << cache->roi_hit[cpu][2] << "  MISS: " << setw(10)
         << cache->roi_miss[cpu][2] << endl;

    cout << cache->NAME;
    cout << " WRITEBACK ACCESS: " << setw(10) << cache->roi_access[cpu][3] << "  HIT: " << setw(10) << cache->roi_hit[cpu][3] << "  MISS: " << setw(10)
         << cache->roi_miss[cpu][3] << endl;

    cout << cache->NAME;
    cout << " TRANSLATION ACCESS: " << setw(10) << cache->roi_access[cpu][4] << "  HIT: " << setw(10) << cache->roi_hit[cpu][4] << "  MISS: " << setw(10)
         << cache->roi_miss[cpu][4] << endl;

    cout << cache->NAME;
    cout << " PREFETCH  REQUESTED: " << setw(10) << cache->pf_requested << "  ISSUED: " << setw(10) << cache->pf_issued;
    cout << "  USEFUL: " << setw(10) << cache->pf_useful << "  USELESS: " << setw(10) << cache->pf_useless << endl;

    cout << cache->NAME;
    cout << " AVERAGE MISS LATENCY: " << (1.0 * (cache->total_miss_latency)) / TOTAL_MISS << " cycles" << endl;
  }
  if (cache->NAME == "LLC" && cpu == NUM_CPUS - 1) {
    std::cout << std::endl;
    uint64_t llc_misses = 0;
    for (uint32_t i = 0; i < NUM_TYPES; i++) 
      for (uint j = 0; j < NUM_CPUS; j++)
        llc_misses += cache->roi_miss[j][i];
    std::cout << "LLC_MPKI " << (llc_misses*1000.0)/(simulation_instructions*NUM_CPUS) << std::endl;

    float ipc = 0;
    for (uint32_t i = 0; i < NUM_CPUS; i++) {
      float core_ipc = ((float)ooo_cpu[i]->finish_sim_instr / ooo_cpu[i]->finish_sim_cycle);
      ipc += core_ipc;
      std::cout << "CORE_" << i << "_SIM_IPC " << core_ipc << std::endl;
    }
    std::cout << "SYSTEM_IPC " << ipc/(NUM_CPUS * 1.0) << std::endl;
    
    uint64_t avg_uniq_rows = cache->s_uniq_rows_ACT, avg_num_act = cache->s_num_ACT,
              avg_num_mits = cache->s_num_mits;
    uint64_t avg_sets_in_state[4];
    if (cache->s_resets > 0) {
      avg_uniq_rows = (cache->s_uniq_rows_ACT - cache->uniq_rows_ACT)/(cache->s_resets);
      avg_num_act = (cache->s_num_ACT - cache->num_ACT)/(cache->s_resets);
      avg_num_mits = (cache->s_num_mits - cache->num_mits)/(cache->s_resets);
      for (int i = 1; i < 4; i++) {
        avg_sets_in_state[i] = (cache->s_sets_in_state[i] - cache->sets_in_state[i])/(cache->s_resets);
      }
    }
    else {
      for (int i = 1; i < 4; i++) {
        avg_sets_in_state[i] = cache->sets_in_state[i];
      }
    }
    float avg_ways_used = 0.0;
    if (ART_1B) {
      avg_ways_used += cache->NUM_SET + 7*avg_sets_in_state[1];
      avg_ways_used /= (cache->NUM_SET);
    }
    else {
      avg_ways_used += cache->NUM_SET + 1*(avg_sets_in_state[1] - avg_sets_in_state[2])
                       + 3*(avg_sets_in_state[2] - avg_sets_in_state[3]) + 7*avg_sets_in_state[3];
      avg_ways_used /= (cache->NUM_SET);
    }

    cout << std::endl << "ROWHAMMER_DEFENSE_STATS" << std::endl;
    cout << "LLC_RH_RESETS " << cache->s_resets << std::endl;
    cout << "LLC_RH_UNIQ_ROWS_TOUCHED " << cache->s_uniq_rows_touched << std::endl;
    cout << "LLC_RH_AVG_WAYS_USED " << avg_ways_used << std::endl;
    for (int i = 1; i < 4; i++) {
      cout << "LLC_RH_TOT_SETS_IN_STATE_" << i << " " << cache->s_sets_in_state[i]<< std::endl;
      cout << "LLC_RH_AVG_SETS_IN_STATE_" << i << " " << avg_sets_in_state[i] << std::endl;
      cout << "LLC_RH_CUR_SETS_IN_STATE_" << i << " " << cache->sets_in_state[i] << std::endl;
    }
    cout << "LLC_RH_TOT_UNIQ_ROWS " << cache->s_uniq_rows_ACT << std::endl;
    cout << "LLC_RH_AVG_UNIQ_ROWS " << avg_uniq_rows << std::endl;
    cout << "LLC_RH_CUR_UNIQ_ROWS " << cache->uniq_rows_ACT << std::endl;
    cout << "LLC_RH_TOT_NUM_ACT " << cache->s_num_ACT << std::endl;
    cout << "LLC_RH_AVG_NUM_ACT " << avg_num_act << std::endl;
    cout << "LLC_RH_CUR_NUM_ACT " << cache->num_ACT << std::endl;
    cout << "LLC_RH_TOT_NUM_MIT " << cache->s_num_mits << std::endl;
    cout << "LLC_RH_AVG_NUM_MIT " << avg_num_mits << std::endl;
    cout << "LLC_RH_CUR_NUM_MIT " << cache->num_mits << std::endl;
    cout << "LLC_RH_MM_SET_EVICTS " << cache->s_mm_set_evicts << std::endl;
    cout << "LLC_RH_MM_SET_MISSES " << cache->s_mm_set_misses << std::endl;
    cout << std::endl;
    for (int i = 0; i < 100; i++) {
      cout << "LLC_RH_TOT_ROW_ACT_HIST_" << i*10+1 << " " << cache->s_row_ACT[i] << std::endl;
    }
    cout << std::endl;
    if (cache->s_resets > 0) {
      for (int i = 0; i < 100; i++) {
        cout << "LLC_RH_AVG_ROW_ACT_HIST_" << i*10+1 << " " 
              << (cache->s_row_ACT[i] - cache->row_ACT[i])/(cache->s_resets) << std::endl;
      }
    }
    cout << std::endl;
    for (int i = 0; i < 100; i++) {
      cout << "LLC_RH_CUR_ROW_ACT_HIST_" << i*10+1 << " " << cache->row_ACT[i] << std::endl;
    }
    cout << std::endl;
    cout << "LLC_EARLY_WRITEBACKS " << cache->s_early_writebacks << std::endl;
    cout << "LLC_CTR_WAY_DATA_WB " << cache->s_ctr_way_data_wb << std::endl;
    cout << "VMEM_PROC_PPAGES " << vmem.s_proc_ppages_used << std::endl;
    cout << "VMEM_PT_PPAGES " << vmem.s_pt_ppages_used << std::endl;
    cout << "DRAM_PPAGES_TOUCHED " 
         << std::count(DRAM.procPageAccess, DRAM.procPageAccess + DRAM.numPPages, true) << std::endl;
    cout << "DRAM_ACTS_OCC " << DRAM.ACTs.size() << std::endl;
    cout << "DRAM_RHACTIONS_OCC " << DRAM.rhActions.size() << std::endl;
    cout << std::endl << std::endl;
    cout << "RH_BH_NUM_DELAY " << cache->s_BH_num_delay << std::endl;
    cout << "RH_BH_SUM_DEAY " << cache->s_BH_sum_delay << std::endl;
    cout << "RH_BH_MAX_DELAY " << cache->s_BH_max_delay << std::endl;
    cout << "RH_MG_ID_RP_ACTS " << cache->s_mg_id_rp_acts << std::endl;
    cout << "RH_MG_IP_RP_ACTS " << cache->s_mg_ip_rp_acts << std::endl;
    cout << "RH_MG_ACTS " << cache->s_mg_acts << std::endl;
    cout << "RH_MG_MITS " << cache->s_mg_mits << std::endl;
    cout << "RH_PARA_ACTS " << cache->s_para_acts << std::endl;
    cout << "RH_PARA_MITS " << cache->s_para_mits << std::endl;
    cout << "RH_PARA_NUM_EACTS " << cache->s_para_num_eacts << std::endl;
    cout << "RH_PARA_SUM_EACTS " << cache->s_para_sum_eacts << std::endl;
    if (HYDRA_ENABLE || GRAPHENE_ENABLE)
      cache->lower_level->detector->print_stats();
  }
}

void print_sim_stats(uint32_t cpu, CACHE* cache)
{
  uint64_t TOTAL_ACCESS = 0, TOTAL_HIT = 0, TOTAL_MISS = 0;

  for (uint32_t i = 0; i < NUM_TYPES; i++) {
    TOTAL_ACCESS += cache->sim_access[cpu][i];
    TOTAL_HIT += cache->sim_hit[cpu][i];
    TOTAL_MISS += cache->sim_miss[cpu][i];
  }

  if (TOTAL_ACCESS > 0) {
    cout << cache->NAME;
    cout << " TOTAL     ACCESS: " << setw(10) << TOTAL_ACCESS << "  HIT: " << setw(10) << TOTAL_HIT << "  MISS: " << setw(10) << TOTAL_MISS << endl;

    cout << cache->NAME;
    cout << " LOAD      ACCESS: " << setw(10) << cache->sim_access[cpu][0] << "  HIT: " << setw(10) << cache->sim_hit[cpu][0] << "  MISS: " << setw(10)
         << cache->sim_miss[cpu][0] << endl;

    cout << cache->NAME;
    cout << " RFO       ACCESS: " << setw(10) << cache->sim_access[cpu][1] << "  HIT: " << setw(10) << cache->sim_hit[cpu][1] << "  MISS: " << setw(10)
         << cache->sim_miss[cpu][1] << endl;

    cout << cache->NAME;
    cout << " PREFETCH  ACCESS: " << setw(10) << cache->sim_access[cpu][2] << "  HIT: " << setw(10) << cache->sim_hit[cpu][2] << "  MISS: " << setw(10)
         << cache->sim_miss[cpu][2] << endl;

    cout << cache->NAME;
    cout << " WRITEBACK ACCESS: " << setw(10) << cache->sim_access[cpu][3] << "  HIT: " << setw(10) << cache->sim_hit[cpu][3] << "  MISS: " << setw(10)
         << cache->sim_miss[cpu][3] << endl;
  }
}

void print_branch_stats()
{
  for (uint32_t i = 0; i < NUM_CPUS; i++) {
    cout << endl << "CPU " << i << " Branch Prediction Accuracy: ";
    cout << (100.0 * (ooo_cpu[i]->num_branch - ooo_cpu[i]->branch_mispredictions)) / ooo_cpu[i]->num_branch;
    cout << "% MPKI: " << (1000.0 * ooo_cpu[i]->branch_mispredictions) / (ooo_cpu[i]->num_retired - warmup_instructions);
    cout << " Average ROB Occupancy at Mispredict: " << (1.0 * ooo_cpu[i]->total_rob_occupancy_at_branch_mispredict) / ooo_cpu[i]->branch_mispredictions
         << endl;

    cout << "Branch type MPKI" << endl;
    cout << "BRANCH_DIRECT_JUMP: " << (1000.0 * ooo_cpu[i]->branch_type_misses[1] / (ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr)) << endl;
    cout << "BRANCH_INDIRECT: " << (1000.0 * ooo_cpu[i]->branch_type_misses[2] / (ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr)) << endl;
    cout << "BRANCH_CONDITIONAL: " << (1000.0 * ooo_cpu[i]->branch_type_misses[3] / (ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr)) << endl;
    cout << "BRANCH_DIRECT_CALL: " << (1000.0 * ooo_cpu[i]->branch_type_misses[4] / (ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr)) << endl;
    cout << "BRANCH_INDIRECT_CALL: " << (1000.0 * ooo_cpu[i]->branch_type_misses[5] / (ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr)) << endl;
    cout << "BRANCH_RETURN: " << (1000.0 * ooo_cpu[i]->branch_type_misses[6] / (ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr)) << endl << endl;
  }
}

// void print_dram_stats()
// {
//   uint64_t total_congested_cycle = 0;
//   uint64_t total_congested_count = 0;

//   std::cout << std::endl;
//   std::cout << "DRAM Statistics" << std::endl;
//   for (uint32_t i = 0; i < DRAM_CHANNELS; i++) {
//     std::cout << " CHANNEL " << i << std::endl;

//     auto& channel = DRAM.channels[i];
//     std::cout << " RQ ROW_BUFFER_HIT: " << std::setw(10) << channel.RQ_ROW_BUFFER_HIT << " ";
//     std::cout << " ROW_BUFFER_MISS: " << std::setw(10) << channel.RQ_ROW_BUFFER_MISS;
//     std::cout << std::endl;

//     std::cout << " DBUS AVG_CONGESTED_CYCLE: ";
//     if (channel.dbus_count_congested)
//       std::cout << std::setw(10) << ((double)channel.dbus_cycle_congested / channel.dbus_count_congested);
//     else
//       std::cout << "-";
//     std::cout << std::endl;

//     std::cout << " WQ ROW_BUFFER_HIT: " << std::setw(10) << channel.WQ_ROW_BUFFER_HIT << " ";
//     std::cout << " ROW_BUFFER_MISS: " << std::setw(10) << channel.WQ_ROW_BUFFER_MISS << " ";
//     std::cout << " FULL: " << std::setw(10) << channel.WQ_FULL;
//     std::cout << std::endl;

//     std::cout << std::endl;

//     total_congested_cycle += channel.dbus_cycle_congested;
//     total_congested_count += channel.dbus_count_congested;
//   }

//   uint64_t uniqRows = 0;
//   for (int ch = 0; ch < DRAM_CHANNELS; ch++) {
//     for (int ra = 0; ra < DRAM_RANKS; ra++) {
//       for (int ba = 0; ba < DRAM_BANKS; ba++) {
//         for (int ro = 0; ro < DRAM_ROWS; ro++) {
//           if (DRAM.isUniqRowCheck[ch][ra][ba][ro])
//             uniqRows++;
//         }
//       }
//     }
//   }
//   std::cout << "RH_UNIQ_ROWS_CHECK " << uniqRows << std::endl;
//   std::cout << "DRAM_RQ_MERGED " << DRAM.s_rq_merged << std::endl;
//   std::cout << "DRAM_RQ_FORWARDED " << DRAM.s_rq_forwarded << std::endl;
//   std::cout << "DRAM_WQ_DUPLICATES " << DRAM.s_wq_duplicates << std::endl;

//   if (DRAM_CHANNELS > 1) {
//     std::cout << " DBUS AVG_CONGESTED_CYCLE: ";
//     if (total_congested_count)
//       std::cout << std::setw(10) << ((double)total_congested_cycle / total_congested_count);
//     else
//       std::cout << "-";

//     std::cout << std::endl;
//   }
// }

void reset_cache_stats(uint32_t cpu, CACHE* cache)
{
  for (uint32_t i = 0; i < NUM_TYPES; i++) {
    cache->sim_access[cpu][i] = 0;
    cache->sim_hit[cpu][i] = 0;
    cache->sim_miss[cpu][i] = 0;
  }

  cache->pf_requested = 0;
  cache->pf_issued = 0;
  cache->pf_useful = 0;
  cache->pf_useless = 0;
  cache->pf_fill = 0;

  cache->total_miss_latency = 0;

  cache->RQ_ACCESS = 0;
  cache->RQ_MERGED = 0;
  cache->RQ_TO_CACHE = 0;

  cache->WQ_ACCESS = 0;
  cache->WQ_MERGED = 0;
  cache->WQ_TO_CACHE = 0;
  cache->WQ_FORWARD = 0;
  cache->WQ_FULL = 0;
}

void finish_warmup()
{
  uint64_t elapsed_second = (uint64_t)(time(NULL) - start_time), elapsed_minute = elapsed_second / 60, elapsed_hour = elapsed_minute / 60;
  elapsed_minute -= elapsed_hour * 60;
  elapsed_second -= (elapsed_hour * 3600 + elapsed_minute * 60);

  // reset core latency
  // note: since re-ordering he function calls in the main simulation loop, it's
  // no longer necessary to add
  //       extra latency for scheduling and execution, unless you want these
  //       steps to take longer than 1 cycle.
  // PAGE_TABLE_LATENCY = 100;
  // SWAP_LATENCY = 100000;

  cout << endl;
  for (uint32_t i = 0; i < NUM_CPUS; i++) {
    cout << "Warmup complete CPU " << i << " instructions: " << ooo_cpu[i]->num_retired << " cycles: " << ooo_cpu[i]->current_cycle;
    cout << " (Simulation time: " << elapsed_hour << " hr " << elapsed_minute << " min " << elapsed_second << " sec) " << endl;

    ooo_cpu[i]->begin_sim_cycle = ooo_cpu[i]->current_cycle;
    ooo_cpu[i]->begin_sim_instr = ooo_cpu[i]->num_retired;

    // reset branch stats
    ooo_cpu[i]->num_branch = 0;
    ooo_cpu[i]->branch_mispredictions = 0;
    ooo_cpu[i]->total_rob_occupancy_at_branch_mispredict = 0;

    for (uint32_t j = 0; j < 8; j++) {
      ooo_cpu[i]->total_branch_types[j] = 0;
      ooo_cpu[i]->branch_type_misses[j] = 0;
    }

    for (auto it = caches.rbegin(); it != caches.rend(); ++it)
      reset_cache_stats(i, *it);
  }
  cout << endl;

  // // reset DRAM stats
  // for (uint32_t i = 0; i < DRAM_CHANNELS; i++) {
  //   DRAM.channels[i].WQ_ROW_BUFFER_HIT = 0;
  //   DRAM.channels[i].WQ_ROW_BUFFER_MISS = 0;
  //   DRAM.channels[i].RQ_ROW_BUFFER_HIT = 0;
  //   DRAM.channels[i].RQ_ROW_BUFFER_MISS = 0;
  // }
}

void signal_handler(int signal)
{
  cout << "Caught signal: " << signal << endl;
  exit(1);
}

int main(int argc, char** argv)
{
  // interrupt signal hanlder
  struct sigaction sigIntHandler;
  sigIntHandler.sa_handler = signal_handler;
  sigemptyset(&sigIntHandler.sa_mask);
  sigIntHandler.sa_flags = 0;
  sigaction(SIGINT, &sigIntHandler, NULL);

  cout << endl << "*** ChampSim Multicore Out-of-Order Simulator ***" << endl << endl;

  // initialize knobs
  uint8_t show_heartbeat = 1;

  // check to see if knobs changed using getopt_long()
  int traces_encountered = 0;
  static struct option long_options[] = {{"warmup_instructions", required_argument, 0, 'w'},
                                         {"simulation_instructions", required_argument, 0, 'i'},
                                         {"hide_heartbeat", no_argument, 0, 'h'},
                                         {"cloudsuite", no_argument, 0, 'c'},
                                         {"traces", no_argument, &traces_encountered, 1},
                                         {"cs_traces", required_argument, 0, 's'},
                                         {0, 0, 0, 0}};

  int c;
  while ((c = getopt_long_only(argc, argv, "w:i:hc", long_options, NULL)) != -1 && !traces_encountered) {
    switch (c) {
    case 'w':
      warmup_instructions = atol(optarg);
      break;
    case 'i':
      simulation_instructions = atol(optarg);
      break;
    case 'h':
      show_heartbeat = 0;
      break;
    case 'c':
      knob_cloudsuite = 1;
      for (uint64_t i = 0; i < NUM_CPUS; i++)
        knob_cs_traces[i] = 'y';
      MAX_INSTR_DESTINATIONS = NUM_INSTR_DESTINATIONS_SPARC;
      break;
    case 's':
      for (uint64_t i = 0; i < NUM_CPUS; i++) 
        knob_cs_traces[i] = optarg[i];
      break;
    case 0:
      break;
    default:
      abort();
    }
  }

  cout << "Warmup Instructions: " << warmup_instructions << endl;
  cout << "Simulation Instructions: " << simulation_instructions << endl;
  cout << "Number of CPUs: " << NUM_CPUS << endl;
  cout << "knob_cs_traces: " << string(knob_cs_traces) << endl;

  long long int dram_size = DRAM_CHANNELS * DRAM_RANKS * DRAM_BANKS * DRAM_ROWS * DRAM_COLUMNS * BLOCK_SIZE / 1024 / 1024; // in MiB
  std::cout << "Off-chip DRAM Size: ";
  if (dram_size > 1024)
    std::cout << dram_size / 1024 << " GiB";
  else
    std::cout << dram_size << " MiB";
  std::cout << " Channels: " << DRAM_CHANNELS << " Width: " << 8 * DRAM_CHANNEL_WIDTH 
            << "-bit Data Rate: " << 2*DRAM_IO_FREQ << " MT/s" << std::endl;

  std::cout << std::endl;
  std::cout << "VirtualMemory physical capacity: " << std::size(vmem.ppage_free_list) * vmem.page_size;
  std::cout << " num_ppages: " << std::size(vmem.ppage_free_list) << std::endl;
  std::cout << "VirtualMemory page size: " << PAGE_SIZE << " log2_page_size: " << LOG2_PAGE_SIZE << std::endl;

  std::cout << std::endl;
  if (argc - optind == NUM_CPUS) {
    std::cout << "Assigning traces to CPUs" << std::endl;
    for (int i = optind; i < argc; i++) {
      std::cout << "CPU " << traces.size() << " runs " << argv[i] << " CS=" << knob_cs_traces[traces.size()] << std::endl;
      traces.push_back(get_tracereader(argv[i], traces.size(), knob_cs_traces[traces.size()] == 'y' ? true : false));

      if (traces.size() > NUM_CPUS) {
        printf("\n*** Too many traces for the configured number of cores ***\n\n");
        assert(0);
      }
    }

    if (traces.size() != NUM_CPUS) {
      printf("\n*** Not enough traces for the configured number of cores ***\n\n");
      assert(0);
    }
  }
  else {
    std::cout << "All CPUs run trace-0" << std::endl;
    for (int i = 0; i < NUM_CPUS; i++) {
      std::cout << "CPU " << i << " runs " << argv[optind] << std::endl;

      traces.push_back(get_tracereader(argv[optind], i, knob_cs_traces[traces.size()] == 'y' ? true : false));
    }
  }


  // SHARED CACHE
  for (O3_CPU* cpu : ooo_cpu) {
    cpu->initialize_core();
  }

  for (auto it = caches.rbegin(); it != caches.rend(); ++it) {
    (*it)->impl_prefetcher_initialize();
    (*it)->impl_replacement_initialize();
  }

  // simulation entry point
  while (std::any_of(std::begin(simulation_complete), std::end(simulation_complete), std::logical_not<uint8_t>())) {

    uint64_t elapsed_second = (uint64_t)(time(NULL) - start_time), elapsed_minute = elapsed_second / 60, elapsed_hour = elapsed_minute / 60;
    elapsed_minute -= elapsed_hour * 60;
    elapsed_second -= (elapsed_hour * 3600 + elapsed_minute * 60);

    for (auto op : operables) {
      try {
        op->_operate();
      } catch (champsim::deadlock& dl) {
        // ooo_cpu[dl.which]->print_deadlock();
        // std::cout << std::endl;
        // for (auto c : caches)
        for (auto c : operables) {
          c->print_deadlock();
          std::cout << std::endl;
        }

        abort();
      }
    }
    std::sort(std::begin(operables), std::end(operables), champsim::by_next_operate());

    for (std::size_t i = 0; i < ooo_cpu.size(); ++i) {
      // read from trace
      while (ooo_cpu[i]->fetch_stall == 0 && ooo_cpu[i]->instrs_to_read_this_cycle > 0) {
        ooo_cpu[i]->init_instruction(traces[i]->get());
      }

      // heartbeat information
      if (show_heartbeat && (ooo_cpu[i]->num_retired >= ooo_cpu[i]->next_print_instruction)) {
        float cumulative_ipc;
        if (warmup_complete[i])
          cumulative_ipc = (1.0 * (ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr)) / (ooo_cpu[i]->current_cycle - ooo_cpu[i]->begin_sim_cycle);
        else
          cumulative_ipc = (1.0 * ooo_cpu[i]->num_retired) / ooo_cpu[i]->current_cycle;
        float heartbeat_ipc = (1.0 * ooo_cpu[i]->num_retired - ooo_cpu[i]->last_sim_instr) / (ooo_cpu[i]->current_cycle - ooo_cpu[i]->last_sim_cycle);

        cout << "Heartbeat CPU " << i << " instructions: " << ooo_cpu[i]->num_retired << " cycles: " << ooo_cpu[i]->current_cycle;
        cout << " heartbeat IPC: " << heartbeat_ipc << " cumulative IPC: " << cumulative_ipc;
        cout << " (Simulation time: " << elapsed_hour << " hr " << elapsed_minute << " min " << elapsed_second << " sec) ";
        cout << endl;
        ooo_cpu[i]->next_print_instruction += STAT_PRINTING_PERIOD;

        ooo_cpu[i]->last_sim_instr = ooo_cpu[i]->num_retired;
        ooo_cpu[i]->last_sim_cycle = ooo_cpu[i]->current_cycle;
      }

      // check for warmup
      // warmup complete
      if ((warmup_complete[i] == 0) && (ooo_cpu[i]->num_retired > warmup_instructions)) {
        warmup_complete[i] = 1;
        all_warmup_complete++;
      }
      if (all_warmup_complete == NUM_CPUS) { // this part is called only once
                                             // when all cores are warmed up
        all_warmup_complete++;
        finish_warmup();
      }

      // simulation complete
      if ((all_warmup_complete > NUM_CPUS) && (simulation_complete[i] == 0)
          && (ooo_cpu[i]->num_retired >= (ooo_cpu[i]->begin_sim_instr + simulation_instructions))) {
        simulation_complete[i] = 1;
        ooo_cpu[i]->finish_sim_instr = ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr;
        ooo_cpu[i]->finish_sim_cycle = ooo_cpu[i]->current_cycle - ooo_cpu[i]->begin_sim_cycle;

        cout << "Finished CPU " << i << " instructions: " << ooo_cpu[i]->finish_sim_instr << " cycles: " << ooo_cpu[i]->finish_sim_cycle;
        cout << " cumulative IPC: " << ((float)ooo_cpu[i]->finish_sim_instr / ooo_cpu[i]->finish_sim_cycle);
        cout << " (Simulation time: " << elapsed_hour << " hr " << elapsed_minute << " min " << elapsed_second << " sec) " << endl;

        for (auto it = caches.rbegin(); it != caches.rend(); ++it)
          record_roi_stats(i, *it);
      }
    }
  }

  uint64_t elapsed_second = (uint64_t)(time(NULL) - start_time), elapsed_minute = elapsed_second / 60, elapsed_hour = elapsed_minute / 60;
  elapsed_minute -= elapsed_hour * 60;
  elapsed_second -= (elapsed_hour * 3600 + elapsed_minute * 60);

  cout << endl << "ChampSim completed all CPUs" << endl;
  if (NUM_CPUS > 1) {
    cout << endl << "Total Simulation Statistics (not including warmup)" << endl;
    for (uint32_t i = 0; i < NUM_CPUS; i++) {
      cout << endl
           << "CPU " << i
           << " cumulative IPC: " << (float)(ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr) / (ooo_cpu[i]->current_cycle - ooo_cpu[i]->begin_sim_cycle);
      cout << " instructions: " << ooo_cpu[i]->num_retired - ooo_cpu[i]->begin_sim_instr
           << " cycles: " << ooo_cpu[i]->current_cycle - ooo_cpu[i]->begin_sim_cycle << endl;
      for (auto it = caches.rbegin(); it != caches.rend(); ++it)
        print_sim_stats(i, *it);
    }
  }

  cout << endl << "Region of Interest Statistics" << endl;
  for (uint32_t i = 0; i < NUM_CPUS; i++) {
    cout << endl << "CPU " << i << " cumulative IPC: " << ((float)ooo_cpu[i]->finish_sim_instr / ooo_cpu[i]->finish_sim_cycle);
    cout << " instructions: " << ooo_cpu[i]->finish_sim_instr << " cycles: " << ooo_cpu[i]->finish_sim_cycle << endl;
    for (auto it = caches.rbegin(); it != caches.rend(); ++it)
      print_roi_stats(i, *it);
  }

  for (auto it = caches.rbegin(); it != caches.rend(); ++it)
    (*it)->impl_prefetcher_final_stats();

  for (auto it = caches.rbegin(); it != caches.rend(); ++it)
    (*it)->impl_replacement_final_stats();

#ifndef CRC2_COMPILE
  // print_dram_stats();
  DRAM.PrintStats();
  print_branch_stats();
#endif

  return 0;
}

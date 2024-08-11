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

#ifndef MEMORY_CLASS_H
#define MEMORY_CLASS_H

#include <limits>
#include "rowhammer_detector.h"
#include "block.h"

// CACHE ACCESS TYPE
#define LOAD 0
#define RFO 1
#define PREFETCH 2
#define WRITEBACK 3
#define TRANSLATION 4
#define RH_MITIGATION 5
#define RH_UPDATE 6
#define RH_READ 7
#define RH_WRITE 8
#define NUM_TYPES 9

// CACHE BLOCK
class BLOCK
{
public:
  bool valid = false, prefetch = false, dirty = false;

  uint64_t address = 0, v_address = 0, tag = 0, data = 0, ip = 0, cpu = 0, instr_id = 0;

  // replacement state
  uint32_t lru = std::numeric_limits<uint32_t>::max() >> 1;
};

class MemoryRequestConsumer
{
public:
  /*
   * add_*q() return values:
   *
   * -2 : queue full
   * -1 : packet value forwarded, returned
   * 0  : packet merged
   * >0 : new queue occupancy
   *
   */

  const unsigned fill_level;
  std::vector<ACTInfo> ACTs;
  std::vector<std::pair<uint64_t, uint8_t>> rhActions;
  RH_Detector *detector;
  uint64_t numPPages;
  bool *procPageAccess;;
  virtual int add_rq(PACKET* packet) = 0;
  virtual int add_wq(PACKET* packet) = 0;
  virtual int add_pq(PACKET* packet) = 0;
  virtual void SendRFM(int ba, int ra, int ch) = 0;
  virtual uint32_t get_occupancy(uint8_t queue_type, uint64_t address) = 0;
  virtual uint32_t get_size(uint8_t queue_type, uint64_t address) = 0;

  explicit MemoryRequestConsumer(unsigned fill_level) : fill_level(fill_level) {}
};

class MemoryRequestProducer
{
public:
  MemoryRequestConsumer* lower_level;
  virtual void return_data(PACKET* packet) = 0;

protected:
  MemoryRequestProducer() {}
  explicit MemoryRequestProducer(MemoryRequestConsumer* ll) : lower_level(ll) {}
};

#endif

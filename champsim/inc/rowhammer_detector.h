#ifndef RH_DETECTOR
#define RH_DETECTOR

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vector>
#include <time.h>       /* time */
#include <unordered_set>
#include "block.h"

typedef struct FuncCacheBlock{
    uint64_t tag;
    bool valid;
    bool dirty;
    bool onlyOneRowRemapped;
    uint32_t rrip;
} FuncCacheBlock;

typedef uint64_t Addr;

enum LOOKUP_TYPE{
    ONLY_LOOKUP,
    LOOKUP_AND_UPDATE
};

class Functional_Cache{
private:
    uint32_t m_blk_offset;
    FuncCacheBlock **m_cache;

    uint64_t s_lookups;
    uint64_t s_hits;
    uint64_t s_fills;
    uint64_t s_invalidations;
    uint64_t s_evictions;

public:
    uint32_t m_sets;
    uint32_t m_ways;
    uint32_t partial_lookup_factor;
    Functional_Cache(uint32_t sets, uint32_t ways);
    uint32_t Lookup(uint64_t addr, uint32_t lookup_type);
    uint32_t PartialLookup(uint64_t addr);
    void Invalidate(uint64_t addr, uint32_t blk_way);
    void Reset();
    void Fill(uint64_t addr, uint32_t blk_way);
    uint32_t Find_Victim(uint64_t addr);
    bool Is_Block_Valid(uint64_t addr, uint32_t blk_way);
    uint64_t Get_Block_Addr(uint64_t addr, uint32_t blk_way);
    uint32_t Get_Block_Way(uint64_t addr);
    void SetDirtyBit(uint64_t addr, uint32_t blk_way);
    bool QueryDirtyBit(uint64_t addr, uint32_t blk_way);
    void SetORRBit(uint64_t addr, bool bitvalue);
    bool QueryORRBit(uint64_t addr, uint32_t blk_way);
    void Print_Stats(uint32_t level);
};

class RH_Detector {
public:
    uint32_t            threshold;
    uint32_t            numEntries;
    uint32_t            numRows;
    uint8_t             numBanks;
    uint8_t             numRanks;
    uint8_t             numChannels;
    uint32_t            RowGroupInitPenalty; /* DRAM Rd-Mod-Wr to init row-group ctrs */
    uint32_t            CtrRdPenalty; /* DRAM Rd to get counter value */
    uint32_t            CtrMdPenalty; /* Writeback dirty counter line */
    virtual bool access(Addr addr, uint8_t bankID, uint8_t rankID, 
                uint8_t channelID, bool isFuncLookup = false) = 0;
    virtual void reset() = 0;
    virtual void print_stats() = 0;
    uint64_t            s_numUniqRows;
};

class Misra_Gries : public RH_Detector {
private:
    typedef struct __Tracker_Entry {
        bool            valid;
        Addr            addr;
        uint32_t        count;
    } Tracker_Entry;
    
    class Tracker {
    public:
        Tracker_Entry       *entries;
        uint32_t            spill_counter;
        std::unordered_set<Addr>  uniq_rows;
        uint32_t            *rowHasEntry;

        uint32_t            s_num_reset;        //-- how many times was the tracker reset
        uint32_t            s_glob_spill_count; //-- what is the total spill_count over time

        //---- Update below statistics in mgries_access() ----
        uint64_t            s_num_access;  //-- how many times was the tracker called
        uint64_t            s_num_install; //-- how many times did the tracker install rowIDs 
        uint64_t            s_aggressors; //-- how many times did the tracker flag an aggressor
    };

    Tracker             ***trackers;

public:
    Misra_Gries(uint32_t __numEntries, uint32_t threshold, uint32_t __numRows,
                uint8_t __numBanks, uint8_t __numRanks, uint8_t __numChannels);
    bool access(Addr addr, uint8_t bankID, uint8_t rankID, uint8_t channelID, bool isFuncLookup);
    void reset();
    void print_stats();
};

/***************************************************************************
 * Set groupThreshold and functional cache AFTER constructing the tracker
 * *************************************************************************/
class Hydra : public RH_Detector {
    uint32_t            *GCT;
    bool                *RowGroupInit;
    uint32_t            *RCT;

    uint32_t            numDRAMRows;
    uint32_t            rowGroupSize;
    uint32_t            ctrsPerCLine;
    uint32_t            numGCTEntries;

public:
    Functional_Cache    *RCC;
    uint64_t            groupThreshold; // Default is 0.5*threshold
    uint64_t            s_gct_only;
    uint64_t            s_rcc_acc;
    uint64_t            s_rcc_miss;
    uint64_t            s_dirty_evict;
    uint64_t            s_mitigations;
    uint64_t            s_rct_init;

    Hydra(uint32_t __rowGroupSize, uint32_t threshold, uint32_t __numRows,
                uint8_t __numBanks, uint8_t __numRanks, uint8_t __numChannels);
    bool access(Addr DRAMRowID, uint8_t bankID, uint8_t rankID, uint8_t channelID, bool isFuncLookup);
    void reset();
    void print_stats();
};

#endif // MGRIES_H
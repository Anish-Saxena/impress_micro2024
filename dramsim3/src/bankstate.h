#ifndef __BANKSTATE_H
#define __BANKSTATE_H

#include <vector>
#include "common.h"

namespace dramsim3 {

class BankState {
   public:
    BankState(uint64_t tONMAX, uint64_t tRFM);

    enum class State { OPEN, CLOSED, SREF, PD, SIZE };
    Command GetReadyCommand(const Command& cmd, uint64_t clk) const;

    // Update the state of the bank resulting after the execution of the command
    void UpdateState(const Command& cmd);

    // Update the existing timing constraints for the command
    void UpdateTiming(const CommandType cmd_type, uint64_t time);

    bool IsRowOpen() const { return state_ == State::OPEN; }
    int OpenRow() const { return open_row_; }
    int RowHitCount() const { return row_hit_count_; }

    // Impress: check if PRE due to tONMAX needed
    bool ExpressPRENeeded(uint64_t clk) const { 
        if (tONMAX == (uint64_t)-1) 
            return false;
        return (state_ == State::OPEN && (clk - last_ACT_cycles > tONMAX));
    }

    void BankNeedRFM(uint64_t clk) {
        if (rfm_state == (uint64_t)-1)
            rfm_state = clk + tRFM;
        else
            rfm_state += tRFM;
    }

    bool IsBankInRFM(uint64_t clk) const {
        if (rfm_state == (uint64_t)-1)
            return false;
        else if (clk > rfm_state) {
            return false;
        }
        else {
            return true;
        }
    }

    void UpdateRFMStatus(uint64_t clk) {
        if (rfm_state != (uint64_t) -1 && rfm_state < clk)
            rfm_state = (uint64_t) -1;
    }

    void UpdateLastACTInfo(uint64_t clk) { 
        last_ACT_cycles = clk; 
        return; 
    }

    uint64_t GetLastACTCycles() {
        return last_ACT_cycles;
    }

    void UpdateImpressOpenRow(uint64_t row) {
        impress_open_row = row;
    }

    uint64_t GetImpressOpenRow() {
        return impress_open_row;
    }
    
    // bool SampleACCAct(int option) {
    //     if (option == 2)
    //         return isSamplingACCAct;
    //     else if (option == 1) {
    //         bool retval = isSamplingACCAct;
    //         isSamplingACCAct = true;
    //         return retval;
    //     }
    //     else {
    //         bool retval = isSamplingACCAct;
    //         isSamplingACCAct = false;
    //         return retval;
    //     }
    // }

   private:
    // Current state of the Bank
    // Apriori or instantaneously transitions on a command.
    State state_;

    // Earliest time when the particular Command can be executed in this bank
    std::vector<uint64_t> cmd_timing_;

    // Currently open row
    int open_row_;

    // consecutive accesses to one row
    int row_hit_count_;


    //impress: tONMAX implementation
    uint64_t last_ACT_cycles;
    uint64_t tONMAX;
    uint64_t rfm_state;
    uint64_t tRFM;
    uint64_t impress_open_row;
    // bool     isSamplingACCAct;
};

}  // namespace dramsim3
#endif

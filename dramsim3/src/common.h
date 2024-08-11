#ifndef __COMMON_H
#define __COMMON_H

#include <stdint.h>
#include <iostream>
#include <vector>

namespace dramsim3 {

struct Address {
    Address()
        : channel(-1), rank(-1), bankgroup(-1), bank(-1), row(-1), column(-1),
            tON(-1), tPRE(-1), tRC(-1) {}
    Address(int channel, int rank, int bankgroup, int bank, int row, int column,
            int tON = -1, int tPRE = -1, int tRC = -1)
        : channel(channel),
          rank(rank),
          bankgroup(bankgroup),
          bank(bank),
          row(row),
          column(column),
          tON(tON),
          tPRE(tPRE),
          tRC(tRC) {}
    Address(const Address& addr)
        : channel(addr.channel),
          rank(addr.rank),
          bankgroup(addr.bankgroup),
          bank(addr.bank),
          row(addr.row),
          column(addr.column),
          tON(addr.tON),
          tPRE(addr.tPRE),
          tRC(addr.tRC) {}
    int channel;
    int rank;
    int bankgroup;
    int bank;
    int row;
    int column;
    int tON;
    int tPRE;
    int tRC;
};

inline uint32_t ModuloWidth(uint64_t addr, uint32_t bit_width, uint32_t pos) {
    addr >>= pos;
    auto store = addr;
    addr >>= bit_width;
    addr <<= bit_width;
    return static_cast<uint32_t>(store ^ addr);
}

// extern std::function<Address(uint64_t)> AddressMapping;
int GetBitInPos(uint64_t bits, int pos);
// it's 2017 and c++ std::string still lacks a split function, oh well
std::vector<std::string> StringSplit(const std::string& s, char delim);
template <typename Out>
void StringSplit(const std::string& s, char delim, Out result);

int LogBase2(int power_of_two);
void AbruptExit(const std::string& file, int line);
bool DirExist(std::string dir);

enum class CommandType {
    READ,
    READ_PRECHARGE,
    WRITE,
    WRITE_PRECHARGE,
    ACTIVATE,
    PRECHARGE,
    REFRESH_BANK,
    REFRESH,
    SREF_ENTER,
    SREF_EXIT,
    SIZE
};

struct Command {
    Command() : cmd_type(CommandType::SIZE), hex_addr(0) {}
    Command(CommandType cmd_type, const Address& addr, uint64_t hex_addr,
            bool isRHMit = false)
        : cmd_type(cmd_type), addr(addr), hex_addr(hex_addr), 
          isRHMit(isRHMit) {}
    // Command(const Command& cmd) {}

    bool IsValid() const { return cmd_type != CommandType::SIZE; }
    bool IsRefresh() const {
        return cmd_type == CommandType::REFRESH ||
               cmd_type == CommandType::REFRESH_BANK;
    }
    bool IsRead() const {
        return cmd_type == CommandType::READ ||
               cmd_type == CommandType ::READ_PRECHARGE;
    }
    bool IsWrite() const {
        return cmd_type == CommandType ::WRITE ||
               cmd_type == CommandType ::WRITE_PRECHARGE;
    }
    bool IsReadWrite() const { return IsRead() || IsWrite(); }
    bool IsRankCMD() const {
        return cmd_type == CommandType::REFRESH ||
               cmd_type == CommandType::SREF_ENTER ||
               cmd_type == CommandType::SREF_EXIT;
    }
    CommandType cmd_type;
    Address addr;
    bool reqd_ACT = false;
    uint64_t hex_addr;

    // Impress
    bool expressPRE = false;
    bool isRHMit = false;
    int rhMitDelay = 0;
    bool isACCSample = false;

    int Channel() const { return addr.channel; }
    int Rank() const { return addr.rank; }
    int Bankgroup() const { return addr.bankgroup; }
    int Bank() const { return addr.bank; }
    int Row() const { return addr.row; }
    int Column() const { return addr.column; }

    friend std::ostream& operator<<(std::ostream& os, const Command& cmd);
};

struct Transaction {
    Transaction() {}
    Transaction(uint64_t addr, bool is_write, bool isRHMit = false)
        : addr(addr),
          added_cycle(0),
          complete_cycle(0),
          CRA_idx(0),
          is_ACT(false),
          is_write(is_write),
          isRHMit(isRHMit) {}
    Transaction(const Transaction& tran)
        : addr(tran.addr),
          added_cycle(tran.added_cycle),
          complete_cycle(tran.complete_cycle),
          is_write(tran.is_write),
          isRHMit(tran.isRHMit) {}
    uint64_t addr;
    uint64_t added_cycle;
    uint64_t complete_cycle;
    uint64_t CRA_idx;
    bool is_ACT;
    bool is_write;
    bool isRHMit;

    friend std::ostream& operator<<(std::ostream& os, const Transaction& trans);
    friend std::istream& operator>>(std::istream& is, Transaction& trans);
};

}  // namespace dramsim3
#endif

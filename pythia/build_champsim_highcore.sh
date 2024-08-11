#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Illegal number of parameters"
    #echo "Usage: ./build_champsim.sh [branch_pred] [l1d_pref] [l2c_pref] [llc_pref] [llc_repl] [num_core]"
    echo "Usage: ./build_champsim.sh [l1d_pref] [l2c_pref] [llc_pref] [num_core] [config]"
    exit 1
fi

# ChampSim configuration
#BRANCH=$1           # branch/*.bpred
L1D_PREFETCHER=$1   # prefetcher/*.l1d_pref
L2C_PREFETCHER=$2   # prefetcher/*.l2c_pref
LLC_PREFETCHER=$3   # prefetcher/*.llc_pref
#LLC_REPLACEMENT=$5  # replacement/*.llc_repl
NUM_CORE=$4         # tested up to 8-core system
CONFIG=$5           # CXL studies -- memsys config

############## Some useful macros ###############
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
#################################################

############## Default configuration ############
BRANCH=perceptron
LLC_REPLACEMENT=ship
#NUM_CORE=1
#################################################

# Sanity check
if [ ! -f ./branch/${BRANCH}.bpred ]; then
    echo "[ERROR] Cannot find branch predictor"
	echo "[ERROR] Possible branch predictors from branch/*.bpred "
    find branch -name "*.bpred"
    exit 1
fi

if [ ! -f ./prefetcher/${L1D_PREFETCHER}.l1d_pref ]; then
    echo "[ERROR] Cannot find L1D prefetcher"
	echo "[ERROR] Possible L1D prefetchers from prefetcher/*.l1d_pref "
    find prefetcher -name "*.l1d_pref"
    exit 1
fi

if [ ! -f ./prefetcher/${L2C_PREFETCHER}.l2c_pref ]; then
    echo "[ERROR] Cannot find L2C prefetcher"
	echo "[ERROR] Possible L2C prefetchers from prefetcher/*.l2c_pref "
    find prefetcher -name "*.l2c_pref"
    exit 1
fi

if [ ! -f ./prefetcher/${LLC_PREFETCHER}.llc_pref ]; then
    echo "[ERROR] Cannot find LLC prefetcher"
	echo "[ERROR] Possible LLC prefetchers from prefetcher/*.llc_pref "
    find prefetcher -name "*.llc_pref"
    exit 1
fi

if [ ! -f ./replacement/${LLC_REPLACEMENT}.llc_repl ]; then
    echo "[ERROR] Cannot find LLC replacement policy"
	echo "[ERROR] Possible LLC replacement policy from replacement/*.llc_repl"
    find replacement -name "*.llc_repl"
    exit 1
fi

# Check num_core
re='^[0-9]+$'
if ! [[ $NUM_CORE =~ $re ]] ; then
    echo "[ERROR]: num_core is NOT a number" >&2;
    exit 1
fi

# This script is only valid for 6-cores or more
if [ "$NUM_CORE" -lt "6" ]; then
	echo "Number of core: $NUM_CORE must be greater or equal to 6"
	exit 1
fi

sed -i.bak 's/\<NUM_CPUS 1\>/NUM_CPUS '${NUM_CORE}'/g' inc/champsim.h

echo "Before changing configuration"
cat inc/champsim.h | grep "DRAM_CHANNELS"

# Check for multi-core
if [ "$CONFIG" = "base_DDR" ]; then
    echo "[CXL STUDY] Building baseline with 2 DDR channels..."
    sed -i.bak 's/\<DRAM_CHANNELS 1\>/DRAM_CHANNELS 2/g' inc/champsim.h
    sed -i.bak 's/\<LOG2_DRAM_CHANNELS 0\>/LOG2_DRAM_CHANNELS 1/g' inc/champsim.h
elif [ "$CONFIG" = "upper_bound_DDR" ]; then
    echo "[CXL STUDY] Building upper bound with 4 DDR channels..."
    sed -i.bak 's/\<DRAM_CHANNELS 1\>/DRAM_CHANNELS 4/g' inc/champsim.h
    sed -i.bak 's/\<LOG2_DRAM_CHANNELS 0\>/LOG2_DRAM_CHANNELS 2/g' inc/champsim.h
elif [ "$NUM_CORE" -gt "1" ]; then
    echo "Building multi-core ChampSim..."
    sed -i.bak 's/\<DRAM_CHANNELS 1\>/DRAM_CHANNELS 4/g' inc/champsim.h
    sed -i.bak 's/\<LOG2_DRAM_CHANNELS 0\>/LOG2_DRAM_CHANNELS 2/g' inc/champsim.h
else
    if [ "$NUM_CORE" -lt "1" ]; then
        echo "Number of core: $NUM_CORE must be greater or equal than 1"
        exit 1
    else
        echo "Building single-core ChampSim..."
    fi
fi
echo "After changing configuration"
cat inc/champsim.h | grep "DRAM_CHANNELS"

# Change prefetchers and replacement policy
cp branch/${BRANCH}.bpred branch/branch_predictor.cc
cp prefetcher/${L1D_PREFETCHER}.l1d_pref prefetcher/l1d_prefetcher.cc
cp prefetcher/${L2C_PREFETCHER}.l2c_pref prefetcher/l2c_prefetcher.cc
cp prefetcher/${LLC_PREFETCHER}.llc_pref prefetcher/llc_prefetcher.cc
cp replacement/${LLC_REPLACEMENT}.llc_repl replacement/llc_replacement.cc

# Build
mkdir -p bin
rm -f bin/champsim
make clean
make -j8

# Sanity check
echo ""
if [ ! -f bin/champsim ]; then
    echo "${BOLD}ChampSim build FAILED!"
    echo ""
    exit 1
fi

echo "${BOLD}ChampSim is successfully built"
echo "Branch Predictor: ${BRANCH}"
echo "L1D Prefetcher: ${L1D_PREFETCHER}"
echo "L2C Prefetcher: ${L2C_PREFETCHER}"
echo "LLC Prefetcher: ${LLC_PREFETCHER}"
echo "LLC Replacement: ${LLC_REPLACEMENT}"
echo "Cores: ${NUM_CORE}"
BINARY_NAME="${BRANCH}-${L1D_PREFETCHER}-${L2C_PREFETCHER}-${LLC_PREFETCHER}-${LLC_REPLACEMENT}-${NUM_CORE}core-${CONFIG}"
echo "Binary: bin/${BINARY_NAME}"
echo ""
mv bin/champsim bin/${BINARY_NAME}

echo "Before reverting changes"
cat inc/champsim.h | grep "DRAM_CHANNELS"

sed -i.bak 's/\<NUM_CPUS '${NUM_CORE}'\>/NUM_CPUS 1/g' inc/champsim.h
if [ "$CONFIG" = "base_DDR" ]; then
    sed -i.bak 's/\<DRAM_CHANNELS 2\>/DRAM_CHANNELS 1/g' inc/champsim.h
    sed -i.bak 's/\<LOG2_DRAM_CHANNELS 1\>/LOG2_DRAM_CHANNELS 0/g' inc/champsim.h
elif [ "$CONFIG" = "upper_bound_DDR" ]; then
    echo "[CXL STUDY] Building upper bound with 4 DDR channels..."
    sed -i.bak 's/\<DRAM_CHANNELS 4\>/DRAM_CHANNELS 1/g' inc/champsim.h
    sed -i.bak 's/\<LOG2_DRAM_CHANNELS 2\>/LOG2_DRAM_CHANNELS 0/g' inc/champsim.h
elif [ "$NUM_CORE" -gt "1" ]; then
    echo "Building multi-core ChampSim..."
    sed -i.bak 's/\<DRAM_CHANNELS 4\>/DRAM_CHANNELS 1/g' inc/champsim.h
    sed -i.bak 's/\<LOG2_DRAM_CHANNELS 2\>/LOG2_DRAM_CHANNELS 0/g' inc/champsim.h
fi
echo "After reverting changes"
cat inc/champsim.h | grep "DRAM_CHANNELS"

cp branch/bimodal.bpred branch/branch_predictor.cc
cp prefetcher/no.l1d_pref prefetcher/l1d_prefetcher.cc
cp prefetcher/no.l2c_pref prefetcher/l2c_prefetcher.cc
cp prefetcher/no.llc_pref prefetcher/llc_prefetcher.cc
cp replacement/lru.llc_repl replacement/llc_replacement.cc

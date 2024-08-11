#!/bin/bash

cd ../dramsim3
DRAMSIM3_PATH=`pwd`
cd ../champsim
export LD_LIBRARY_PATH=$DRAMSIM3_PATH:$LD_LIBRARY_PATH
cd bin
./8C_16WLLC --simulation_instruction=100000 \
--warmup_instructions=1000000 \
-traces ../../experiments/traces/602.gcc_s-1850B.champsimtrace.xz | tee test_output.txt
if cat test_output.txt | grep -q "ChampSim completed all CPUs"; then
    echo "SETUP TESTED SUCCESSFULLY"
else
    echo "SETUP TEST FAILED"
fi
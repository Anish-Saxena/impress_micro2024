#!/bin/bash -l
#
#
#
# Traces:
#    cassandra_phase1_core0_1T
#    cassandra_phase1_core1_1T
#    cassandra_phase1_core2_1T
#    cassandra_phase1_core3_1T
#    classification_phase1_core0_1T
#    classification_phase1_core1_1T
#    classification_phase1_core2_1T
#    classification_phase1_core3_1T
#    cloud9_phase1_core0_1T
#    cloud9_phase1_core1_1T
#    cloud9_phase1_core2_1T
#    cloud9_phase1_core3_1T
#    nutch_phase1_core0_1T
#    nutch_phase1_core1_1T
#    nutch_phase1_core2_1T
#    nutch_phase1_core3_1T
#    streaming_phase1_core0_1T
#    streaming_phase1_core1_1T
#    streaming_phase1_core2_1T
#    streaming_phase1_core3_1T
#
#
# Experiments:
#    base: --warmup_instructions=50000000 --simulation_instructions=200000000
#
#
#
#
mkdir -p ./cassandra_phase1_core0_1T_base && cd ./cassandra_phase1_core0_1T_base
srun --ntasks=1 -N1 -c 1 -J cassandra_phase1_core0_1T_base -o cassandra_phase1_core0_1T_base.out -e cassandra_phase1_core0_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core0.trace.xz  " &
cd ../
mkdir -p ./cassandra_phase1_core1_1T_base && cd ./cassandra_phase1_core1_1T_base
srun --ntasks=1 -N1 -c 1 -J cassandra_phase1_core1_1T_base -o cassandra_phase1_core1_1T_base.out -e cassandra_phase1_core1_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core1.trace.xz  " &
cd ../
mkdir -p ./cassandra_phase1_core2_1T_base && cd ./cassandra_phase1_core2_1T_base
srun --ntasks=1 -N1 -c 1 -J cassandra_phase1_core2_1T_base -o cassandra_phase1_core2_1T_base.out -e cassandra_phase1_core2_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core2.trace.xz  " &
cd ../
mkdir -p ./cassandra_phase1_core3_1T_base && cd ./cassandra_phase1_core3_1T_base
srun --ntasks=1 -N1 -c 1 -J cassandra_phase1_core3_1T_base -o cassandra_phase1_core3_1T_base.out -e cassandra_phase1_core3_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./classification_phase1_core0_1T_base && cd ./classification_phase1_core0_1T_base
srun --ntasks=1 -N1 -c 1 -J classification_phase1_core0_1T_base -o classification_phase1_core0_1T_base.out -e classification_phase1_core0_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core0.trace.xz  " &
cd ../
mkdir -p ./classification_phase1_core1_1T_base && cd ./classification_phase1_core1_1T_base
srun --ntasks=1 -N1 -c 1 -J classification_phase1_core1_1T_base -o classification_phase1_core1_1T_base.out -e classification_phase1_core1_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core1.trace.xz  " &
cd ../
mkdir -p ./classification_phase1_core2_1T_base && cd ./classification_phase1_core2_1T_base
srun --ntasks=1 -N1 -c 1 -J classification_phase1_core2_1T_base -o classification_phase1_core2_1T_base.out -e classification_phase1_core2_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core2.trace.xz  " &
cd ../
mkdir -p ./classification_phase1_core3_1T_base && cd ./classification_phase1_core3_1T_base
srun --ntasks=1 -N1 -c 1 -J classification_phase1_core3_1T_base -o classification_phase1_core3_1T_base.out -e classification_phase1_core3_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./cloud9_phase1_core0_1T_base && cd ./cloud9_phase1_core0_1T_base
srun --ntasks=1 -N1 -c 1 -J cloud9_phase1_core0_1T_base -o cloud9_phase1_core0_1T_base.out -e cloud9_phase1_core0_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core0.trace.xz  " &
cd ../
mkdir -p ./cloud9_phase1_core1_1T_base && cd ./cloud9_phase1_core1_1T_base
srun --ntasks=1 -N1 -c 1 -J cloud9_phase1_core1_1T_base -o cloud9_phase1_core1_1T_base.out -e cloud9_phase1_core1_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core1.trace.xz  " &
cd ../
mkdir -p ./cloud9_phase1_core2_1T_base && cd ./cloud9_phase1_core2_1T_base
srun --ntasks=1 -N1 -c 1 -J cloud9_phase1_core2_1T_base -o cloud9_phase1_core2_1T_base.out -e cloud9_phase1_core2_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core2.trace.xz  " &
cd ../
mkdir -p ./cloud9_phase1_core3_1T_base && cd ./cloud9_phase1_core3_1T_base
srun --ntasks=1 -N1 -c 1 -J cloud9_phase1_core3_1T_base -o cloud9_phase1_core3_1T_base.out -e cloud9_phase1_core3_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./nutch_phase1_core0_1T_base && cd ./nutch_phase1_core0_1T_base
srun --ntasks=1 -N1 -c 1 -J nutch_phase1_core0_1T_base -o nutch_phase1_core0_1T_base.out -e nutch_phase1_core0_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core0.trace.xz  " &
cd ../
mkdir -p ./nutch_phase1_core1_1T_base && cd ./nutch_phase1_core1_1T_base
srun --ntasks=1 -N1 -c 1 -J nutch_phase1_core1_1T_base -o nutch_phase1_core1_1T_base.out -e nutch_phase1_core1_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core1.trace.xz  " &
cd ../
mkdir -p ./nutch_phase1_core2_1T_base && cd ./nutch_phase1_core2_1T_base
srun --ntasks=1 -N1 -c 1 -J nutch_phase1_core2_1T_base -o nutch_phase1_core2_1T_base.out -e nutch_phase1_core2_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core2.trace.xz  " &
cd ../
mkdir -p ./nutch_phase1_core3_1T_base && cd ./nutch_phase1_core3_1T_base
srun --ntasks=1 -N1 -c 1 -J nutch_phase1_core3_1T_base -o nutch_phase1_core3_1T_base.out -e nutch_phase1_core3_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./streaming_phase1_core0_1T_base && cd ./streaming_phase1_core0_1T_base
srun --ntasks=1 -N1 -c 1 -J streaming_phase1_core0_1T_base -o streaming_phase1_core0_1T_base.out -e streaming_phase1_core0_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/streaming_phase1_core0.trace.xz  " &
cd ../
mkdir -p ./streaming_phase1_core1_1T_base && cd ./streaming_phase1_core1_1T_base
srun --ntasks=1 -N1 -c 1 -J streaming_phase1_core1_1T_base -o streaming_phase1_core1_1T_base.out -e streaming_phase1_core1_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/streaming_phase1_core1.trace.xz  " &
cd ../
mkdir -p ./streaming_phase1_core2_1T_base && cd ./streaming_phase1_core2_1T_base
srun --ntasks=1 -N1 -c 1 -J streaming_phase1_core2_1T_base -o streaming_phase1_core2_1T_base.out -e streaming_phase1_core2_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/streaming_phase1_core2.trace.xz  " &
cd ../
mkdir -p ./streaming_phase1_core3_1T_base && cd ./streaming_phase1_core3_1T_base
srun --ntasks=1 -N1 -c 1 -J streaming_phase1_core3_1T_base -o streaming_phase1_core3_1T_base.out -e streaming_phase1_core3_1T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/1C_16WLLC "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/streaming_phase1_core3.trace.xz  " &
cd ../
wait
echo "done"
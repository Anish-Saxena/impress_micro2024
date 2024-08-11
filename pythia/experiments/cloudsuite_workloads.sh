#!/bin/bash

#SBATCH -A gts-mqureshi4-rg

#SBATCH -J 16W

#SBATCH --cpus-per-task 1

#SBATCH --ntasks 9

#SBATCH --mem-per-cpu=8G

#SBATCH -t 1-23:00:00

#SBATCH -o /storage/home/hcoda1/4/asaxena317/scratch/cxl/pythia/results/%j.out

export LD_LIBRARY_PATH=/storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/dramsim3:$LD_LIBRARY_PATH

mkdir -p ./cassandra_8T_base && cd ./cassandra_8T_base
srun --ntasks=1 -N1 -c 1 -J cassandra_8T_base -o cassandra_8T_base.out -e cassandra_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=yyyyyyyy -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core3.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./classification_8T_base && cd ./classification_8T_base
srun --ntasks=1 -N1 -c 1 -J classification_8T_base -o classification_8T_base.out -e classification_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=yyyyyyyy -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core3.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./cloud9_8T_base && cd ./cloud9_8T_base
srun --ntasks=1 -N1 -c 1 -J cloud9_8T_base -o cloud9_8T_base.out -e cloud9_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=yyyyyyyy -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core3.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./nutch_8T_base && cd ./nutch_8T_base
srun --ntasks=1 -N1 -c 1 -J nutch_8T_base -o nutch_8T_base.out -e nutch_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=yyyyyyyy -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core3.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./cs_mix1_8T_base && cd ./cs_mix1_8T_base
srun --ntasks=1 -N1 -c 1 -J cs_mix1_8T_base -o cs_mix1_8T_base.out -e cs_mix1_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 --cs_traces=yynnnnnn -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/628.pop2_s-17B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/605.mcf_s-994B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz  " &
cd ../
mkdir -p ./cs_mix2_8T_base && cd ./cs_mix2_8T_base
srun --ntasks=1 -N1 -c 1 -J cs_mix2_8T_base -o cs_mix2_8T_base.out -e cs_mix2_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 --cs_traces=ynyynnny -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core3.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/628.pop2_s-17B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core3.trace.xz  " &
cd ../
mkdir -p ./cs_mix3_8T_base && cd ./cs_mix3_8T_base
srun --ntasks=1 -N1 -c 1 -J cs_mix3_8T_base -o cs_mix3_8T_base.out -e cs_mix3_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 --cs_traces=nynynynn -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core3.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz  " &
cd ../
mkdir -p ./cs_mix4_8T_base && cd ./cs_mix4_8T_base
srun --ntasks=1 -N1 -c 1 -J cs_mix4_8T_base -o cs_mix4_8T_base.out -e cs_mix4_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 --cs_traces=nyyynnnn -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/654.roms_s-1007B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core1.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cassandra_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/nutch_phase1_core2.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/628.pop2_s-17B.champsimtrace.xz  " &
cd ../
mkdir -p ./cs_mix5_8T_base && cd ./cs_mix5_8T_base
srun --ntasks=1 -N1 -c 1 -J cs_mix5_8T_base -o cs_mix5_8T_base.out -e cs_mix5_8T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_16W_512GB "--warmup_instructions=50000000 --simulation_instructions=200000000 --cs_traces=nnnynnny -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/607.cactuBSSN_s-2421B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/cloud9_phase1_core0.trace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/classification_phase1_core0.trace.xz  " &
cd ../
wait
echo "done"
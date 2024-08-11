#!/bin/bash

#SBATCH -A gts-mqureshi4-rg

#SBATCH -J 8C_2b_BR2_T64

#SBATCH --cpus-per-task 1

#SBATCH --ntasks 28

#SBATCH --mem-per-cpu=4G

#SBATCH -t 1-23:00:00

#SBATCH -o /storage/home/hcoda1/4/asaxena317/scratch/cxl/pythia/results/%j.out

export LD_LIBRARY_PATH=/storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/dramsim3:$LD_LIBRARY_PATH

mkdir -p ./602.gcc_s-1850B_4T_base && cd ./602.gcc_s-1850B_4T_base
srun --ntasks=1 -N1 -c 1 -J 602.gcc_s-1850B_4T_base -o 602.gcc_s-1850B_4T_base.out -e 602.gcc_s-1850B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/602.gcc_s-1850B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/602.gcc_s-1850B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/602.gcc_s-1850B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/602.gcc_s-1850B.champsimtrace.xz " &
cd ../
mkdir -p ./603.bwaves_s-2931B_4T_base && cd ./603.bwaves_s-2931B_4T_base
srun --ntasks=1 -N1 -c 1 -J 603.bwaves_s-2931B_4T_base -o 603.bwaves_s-2931B_4T_base.out -e 603.bwaves_s-2931B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/603.bwaves_s-2931B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/603.bwaves_s-2931B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/603.bwaves_s-2931B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/603.bwaves_s-2931B.champsimtrace.xz " &
cd ../
mkdir -p ./605.mcf_s-994B_4T_base && cd ./605.mcf_s-994B_4T_base
srun --ntasks=1 -N1 -c 1 -J 605.mcf_s-994B_4T_base -o 605.mcf_s-994B_4T_base.out -e 605.mcf_s-994B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/605.mcf_s-994B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/605.mcf_s-994B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/605.mcf_s-994B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/605.mcf_s-994B.champsimtrace.xz " &
cd ../
mkdir -p ./607.cactuBSSN_s-2421B_4T_base && cd ./607.cactuBSSN_s-2421B_4T_base
srun --ntasks=1 -N1 -c 1 -J 607.cactuBSSN_s-2421B_4T_base -o 607.cactuBSSN_s-2421B_4T_base.out -e 607.cactuBSSN_s-2421B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/607.cactuBSSN_s-2421B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/607.cactuBSSN_s-2421B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/607.cactuBSSN_s-2421B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/607.cactuBSSN_s-2421B.champsimtrace.xz " &
cd ../
mkdir -p ./620.omnetpp_s-141B_4T_base && cd ./620.omnetpp_s-141B_4T_base
srun --ntasks=1 -N1 -c 1 -J 620.omnetpp_s-141B_4T_base -o 620.omnetpp_s-141B_4T_base.out -e 620.omnetpp_s-141B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/620.omnetpp_s-141B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/620.omnetpp_s-141B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/620.omnetpp_s-141B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/620.omnetpp_s-141B.champsimtrace.xz " &
cd ../
mkdir -p ./621.wrf_s-6673B_4T_base && cd ./621.wrf_s-6673B_4T_base
srun --ntasks=1 -N1 -c 1 -J 621.wrf_s-6673B_4T_base -o 621.wrf_s-6673B_4T_base.out -e 621.wrf_s-6673B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/621.wrf_s-6673B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/621.wrf_s-6673B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/621.wrf_s-6673B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/621.wrf_s-6673B.champsimtrace.xz " &
cd ../
mkdir -p ./623.xalancbmk_s-592B_4T_base && cd ./623.xalancbmk_s-592B_4T_base
srun --ntasks=1 -N1 -c 1 -J 623.xalancbmk_s-592B_4T_base -o 623.xalancbmk_s-592B_4T_base.out -e 623.xalancbmk_s-592B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/623.xalancbmk_s-592B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/623.xalancbmk_s-592B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/623.xalancbmk_s-592B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/623.xalancbmk_s-592B.champsimtrace.xz " &
cd ../
mkdir -p ./628.pop2_s-17B_4T_base && cd ./628.pop2_s-17B_4T_base
srun --ntasks=1 -N1 -c 1 -J 628.pop2_s-17B_4T_base -o 628.pop2_s-17B_4T_base.out -e 628.pop2_s-17B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/628.pop2_s-17B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/628.pop2_s-17B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/628.pop2_s-17B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/628.pop2_s-17B.champsimtrace.xz " &
cd ../
mkdir -p ./649.fotonik3d_s-10881B_4T_base && cd ./649.fotonik3d_s-10881B_4T_base
srun --ntasks=1 -N1 -c 1 -J 649.fotonik3d_s-10881B_4T_base -o 649.fotonik3d_s-10881B_4T_base.out -e 649.fotonik3d_s-10881B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/649.fotonik3d_s-10881B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/649.fotonik3d_s-10881B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/649.fotonik3d_s-10881B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/649.fotonik3d_s-10881B.champsimtrace.xz " &
cd ../
mkdir -p ./654.roms_s-1007B_4T_base && cd ./654.roms_s-1007B_4T_base
srun --ntasks=1 -N1 -c 1 -J 654.roms_s-1007B_4T_base -o 654.roms_s-1007B_4T_base.out -e 654.roms_s-1007B_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/654.roms_s-1007B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/654.roms_s-1007B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/654.roms_s-1007B.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/654.roms_s-1007B.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base && cd ./ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base -o ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base.out -e ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base && cd ./ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base -o ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base.out -e ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base && cd ./ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base -o ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base.out -e ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base && cd ./ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base -o ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base.out -e ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base && cd ./ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base -o ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base.out -e ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base && cd ./ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base -o ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base.out -e ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base && cd ./ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base -o ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base.out -e ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base && cd ./ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base -o ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base.out -e ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base && cd ./ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base -o ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base.out -e ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base && cd ./ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base -o ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base.out -e ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base && cd ./ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base -o ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base.out -e ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base && cd ./ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base -o ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base.out -e ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base && cd ./ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base -o ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base.out -e ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base && cd ./parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base -o parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base.out -e parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base && cd ./parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base -o parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base.out -e parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base && cd ./parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base -o parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base.out -e parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base && cd ./parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base -o parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base.out -e parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base && cd ./parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base
srun --ntasks=1 -N1 -c 1 -J parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base -o parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base.out -e parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base.err /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//wrapper.sh /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/8C_2b_BR2_T64 "--warmup_instructions=50000000 --simulation_instructions=200000000 -traces /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia//traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz " &
cd ../
wait
echo "done"

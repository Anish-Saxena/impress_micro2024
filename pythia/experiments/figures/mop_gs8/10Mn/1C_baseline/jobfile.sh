#!/bin/bash

#SBATCH -A gts-mqureshi4-rg

#SBATCH -J 1C_baseline

#SBATCH --cpus-per-task 1

#SBATCH --ntasks 36

#SBATCH --mem-per-cpu=8G

#SBATCH -t 1-23:00:00

#SBATCH -o $IMPRESS_AE_ROOT_DIR/pythia/results/%j.out

export LD_LIBRARY_PATH=$IMPRESS_AE_ROOT_DIR/dramsim3:$LD_LIBRARY_PATH

mkdir -p ./fotonik3d_1T_base && cd ./fotonik3d_1T_base
srun --ntasks=1 -N1 -c 1 -J fotonik3d_1T_base -o fotonik3d_1T_base.out -e fotonik3d_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/649.fotonik3d_s-10881B.champsimtrace.xz " &
cd ../
mkdir -p ./mcf_1T_base && cd ./mcf_1T_base
srun --ntasks=1 -N1 -c 1 -J mcf_1T_base -o mcf_1T_base.out -e mcf_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/605.mcf_s-994B.champsimtrace.xz " &
cd ../
mkdir -p ./lbm_1T_base && cd ./lbm_1T_base
srun --ntasks=1 -N1 -c 1 -J lbm_1T_base -o lbm_1T_base.out -e lbm_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/619.lbm_s-3766B.champsimtrace.xz " &
cd ../
mkdir -p ./gcc_1T_base && cd ./gcc_1T_base
srun --ntasks=1 -N1 -c 1 -J gcc_1T_base -o gcc_1T_base.out -e gcc_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/602.gcc_s-1850B.champsimtrace.xz " &
cd ../
mkdir -p ./omnetpp_1T_base && cd ./omnetpp_1T_base
srun --ntasks=1 -N1 -c 1 -J omnetpp_1T_base -o omnetpp_1T_base.out -e omnetpp_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/620.omnetpp_s-141B.champsimtrace.xz " &
cd ../
mkdir -p ./bwaves_1T_base && cd ./bwaves_1T_base
srun --ntasks=1 -N1 -c 1 -J bwaves_1T_base -o bwaves_1T_base.out -e bwaves_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/603.bwaves_s-2931B.champsimtrace.xz " &
cd ../
mkdir -p ./roms_1T_base && cd ./roms_1T_base
srun --ntasks=1 -N1 -c 1 -J roms_1T_base -o roms_1T_base.out -e roms_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/654.roms_s-1007B.champsimtrace.xz " &
cd ../
mkdir -p ./cactuBSSN_1T_base && cd ./cactuBSSN_1T_base
srun --ntasks=1 -N1 -c 1 -J cactuBSSN_1T_base -o cactuBSSN_1T_base.out -e cactuBSSN_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/607.cactuBSSN_s-2421B.champsimtrace.xz " &
cd ../
mkdir -p ./wrf_1T_base && cd ./wrf_1T_base
srun --ntasks=1 -N1 -c 1 -J wrf_1T_base -o wrf_1T_base.out -e wrf_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/621.wrf_s-6673B.champsimtrace.xz " &
cd ../
mkdir -p ./pop2_1T_base && cd ./pop2_1T_base
srun --ntasks=1 -N1 -c 1 -J pop2_1T_base -o pop2_1T_base.out -e pop2_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/628.pop2_s-17B.champsimtrace.xz " &
cd ../
mkdir -p ./cam4_1T_base && cd ./cam4_1T_base
srun --ntasks=1 -N1 -c 1 -J cam4_1T_base -o cam4_1T_base.out -e cam4_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/627.cam4_s-573B.champsimtrace.xz " &
cd ../
mkdir -p ./xalancbmk_1T_base && cd ./xalancbmk_1T_base
srun --ntasks=1 -N1 -c 1 -J xalancbmk_1T_base -o xalancbmk_1T_base.out -e xalancbmk_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/623.xalancbmk_s-592B.champsimtrace.xz " &
cd ../
mkdir -p ./CF_1T_base && cd ./CF_1T_base
#srun --ntasks=1 -N1 -c 1 -J CF_1T_base -o CF_1T_base.out -e CF_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./BC_1T_base && cd ./BC_1T_base
#srun --ntasks=1 -N1 -c 1 -J BC_1T_base -o BC_1T_base.out -e BC_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./PR-Delta_1T_base && cd ./PR-Delta_1T_base
#srun --ntasks=1 -N1 -c 1 -J PR-Delta_1T_base -o PR-Delta_1T_base.out -e PR-Delta_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./BFSCC_1T_base && cd ./BFSCC_1T_base
#srun --ntasks=1 -N1 -c 1 -J BFSCC_1T_base -o BFSCC_1T_base.out -e BFSCC_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./BFS_1T_base && cd ./BFS_1T_base
#srun --ntasks=1 -N1 -c 1 -J BFS_1T_base -o BFS_1T_base.out -e BFS_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./Radii_1T_base && cd ./Radii_1T_base
#srun --ntasks=1 -N1 -c 1 -J Radii_1T_base -o Radii_1T_base.out -e Radii_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./Triangle_1T_base && cd ./Triangle_1T_base
#srun --ntasks=1 -N1 -c 1 -J Triangle_1T_base -o Triangle_1T_base.out -e Triangle_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./Components_1T_base && cd ./Components_1T_base
#srun --ntasks=1 -N1 -c 1 -J Components_1T_base -o Components_1T_base.out -e Components_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./Comp-SC_1T_base && cd ./Comp-SC_1T_base
#srun --ntasks=1 -N1 -c 1 -J Comp-SC_1T_base -o Comp-SC_1T_base.out -e Comp-SC_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./PageRank_1T_base && cd ./PageRank_1T_base
#srun --ntasks=1 -N1 -c 1 -J PageRank_1T_base -o PageRank_1T_base.out -e PageRank_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./BFS-BV_1T_base && cd ./BFS-BV_1T_base
#srun --ntasks=1 -N1 -c 1 -J BFS-BV_1T_base -o BFS-BV_1T_base.out -e BFS-BV_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./BellmanFord_1T_base && cd ./BellmanFord_1T_base
#srun --ntasks=1 -N1 -c 1 -J BellmanFord_1T_base -o BellmanFord_1T_base.out -e BellmanFord_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./MIS_1T_base && cd ./MIS_1T_base
#srun --ntasks=1 -N1 -c 1 -J MIS_1T_base -o MIS_1T_base.out -e MIS_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./canneal_1T_base && cd ./canneal_1T_base
#srun --ntasks=1 -N1 -c 1 -J canneal_1T_base -o canneal_1T_base.out -e canneal_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./fluida_1T_base && cd ./fluida_1T_base
#srun --ntasks=1 -N1 -c 1 -J fluida_1T_base -o fluida_1T_base.out -e fluida_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./raytrace_1T_base && cd ./raytrace_1T_base
#srun --ntasks=1 -N1 -c 1 -J raytrace_1T_base -o raytrace_1T_base.out -e raytrace_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./facesim_1T_base && cd ./facesim_1T_base
#srun --ntasks=1 -N1 -c 1 -J facesim_1T_base -o facesim_1T_base.out -e facesim_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./streamc_1T_base && cd ./streamc_1T_base
#srun --ntasks=1 -N1 -c 1 -J streamc_1T_base -o streamc_1T_base.out -e streamc_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz " &
cd ../
mkdir -p ./scale_1T_base && cd ./scale_1T_base
srun --ntasks=1 -N1 -c 1 -J scale_1T_base -o scale_1T_base.out -e scale_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/scale.champsimtrace.xz " &
cd ../
mkdir -p ./add_1T_base && cd ./add_1T_base
srun --ntasks=1 -N1 -c 1 -J add_1T_base -o add_1T_base.out -e add_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/add.champsimtrace.xz " &
cd ../
mkdir -p ./triad_1T_base && cd ./triad_1T_base
srun --ntasks=1 -N1 -c 1 -J triad_1T_base -o triad_1T_base.out -e triad_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/triad.champsimtrace.xz " &
cd ../
mkdir -p ./copy_1T_base && cd ./copy_1T_base
srun --ntasks=1 -N1 -c 1 -J copy_1T_base -o copy_1T_base.out -e copy_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/copy.champsimtrace.xz " &
cd ../
mkdir -p ./kmeans_1T_base && cd ./kmeans_1T_base
#srun --ntasks=1 -N1 -c 1 -J kmeans_1T_base -o kmeans_1T_base.out -e kmeans_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/kmeans.champsimtrace.xz " &
cd ../
mkdir -p ./masstree_1T_base && cd ./masstree_1T_base
#srun --ntasks=1 -N1 -c 1 -J masstree_1T_base -o masstree_1T_base.out -e masstree_1T_base.err $IMPRESS_AE_ROOT_DIR/pythia/wrapper.sh $IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline "--warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/masstree.champsimtrace.xz " &
cd ../
wait
echo "done"
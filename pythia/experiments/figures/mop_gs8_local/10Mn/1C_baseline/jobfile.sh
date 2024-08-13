#!/bin/bash








export LD_LIBRARY_PATH=$IMPRESS_AE_ROOT_DIR/dramsim3:$LD_LIBRARY_PATH

mkdir -p ./fotonik3d_1T_base && cd ./fotonik3d_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/649.fotonik3d_s-10881B.champsimtrace.xz  &
cd ../
mkdir -p ./mcf_1T_base && cd ./mcf_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/605.mcf_s-994B.champsimtrace.xz  &
cd ../
mkdir -p ./lbm_1T_base && cd ./lbm_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/619.lbm_s-3766B.champsimtrace.xz  &
cd ../
mkdir -p ./gcc_1T_base && cd ./gcc_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/602.gcc_s-1850B.champsimtrace.xz  &
cd ../
mkdir -p ./omnetpp_1T_base && cd ./omnetpp_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/620.omnetpp_s-141B.champsimtrace.xz  &
cd ../
mkdir -p ./bwaves_1T_base && cd ./bwaves_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/603.bwaves_s-2931B.champsimtrace.xz  &
cd ../
mkdir -p ./roms_1T_base && cd ./roms_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/654.roms_s-1007B.champsimtrace.xz  &
cd ../
mkdir -p ./cactuBSSN_1T_base && cd ./cactuBSSN_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/607.cactuBSSN_s-2421B.champsimtrace.xz  &
cd ../
mkdir -p ./wrf_1T_base && cd ./wrf_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/621.wrf_s-6673B.champsimtrace.xz  &
cd ../
mkdir -p ./pop2_1T_base && cd ./pop2_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/628.pop2_s-17B.champsimtrace.xz  &
cd ../
mkdir -p ./cam4_1T_base && cd ./cam4_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/627.cam4_s-573B.champsimtrace.xz  &
cd ../
mkdir -p ./xalancbmk_1T_base && cd ./xalancbmk_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/623.xalancbmk_s-592B.champsimtrace.xz  &
cd ../
mkdir -p ./CF_1T_base && cd ./CF_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./BC_1T_base && cd ./BC_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./PR-Delta_1T_base && cd ./PR-Delta_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./BFSCC_1T_base && cd ./BFSCC_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./BFS_1T_base && cd ./BFS_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./Radii_1T_base && cd ./Radii_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./Triangle_1T_base && cd ./Triangle_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./Components_1T_base && cd ./Components_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./Comp-SC_1T_base && cd ./Comp-SC_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./PageRank_1T_base && cd ./PageRank_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./BFS-BV_1T_base && cd ./BFS-BV_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./BellmanFord_1T_base && cd ./BellmanFord_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./MIS_1T_base && cd ./MIS_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./canneal_1T_base && cd ./canneal_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./fluida_1T_base && cd ./fluida_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./raytrace_1T_base && cd ./raytrace_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./facesim_1T_base && cd ./facesim_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./streamc_1T_base && cd ./streamc_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz  &
cd ../
mkdir -p ./scale_1T_base && cd ./scale_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/scale.champsimtrace.xz  &
cd ../
mkdir -p ./add_1T_base && cd ./add_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/add.champsimtrace.xz  &
cd ../
mkdir -p ./triad_1T_base && cd ./triad_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/triad.champsimtrace.xz  &
cd ../
mkdir -p ./copy_1T_base && cd ./copy_1T_base
$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/copy.champsimtrace.xz  &
cd ../
mkdir -p ./kmeans_1T_base && cd ./kmeans_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/kmeans.champsimtrace.xz  &
cd ../
mkdir -p ./masstree_1T_base && cd ./masstree_1T_base
#$IMPRESS_AE_ROOT_DIR/champsim/bin/MOP_GS8/1C_baseline --warmup_instructions=10000000 --simulation_instructions=10000000 -traces $IMPRESS_AE_ROOT_DIR/pythia/traces/masstree.champsimtrace.xz  &
cd ../
wait
echo done
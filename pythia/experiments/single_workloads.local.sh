#!/bin/bash
#
#
#
# Traces:
#    649.fotonik3d_s-10881B_4T
#    605.mcf_s-994B_4T
#    602.gcc_s-1850B_4T
#    620.omnetpp_s-141B_4T
#    603.bwaves_s-2931B_4T
#    654.roms_s-1007B_4T
#    607.cactuBSSN_s-2421B_4T
#    621.wrf_s-6673B_4T
#    628.pop2_s-17B_4T
#    623.xalancbmk_s-592B_4T
#    ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T
#    ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T
#    ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T
#    ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T
#    ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T
#    ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T
#    ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T
#    ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T
#    ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T
#    ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T
#    ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T
#    ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T
#    ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T
#    parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T
#    parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T
#    parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T
#    parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T
#    parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T
#
#
# Experiments:
#    base: --warmup_instructions=50000000 --simulation_instructions=200000000
#
#
#
#
export LD_LIBRARY_PATH=/home/anish/start_hpca24_ae/dramsim3/:$LD_LIBRARY_PATH

mkdir -p ./649.fotonik3d_s-10881B_4T_base && cd ./649.fotonik3d_s-10881B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/649.fotonik3d_s-10881B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/649.fotonik3d_s-10881B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/649.fotonik3d_s-10881B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/649.fotonik3d_s-10881B.champsimtrace.xz > 649.fotonik3d_s-10881B_4T_base.out 2>&1 &
cd ../
mkdir -p ./605.mcf_s-994B_4T_base && cd ./605.mcf_s-994B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/605.mcf_s-994B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/605.mcf_s-994B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/605.mcf_s-994B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/605.mcf_s-994B.champsimtrace.xz > 605.mcf_s-994B_4T_base.out 2>&1 &
cd ../
mkdir -p ./602.gcc_s-1850B_4T_base && cd ./602.gcc_s-1850B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/602.gcc_s-1850B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/602.gcc_s-1850B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/602.gcc_s-1850B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/602.gcc_s-1850B.champsimtrace.xz > 602.gcc_s-1850B_4T_base.out 2>&1 &
cd ../
mkdir -p ./620.omnetpp_s-141B_4T_base && cd ./620.omnetpp_s-141B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/620.omnetpp_s-141B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/620.omnetpp_s-141B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/620.omnetpp_s-141B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/620.omnetpp_s-141B.champsimtrace.xz > 620.omnetpp_s-141B_4T_base.out 2>&1 &
cd ../
mkdir -p ./603.bwaves_s-2931B_4T_base && cd ./603.bwaves_s-2931B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/603.bwaves_s-2931B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/603.bwaves_s-2931B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/603.bwaves_s-2931B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/603.bwaves_s-2931B.champsimtrace.xz > 603.bwaves_s-2931B_4T_base.out 2>&1 &
cd ../
mkdir -p ./654.roms_s-1007B_4T_base && cd ./654.roms_s-1007B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/654.roms_s-1007B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/654.roms_s-1007B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/654.roms_s-1007B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/654.roms_s-1007B.champsimtrace.xz > 654.roms_s-1007B_4T_base.out 2>&1 &
cd ../
mkdir -p ./607.cactuBSSN_s-2421B_4T_base && cd ./607.cactuBSSN_s-2421B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/607.cactuBSSN_s-2421B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/607.cactuBSSN_s-2421B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/607.cactuBSSN_s-2421B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/607.cactuBSSN_s-2421B.champsimtrace.xz > 607.cactuBSSN_s-2421B_4T_base.out 2>&1 &
cd ../
mkdir -p ./621.wrf_s-6673B_4T_base && cd ./621.wrf_s-6673B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/621.wrf_s-6673B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/621.wrf_s-6673B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/621.wrf_s-6673B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/621.wrf_s-6673B.champsimtrace.xz > 621.wrf_s-6673B_4T_base.out 2>&1 &
cd ../
mkdir -p ./628.pop2_s-17B_4T_base && cd ./628.pop2_s-17B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/628.pop2_s-17B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/628.pop2_s-17B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/628.pop2_s-17B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/628.pop2_s-17B.champsimtrace.xz > 628.pop2_s-17B_4T_base.out 2>&1 &
cd ../
mkdir -p ./623.xalancbmk_s-592B_4T_base && cd ./623.xalancbmk_s-592B_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/623.xalancbmk_s-592B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/623.xalancbmk_s-592B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/623.xalancbmk_s-592B.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/623.xalancbmk_s-592B.champsimtrace.xz > 623.xalancbmk_s-592B_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base && cd ./ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz > ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base && cd ./ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz > ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base && cd ./ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz > ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base && cd ./ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz > ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base && cd ./ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz > ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base && cd ./ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz > ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base && cd ./ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz > ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base && cd ./ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz > ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base && cd ./ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz > ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base && cd ./ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz > ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base && cd ./ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz > ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base && cd ./ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz > ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base && cd ./ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz > ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base && cd ./parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz > parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base && cd ./parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz > parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base && cd ./parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz > parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base && cd ./parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz > parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M_4T_base.out 2>&1 &
cd ../
mkdir -p ./parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base && cd ./parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base
/home/anish/start_hpca24_ae/champsim/bin/8C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz > parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M_4T_base.out 2>&1 &
cd ../
wait
echo "done"
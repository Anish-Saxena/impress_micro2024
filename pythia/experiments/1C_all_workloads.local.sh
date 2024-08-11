#!/bin/bash
#
#
#
# Traces:
#    fotonik3d_1T
#    mcf_1T
#    gcc_1T
#    omnetpp_1T
#    bwaves_1T
#    roms_1T
#    cactuBSSN_1T
#    wrf_1T
#    pop2_1T
#    xalancbmk_1T
#    CF_1T
#    BC_1T
#    PR-Delta_1T
#    BFSCC_1T
#    BFS_1T
#    Radii_1T
#    Triangle_1T
#    Components_1T
#    Comp-SC_1T
#    PageRank_1T
#    BFS-BV_1T
#    BellmanFord_1T
#    MIS_1T
#    canneal_1T
#    fluida_1T
#    raytrace_1T
#    facesim_1T
#    streamc_1T
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
#
#
# Experiments:
#    base: --warmup_instructions=50000000 --simulation_instructions=200000000
#
#
#
#
export LD_LIBRARY_PATH=/home/anish/start_hpca24_ae/dramsim3/:$LD_LIBRARY_PATH

mkdir -p ./fotonik3d_1T_base && cd ./fotonik3d_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/649.fotonik3d_s-10881B.champsimtrace.xz > fotonik3d_1T_base.out 2>&1 &
cd ../
mkdir -p ./mcf_1T_base && cd ./mcf_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/605.mcf_s-994B.champsimtrace.xz > mcf_1T_base.out 2>&1 &
cd ../
mkdir -p ./gcc_1T_base && cd ./gcc_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/602.gcc_s-1850B.champsimtrace.xz > gcc_1T_base.out 2>&1 &
cd ../
mkdir -p ./omnetpp_1T_base && cd ./omnetpp_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/620.omnetpp_s-141B.champsimtrace.xz > omnetpp_1T_base.out 2>&1 &
cd ../
mkdir -p ./bwaves_1T_base && cd ./bwaves_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/603.bwaves_s-2931B.champsimtrace.xz > bwaves_1T_base.out 2>&1 &
cd ../
mkdir -p ./roms_1T_base && cd ./roms_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/654.roms_s-1007B.champsimtrace.xz > roms_1T_base.out 2>&1 &
cd ../
mkdir -p ./cactuBSSN_1T_base && cd ./cactuBSSN_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/607.cactuBSSN_s-2421B.champsimtrace.xz > cactuBSSN_1T_base.out 2>&1 &
cd ../
mkdir -p ./wrf_1T_base && cd ./wrf_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/621.wrf_s-6673B.champsimtrace.xz > wrf_1T_base.out 2>&1 &
cd ../
mkdir -p ./pop2_1T_base && cd ./pop2_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/628.pop2_s-17B.champsimtrace.xz > pop2_1T_base.out 2>&1 &
cd ../
mkdir -p ./xalancbmk_1T_base && cd ./xalancbmk_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/623.xalancbmk_s-592B.champsimtrace.xz > xalancbmk_1T_base.out 2>&1 &
cd ../
mkdir -p ./CF_1T_base && cd ./CF_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_CF.com-lj.ungraph.gcc_6.3.0_O3.drop_184750M.length_250M.champsimtrace.xz > CF_1T_base.out 2>&1 &
cd ../
mkdir -p ./BC_1T_base && cd ./BC_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BC.com-lj.ungraph.gcc_6.3.0_O3.drop_26750M.length_250M.champsimtrace.xz > BC_1T_base.out 2>&1 &
cd ../
mkdir -p ./PR-Delta_1T_base && cd ./PR-Delta_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRankDelta.com-lj.ungraph.gcc_6.3.0_O3.drop_24000M.length_250M.champsimtrace.xz > PR-Delta_1T_base.out 2>&1 &
cd ../
mkdir -p ./BFSCC_1T_base && cd ./BFSCC_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BFSCC.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz > BFSCC_1T_base.out 2>&1 &
cd ../
mkdir -p ./BFS_1T_base && cd ./BFS_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS.com-lj.ungraph.gcc_6.3.0_O3.drop_21500M.length_250M.champsimtrace.xz > BFS_1T_base.out 2>&1 &
cd ../
mkdir -p ./Radii_1T_base && cd ./Radii_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Radii.com-lj.ungraph.gcc_6.3.0_O3.drop_32000M.length_250M.champsimtrace.xz > Radii_1T_base.out 2>&1 &
cd ../
mkdir -p ./Triangle_1T_base && cd ./Triangle_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Triangle.com-lj.ungraph.gcc_6.3.0_O3.drop_25000M.length_250M.champsimtrace.xz > Triangle_1T_base.out 2>&1 &
cd ../
mkdir -p ./Components_1T_base && cd ./Components_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Components.com-lj.ungraph.gcc_6.3.0_O3.drop_22750M.length_250M.champsimtrace.xz > Components_1T_base.out 2>&1 &
cd ../
mkdir -p ./Comp-SC_1T_base && cd ./Comp-SC_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_Components-Shortcut.com-lj.ungraph.gcc_6.3.0_O3.drop_22000M.length_250M.champsimtrace.xz > Comp-SC_1T_base.out 2>&1 &
cd ../
mkdir -p ./PageRank_1T_base && cd ./PageRank_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_PageRank.com-lj.ungraph.gcc_6.3.0_O3.drop_21750M.length_250M.champsimtrace.xz > PageRank_1T_base.out 2>&1 &
cd ../
mkdir -p ./BFS-BV_1T_base && cd ./BFS-BV_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BFS-Bitvector.com-lj.ungraph.gcc_6.3.0_O3.drop_23000M.length_250M.champsimtrace.xz > BFS-BV_1T_base.out 2>&1 &
cd ../
mkdir -p ./BellmanFord_1T_base && cd ./BellmanFord_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_BellmanFord.com-lj.ungraph.gcc_6.3.0_O3.drop_7500M.length_250M.champsimtrace.xz > BellmanFord_1T_base.out 2>&1 &
cd ../
mkdir -p ./MIS_1T_base && cd ./MIS_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/ligra_MIS.com-lj.ungraph.gcc_6.3.0_O3.drop_21250M.length_250M.champsimtrace.xz > MIS_1T_base.out 2>&1 &
cd ../
mkdir -p ./canneal_1T_base && cd ./canneal_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.canneal.simlarge.prebuilt.drop_4500M.length_250M.champsimtrace.xz > canneal_1T_base.out 2>&1 &
cd ../
mkdir -p ./fluida_1T_base && cd ./fluida_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.fluidanimate.simlarge.prebuilt.drop_9500M.length_250M.champsimtrace.xz > fluida_1T_base.out 2>&1 &
cd ../
mkdir -p ./raytrace_1T_base && cd ./raytrace_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.raytrace.simlarge.prebuilt.drop_23500M.length_250M.champsimtrace.xz > raytrace_1T_base.out 2>&1 &
cd ../
mkdir -p ./facesim_1T_base && cd ./facesim_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.facesim.simlarge.prebuilt.drop_1500M.length_250M.champsimtrace.xz > facesim_1T_base.out 2>&1 &
cd ../
mkdir -p ./streamc_1T_base && cd ./streamc_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000  -traces /home/anish/start_hpca24_ae/experiments/traces/parsec_2.1.streamcluster.simlarge.prebuilt.drop_14750M.length_250M.champsimtrace.xz > streamc_1T_base.out 2>&1 &
cd ../
mkdir -p ./cassandra_phase1_core0_1T_base && cd ./cassandra_phase1_core0_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cassandra_phase1_core0.trace.xz  > cassandra_phase1_core0_1T_base.out 2>&1 &
cd ../
mkdir -p ./cassandra_phase1_core1_1T_base && cd ./cassandra_phase1_core1_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cassandra_phase1_core1.trace.xz  > cassandra_phase1_core1_1T_base.out 2>&1 &
cd ../
mkdir -p ./cassandra_phase1_core2_1T_base && cd ./cassandra_phase1_core2_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cassandra_phase1_core2.trace.xz  > cassandra_phase1_core2_1T_base.out 2>&1 &
cd ../
mkdir -p ./cassandra_phase1_core3_1T_base && cd ./cassandra_phase1_core3_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cassandra_phase1_core3.trace.xz  > cassandra_phase1_core3_1T_base.out 2>&1 &
cd ../
mkdir -p ./classification_phase1_core0_1T_base && cd ./classification_phase1_core0_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/classification_phase1_core0.trace.xz  > classification_phase1_core0_1T_base.out 2>&1 &
cd ../
mkdir -p ./classification_phase1_core1_1T_base && cd ./classification_phase1_core1_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/classification_phase1_core1.trace.xz  > classification_phase1_core1_1T_base.out 2>&1 &
cd ../
mkdir -p ./classification_phase1_core2_1T_base && cd ./classification_phase1_core2_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/classification_phase1_core2.trace.xz  > classification_phase1_core2_1T_base.out 2>&1 &
cd ../
mkdir -p ./classification_phase1_core3_1T_base && cd ./classification_phase1_core3_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/classification_phase1_core3.trace.xz  > classification_phase1_core3_1T_base.out 2>&1 &
cd ../
mkdir -p ./cloud9_phase1_core0_1T_base && cd ./cloud9_phase1_core0_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cloud9_phase1_core0.trace.xz  > cloud9_phase1_core0_1T_base.out 2>&1 &
cd ../
mkdir -p ./cloud9_phase1_core1_1T_base && cd ./cloud9_phase1_core1_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cloud9_phase1_core1.trace.xz  > cloud9_phase1_core1_1T_base.out 2>&1 &
cd ../
mkdir -p ./cloud9_phase1_core2_1T_base && cd ./cloud9_phase1_core2_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cloud9_phase1_core2.trace.xz  > cloud9_phase1_core2_1T_base.out 2>&1 &
cd ../
mkdir -p ./cloud9_phase1_core3_1T_base && cd ./cloud9_phase1_core3_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/cloud9_phase1_core3.trace.xz  > cloud9_phase1_core3_1T_base.out 2>&1 &
cd ../
mkdir -p ./nutch_phase1_core0_1T_base && cd ./nutch_phase1_core0_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/nutch_phase1_core0.trace.xz  > nutch_phase1_core0_1T_base.out 2>&1 &
cd ../
mkdir -p ./nutch_phase1_core1_1T_base && cd ./nutch_phase1_core1_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/nutch_phase1_core1.trace.xz  > nutch_phase1_core1_1T_base.out 2>&1 &
cd ../
mkdir -p ./nutch_phase1_core2_1T_base && cd ./nutch_phase1_core2_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/nutch_phase1_core2.trace.xz  > nutch_phase1_core2_1T_base.out 2>&1 &
cd ../
mkdir -p ./nutch_phase1_core3_1T_base && cd ./nutch_phase1_core3_1T_base
/home/anish/start_hpca24_ae/champsim/bin/1C_16WLLC --warmup_instructions=50000000 --simulation_instructions=200000000 -cs_traces=y -traces /home/anish/start_hpca24_ae/experiments/traces/nutch_phase1_core3.trace.xz  > nutch_phase1_core3_1T_base.out 2>&1 &
cd ../
wait
echo "done"
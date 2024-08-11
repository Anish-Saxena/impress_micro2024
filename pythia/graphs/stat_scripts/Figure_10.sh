#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
# STAT_DIR="../../experiments/8C_200Mn_Sim/"

CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/blast_radius_sensitivity.csv"

cd ${STAT_DIR}/;

echo "SUITE	Config	Cache	ideal	start_d" > ${OUT_FILE}

# BR1

IDEAL_T256_DIR="8C_ideal_T256/"
START_D_T256_DIR="8C_2b_T256/"
IDEAL_T64_DIR="8C_ideal_T64/"
START_D_T64_DIR="8C_2b_T64/"

# IDEAL_T256_DIR="IT.T256/"
# START_D_T256_DIR="2b.T256/"
# IDEAL_T64_DIR="IT.T64/"
# START_D_T64_DIR="2b.T64/"

IDEAL_T256=`python get_norm_ipc.py ${IDEAL_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T256=`python get_norm_ipc.py ${START_D_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
IDEAL_T64=`python get_norm_ipc.py ${IDEAL_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T64=`python get_norm_ipc.py ${START_D_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL T=256 BR1" $IDEAL_T256 $START_D_T256 >> ${OUT_FILE}
echo "ALL T=64 BR1" $IDEAL_T64 $START_D_T64 >> ${OUT_FILE}
echo "0	0	0	0	0" >> ${OUT_FILE}

# BR2

IDEAL_T256_DIR="8C_ideal_BR2_T256/"
START_D_T256_DIR="8C_2b_BR2_T256/"
IDEAL_T64_DIR="8C_ideal_BR2_T64/"
START_D_T64_DIR="8C_2b_BR2_T64/"

# IDEAL_T256_DIR="IT.BR2.T256/"
# START_D_T256_DIR="2b.BR2.T256/"
# IDEAL_T64_DIR="IT.BR2.T64/"
# START_D_T64_DIR="2b.BR2.T64/"

IDEAL_T256=`python get_norm_ipc.py ${IDEAL_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T256=`python get_norm_ipc.py ${START_D_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
IDEAL_T64=`python get_norm_ipc.py ${IDEAL_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T64=`python get_norm_ipc.py ${START_D_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL T=256 BR2" $IDEAL_T256 $START_D_T256 >> ${OUT_FILE}
echo "ALL T=64 BR2" $IDEAL_T64 $START_D_T64 >> ${OUT_FILE}
echo "0	0	0	0	0" >> ${OUT_FILE}

# BR4

IDEAL_T256_DIR="8C_ideal_BR4_T256/"
START_D_T256_DIR="8C_2b_BR4_T256/"
IDEAL_T64_DIR="8C_ideal_BR4_T64/"
START_D_T64_DIR="8C_2b_BR4_T64/"

# IDEAL_T256_DIR="IT.BR4.T256/"
# START_D_T256_DIR="2b.BR4.T256/"
# IDEAL_T64_DIR="IT.BR4.T64/"
# START_D_T64_DIR="2b.BR4.T64/"

IDEAL_T256=`python get_norm_ipc.py ${IDEAL_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T256=`python get_norm_ipc.py ${START_D_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
IDEAL_T64=`python get_norm_ipc.py ${IDEAL_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T64=`python get_norm_ipc.py ${START_D_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL T=256 BR4" $IDEAL_T256 $START_D_T256 >> ${OUT_FILE}
echo "ALL T=64 BR4" $IDEAL_T64 $START_D_T64 >> ${OUT_FILE}

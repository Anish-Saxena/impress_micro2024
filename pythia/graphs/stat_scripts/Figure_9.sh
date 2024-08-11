#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
# STAT_DIR="../../experiments/8C_200Mn_Sim/"

CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/cache_sensitivity.csv"

cd ${STAT_DIR}/;

echo "SUITE	Config	Cache	ideal	start_d" > ${OUT_FILE}

# 12MB LLC

IDEAL_T256_DIR="8C_ideal_1.5MB_T256/"
START_D_T256_DIR="8C_2b_1.5MB_T256/"
IDEAL_T64_DIR="8C_ideal_1.5MB_T64/"
START_D_T64_DIR="8C_2b_1.5MB_T64/"

# IDEAL_T256_DIR="IT.1.5MB_T256/"
# START_D_T256_DIR="2b.1.5MB_T256/"
# IDEAL_T64_DIR="IT.1.5MB_T64/"
# START_D_T64_DIR="2b.1.5MB_T64/"

IDEAL_T256=`python get_norm_ipc.py ${IDEAL_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T256=`python get_norm_ipc.py ${START_D_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
IDEAL_T64=`python get_norm_ipc.py ${IDEAL_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T64=`python get_norm_ipc.py ${START_D_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL T=256 1.5MB" $IDEAL_T256 $START_D_T256 >> ${OUT_FILE}
echo "ALL T=64 1.5MB" $IDEAL_T64 $START_D_T64 >> ${OUT_FILE}
echo "0	0	0	0	0" >> ${OUT_FILE}

# 16MB LLC

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

echo "ALL T=256 2MB" $IDEAL_T256 $START_D_T256 >> ${OUT_FILE}
echo "ALL T=64 2MB" $IDEAL_T64 $START_D_T64 >> ${OUT_FILE}
echo "0	0	0	0	0" >> ${OUT_FILE}

# 24MB LLC

IDEAL_T256_DIR="8C_ideal_3MB_T256/"
START_D_T256_DIR="8C_2b_3MB_T256/"
IDEAL_T64_DIR="8C_ideal_3MB_T64/"
START_D_T64_DIR="8C_2b_3MB_T64/"

# IDEAL_T256_DIR="IT.3MB_T256/"
# START_D_T256_DIR="2b.3MB_T256/"
# IDEAL_T64_DIR="IT.3MB_T64/"
# START_D_T64_DIR="2b.3MB_T64/"

IDEAL_T256=`python get_norm_ipc.py ${IDEAL_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T256=`python get_norm_ipc.py ${START_D_T256_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
IDEAL_T64=`python get_norm_ipc.py ${IDEAL_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START_D_T64=`python get_norm_ipc.py ${START_D_T64_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL T=256 3MB" $IDEAL_T256 $START_D_T256 >> ${OUT_FILE}
echo "ALL T=64 3MB" $IDEAL_T64 $START_D_T64 >> ${OUT_FILE}

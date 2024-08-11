#!/bin/bash

STAT_DIR="../../experiments/representative_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/start_T256.csv"

cd ${STAT_DIR}/;

IDEAL_DIR="8C_ideal_T256/"
START_S_DIR="8C_1b_T256/"
START_D_DIR="8C_2b_T256/"

echo "workload ideal start_s start_d" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${IDEAL_DIR} BMK_NAMES_OUTPUT`
IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} DETAILED_OUTPUT`
START_S=`python get_norm_ipc.py ${START_S_DIR} DETAILED_OUTPUT`
START_D=`python get_norm_ipc.py ${START_D_DIR} DETAILED_OUTPUT`

paste <(echo "$BMK_NAMES") <(echo "$IDEAL") <(echo "$START_S") <(echo "$START_D") >> ${OUT_FILE}
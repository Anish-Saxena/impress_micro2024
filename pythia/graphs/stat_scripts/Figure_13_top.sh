#!/bin/bash

STAT_DIR="../../experiments/representative_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/start_m_T256.csv"

cd ${STAT_DIR}/;

IDEAL_DIR="8C_ideal_512GB_T256/"
START_M_DIR="8C_mm_T256/"

echo "workload ideal start_m" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${IDEAL_DIR} BMK_NAMES_OUTPUT`
IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} DETAILED_OUTPUT`
START_M=`python get_norm_ipc.py ${START_M_DIR} DETAILED_OUTPUT`

paste <(echo "$BMK_NAMES") <(echo "$IDEAL") <(echo "$START_S") <(echo "$START_M") >> ${OUT_FILE}
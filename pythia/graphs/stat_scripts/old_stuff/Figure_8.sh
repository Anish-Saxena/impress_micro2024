#!/bin/bash

STAT_DIR="../../experiments/representative_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/cache_misses.csv"

cd ${STAT_DIR}/;

START_D_DIR="8C_2b_T256/"
START_S_DIR="8C_1b_T256/"

echo "workload start_s start_d" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${START_D_DIR} BMK_NAMES_OUTPUT | grep -v LIGRA | grep -v PARSEC | grep -v SPEC`
START_S=`python get_llc_rel_misses.py ${START_S_DIR}`
START_D=`python get_llc_rel_misses.py ${START_D_DIR}`

paste <(echo "$BMK_NAMES") <(echo "$START_S") <(echo "$START_D") >> ${OUT_FILE}
#!/bin/bash

STAT_DIR="../../experiments/representative_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/capacity_loss.csv"

cd ${STAT_DIR}/;

START_D_DIR="8C_2b_T256/"

echo "workload start_d" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${START_D_DIR} BMK_NAMES_OUTPUT | grep -v LIGRA | grep -v PARSEC | grep -v SPEC`
START_D=`python get_llc_cap_loss.py ${START_D_DIR}`

paste <(echo "$BMK_NAMES") <(echo "$START_D") >> ${OUT_FILE}
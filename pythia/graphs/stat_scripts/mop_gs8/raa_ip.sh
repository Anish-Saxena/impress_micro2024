#!/bin/bash

STAT_DIR="../../../experiments/figures/mop_gs8/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/raa_ip.csv"

cd ${STAT_DIR}/;

suite1_DIR="raa_rfm/no_ref/TH80/"
suite2_DIR="raa_rfm/no_ref/TH40/"


echo "workload	th80	th40" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${suite1_DIR} BMK_NAMES_OUTPUT`
suite1=`python get_norm_ipc.py ${suite1_DIR} DETAILED_OUTPUT`
suite2=`python get_norm_ipc.py ${suite2_DIR} DETAILED_OUTPUT`


paste <(echo "$BMK_NAMES") <(echo "$suite1") <(echo "$suite2") >> ${OUT_FILE}
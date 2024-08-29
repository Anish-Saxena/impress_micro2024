#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/rh_mitigations_100M.csv"

cd ${STAT_DIR}/;

suite0_DIR="para.rfm.T1K.4ch.64GB/"
suite1_DIR="raa.rfm.T1K.4ch.64GB/"
suite2_DIR="mg.rfm.T1K.4ch.64GB/"
suite3_DIR="para.rfm.T1K.exPRE.1tRC/"
suite4_DIR="raa.rfm.T1K.exPRE.1tRC/"
suite5_DIR="mg.rfm.T1K.exPRE.1tRC/"

echo "workload	para_rfm	raa_rfm	mg_rfm	suite3	suite4	suite5" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${suite0_DIR} BMK_NAMES_OUTPUT`
suite0=`python get_norm_ipc.py ${suite0_DIR} DETAILED_OUTPUT`
suite1=`python get_norm_ipc.py ${suite1_DIR} DETAILED_OUTPUT`
suite3=`python get_norm_ipc.py ${suite3_DIR} DETAILED_OUTPUT`
suite2=`python get_norm_ipc.py ${suite2_DIR} DETAILED_OUTPUT`
suite4=`python get_norm_ipc.py ${suite4_DIR} DETAILED_OUTPUT`
suite5=`python get_norm_ipc.py ${suite5_DIR} DETAILED_OUTPUT`
paste <(echo "$BMK_NAMES") <(echo "$suite0") <(echo "$suite1") <(echo "$suite2") <(echo "$suite3") <(echo "$suite4") <(echo "$suite5") >> ${OUT_FILE}
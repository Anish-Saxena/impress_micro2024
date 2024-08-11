#!/bin/bash

STAT_DIR="../../../experiments/all_figures/mop_gs8"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/mro_sensitivity_mop_gs8.csv"

cd ${STAT_DIR}/;

suite1_DIR="mro/36ns/"
suite2_DIR="mro/66ns/"
suite3_DIR="mro/96ns/"
suite4_DIR="mro/186ns/"
suite5_DIR="mro/336ns/"
suite6_DIR="mro/636ns/"

echo "workload	suite1	suite2	suite3	suite4	suite5	suite6" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${suite1_DIR} BMK_NAMES_OUTPUT`
suite1=`python get_norm_ipc.py ${suite1_DIR} DETAILED_OUTPUT`
suite2=`python get_norm_ipc.py ${suite2_DIR} DETAILED_OUTPUT`
suite4=`python get_norm_ipc.py ${suite4_DIR} DETAILED_OUTPUT`
suite3=`python get_norm_ipc.py ${suite3_DIR} DETAILED_OUTPUT`
suite5=`python get_norm_ipc.py ${suite5_DIR} DETAILED_OUTPUT`
suite6=`python get_norm_ipc.py ${suite6_DIR} DETAILED_OUTPUT`
paste <(echo "$BMK_NAMES") <(echo "$suite1") <(echo "$suite2") <(echo "$suite3") <(echo "$suite4") <(echo "$suite5") <(echo "$suite6") >> ${OUT_FILE}
#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/para_sensitivity_10M.csv"

cd ${STAT_DIR}/;

suite1_DIR="T4K/para_drfm/36ns/"
suite2_DIR="T4K/para_drfm/66ns/"
suite3_DIR="T4K/para_drfm/96ns/"
suite4_DIR="T4K/para_drfm/186ns/"
suite5_DIR="T4K/para_drfm/336ns/"
suite6_DIR="T4K/para_drfm/636ns/"
suite7_DIR="T4K/para_drfm/no_mro/"

echo "workload	suite1	suite2	suite3	suite4	suite5	suite6	suite7" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${suite1_DIR} BMK_NAMES_OUTPUT`
suite1=`python get_norm_ipc.py ${suite1_DIR} DETAILED_OUTPUT`
suite2=`python get_norm_ipc.py ${suite2_DIR} DETAILED_OUTPUT`
suite4=`python get_norm_ipc.py ${suite4_DIR} DETAILED_OUTPUT`
suite3=`python get_norm_ipc.py ${suite3_DIR} DETAILED_OUTPUT`
suite5=`python get_norm_ipc.py ${suite5_DIR} DETAILED_OUTPUT`
suite6=`python get_norm_ipc.py ${suite6_DIR} DETAILED_OUTPUT`
suite7=`python get_norm_ipc.py ${suite7_DIR} DETAILED_OUTPUT`

paste <(echo "$BMK_NAMES") <(echo "$suite1") <(echo "$suite2") <(echo "$suite3") <(echo "$suite4") <(echo "$suite5") <(echo "$suite6") <(echo "$suite7") >> ${OUT_FILE}
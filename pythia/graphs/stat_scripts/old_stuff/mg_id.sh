#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/mg_id_10M.csv"

cd ${STAT_DIR}/;

suite1_DIR="mg_drfm_T1000/66ns/"
suite2_DIR="mg_drfm_T1000/id_alpha35/"
suite3_DIR="mg_drfm_T1000/id_alpha100/"
# suite4_DIR="para_drfm_T1000/186ns/"
# suite5_DIR="para_drfm_T1000/336ns/"
# suite6_DIR="para_drfm_T1000/636ns/"
# suite7_DIR="para_drfm_T1000/no_mro/"

echo "workload	exp	id_alpha35	id_alpha100" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${suite1_DIR} BMK_NAMES_OUTPUT`
suite1=`python get_norm_ipc.py ${suite1_DIR} DETAILED_OUTPUT mg_drfm_T1000/no_mro/`
suite2=`python get_norm_ipc.py ${suite2_DIR} DETAILED_OUTPUT mg_drfm_T1000/no_mro/`
suite3=`python get_norm_ipc.py ${suite3_DIR} DETAILED_OUTPUT mg_drfm_T1000/no_mro/`
# suite3=`python get_norm_ipc.py ${suite3_DIR} DETAILED_OUTPUT`
# suite5=`python get_norm_ipc.py ${suite5_DIR} DETAILED_OUTPUT`
# suite6=`python get_norm_ipc.py ${suite6_DIR} DETAILED_OUTPUT`
# suite7=`python get_norm_ipc.py ${suite7_DIR} DETAILED_OUTPUT`

paste <(echo "$BMK_NAMES") <(echo "$suite1") <(echo "$suite2") <(echo "$suite3") >> ${OUT_FILE}
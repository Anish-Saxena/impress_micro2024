#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/para_all_eact_10M.csv"

cd ${STAT_DIR}/;

suite1_DIR="para_drfm_T1000/84ns_alpha35/"
suite2_DIR="para_drfm_T1000/84ns_alpha100/"
suite3_DIR="para_drfm_T1000/id_alpha35/"
suite4_DIR="para_drfm_T1000/id_alpha100/"
suite5_DIR="para_drfm_T1000/ip/"
suite6_DIR="para_drfm_T1000/no_mro/"
# suite7_DIR="para_drfm_T1000/no_mro/"

echo "workload	ip" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_eact.py ${suite1_DIR} BMK_NAMES_OUTPUT`
# suite1=`python get_eact.py ${suite1_DIR} DETAILED_OUTPUT`
# echo suite1 done
# suite2=`python get_eact.py ${suite2_DIR} DETAILED_OUTPUT`
# echo suite2 done
suite5=`python get_eact.py ${suite5_DIR} DETAILED_OUTPUT`
echo suite5 done
# suite3=`python get_eact.py ${suite3_DIR} DETAILED_OUTPUT`
# echo suite3 done
# suite4=`python get_eact.py ${suite4_DIR} DETAILED_OUTPUT`
# echo suite4 done
# suite6=`python get_eact.py ${suite6_DIR} DETAILED_OUTPUT`
# echo suite6 done
# suite7=`python get_eact.py ${suite7_DIR} DETAILED_OUTPUT`

paste <(echo "$BMK_NAMES") <(echo "$suite5") >> ${OUT_FILE}
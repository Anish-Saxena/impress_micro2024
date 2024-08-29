#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/para_all_4K_10M.csv"

cd ${STAT_DIR}/;

suite1_DIR="T4K/para_drfm/84ns_alpha35/"
suite2_DIR="T4K/para_drfm/84ns_alpha100/"
suite3_DIR="T4K/para_drfm/id_alpha35/"
suite4_DIR="T4K/para_drfm/id_alpha100/"
suite5_DIR="T4K/para_drfm/ip/"
suite6_DIR="T4K/para_drfm/no_mro/"
# suite7_DIR="para_drfm_T1000/no_mro/"

echo "workload	exp_alpha35	exp_alpha100	id_alpha35	id_alpha100	ip	no_mro" > ${OUT_FILE}

# Bmk names
BMK_NAMES=`python get_norm_ipc.py ${suite1_DIR} BMK_NAMES_OUTPUT`
suite1=`python get_norm_ipc.py ${suite1_DIR} DETAILED_OUTPUT`
echo suite1 done
suite2=`python get_norm_ipc.py ${suite2_DIR} DETAILED_OUTPUT`
echo suite2 done
suite5=`python get_norm_ipc.py ${suite5_DIR} DETAILED_OUTPUT`
echo suite5 done
suite3=`python get_norm_ipc.py ${suite3_DIR} DETAILED_OUTPUT`
echo suite3 done
suite4=`python get_norm_ipc.py ${suite4_DIR} DETAILED_OUTPUT`
echo suite4 done
suite6=`python get_norm_ipc.py ${suite6_DIR} DETAILED_OUTPUT`
echo suite6 done
# suite7=`python get_norm_ipc.py ${suite7_DIR} DETAILED_OUTPUT`

paste <(echo "$BMK_NAMES") <(echo "$suite1") <(echo "$suite2") <(echo "$suite3") \
<(echo "$suite4") <(echo "$suite5") <(echo "$suite6") >> ${OUT_FILE}
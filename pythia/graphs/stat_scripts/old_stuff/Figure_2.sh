#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/motivation.csv"

cd ${STAT_DIR}/;

echo "SUITE, Config, mitigation, tracking" > ${OUT_FILE}

# Ideal Tracker

IDEAL_T256_DIR="8C_ideal_T256/"
IDEAL_T64_DIR="8C_ideal_T64/"
IDEAL_T16_DIR="8C_ideal_T16/"

IDEAL_T256_MIT=`python get_norm_ipc.py ${IDEAL_T256_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
IDEAL_T64_MIT=`python get_norm_ipc.py ${IDEAL_T64_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
IDEAL_T16_MIT=`python get_norm_ipc.py ${IDEAL_T16_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`

echo "ALL, T=256", $IDEAL_T256_MIT, "0.0" >> ${OUT_FILE}
echo "ALL, T=64", $IDEAL_T64_MIT, "0.0" >> ${OUT_FILE}
echo "ALL, T=16", $IDEAL_T16_MIT, "0.0" >> ${OUT_FILE}
echo "0.0, 0.0, 0.0, 0.0" >> ${OUT_FILE}

# Hydra-P 

HYDRA_T256_ALL_DIR="8C_Hydra_T256/"
HYDRA_T256_NOMIT_DIR="8C_Hydra_T256.NOMIT/"
HYDRA_T64_ALL_DIR="8C_Hydra_T64_RG32_S1K/"
HYDRA_T64_NOMIT_DIR="8C_Hydra_T64.NOMIT/"
HYDRA_T16_ALL_DIR="8C_Hydra_T16_RG32_S1K/"
HYDRA_T16_NOMIT_DIR="8C_Hydra_T16.NOMIT/"

HYDRA_T256_ALL=`python get_norm_ipc.py ${HYDRA_T256_ALL_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T256_NOMIT=`python get_norm_ipc.py ${HYDRA_T256_NOMIT_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T256_TRACKING=$HYDRA_T256_NOMIT
HYDRA_T256_MIT=`echo "$HYDRA_T256_ALL $HYDRA_T256_NOMIT" | awk '{print $1-$2}'`

HYDRA_T64_ALL=`python get_norm_ipc.py ${HYDRA_T64_ALL_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T64_NOMIT=`python get_norm_ipc.py ${HYDRA_T64_NOMIT_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T64_TRACKING=$HYDRA_T64_NOMIT
HYDRA_T64_MIT=`echo "$HYDRA_T64_ALL $HYDRA_T64_NOMIT" | awk '{print $1-$2}'`

HYDRA_T16_ALL=`python get_norm_ipc.py ${HYDRA_T16_ALL_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T16_NOMIT=`python get_norm_ipc.py ${HYDRA_T16_NOMIT_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T16_TRACKING=$HYDRA_T16_NOMIT
HYDRA_T16_MIT=`echo "$HYDRA_T16_ALL $HYDRA_T16_NOMIT" | awk '{print $1-$2}'`

echo "ALL, T=256", $HYDRA_T256_TRACKING, $HYDRA_T256_MIT >> ${OUT_FILE}
echo "ALL, T=64", $HYDRA_T64_TRACKING, $HYDRA_T64_MIT >> ${OUT_FILE}
echo "ALL, T=16", $HYDRA_T16_TRACKING, $HYDRA_T16_MIT >> ${OUT_FILE}
echo "0.0, 0.0, 0.0, 0.0" >> ${OUT_FILE}

# Hydra-C

HYDRA_T64_ALL_DIR="8C_Hydra_T64.186KB/"
HYDRA_T64_NOMIT_DIR="8C_Hydra_T64.186KB.NOMIT/"
HYDRA_T16_ALL_DIR="8C_Hydra_T16.186KB/"
HYDRA_T16_NOMIT_DIR="8C_Hydra_T16.186KB.NOMIT/"

HYDRA_T64_ALL=`python get_norm_ipc.py ${HYDRA_T64_ALL_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T64_NOMIT=`python get_norm_ipc.py ${HYDRA_T64_NOMIT_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T64_TRACKING=$HYDRA_T64_NOMIT
HYDRA_T64_MIT=`echo "$HYDRA_T64_ALL $HYDRA_T64_NOMIT" | awk '{print $1-$2}'`

HYDRA_T16_ALL=`python get_norm_ipc.py ${HYDRA_T16_ALL_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T16_NOMIT=`python get_norm_ipc.py ${HYDRA_T16_NOMIT_DIR} | grep GEOMEAN_SLOWDOWN | awk '{print $2}'`
HYDRA_T16_TRACKING=$HYDRA_T16_NOMIT
HYDRA_T16_MIT=`echo "$HYDRA_T16_ALL $HYDRA_T16_NOMIT" | awk '{print $1-$2}'`

echo "ALL, T=256", $HYDRA_T256_TRACKING, $HYDRA_T256_MIT  >> ${OUT_FILE}
echo "ALL, T=64", $HYDRA_T64_TRACKING, $HYDRA_T64_MIT  >> ${OUT_FILE}
echo "ALL, T=16", $HYDRA_T16_TRACKING, $HYDRA_T16_MIT  >> ${OUT_FILE}

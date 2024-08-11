#!/bin/bash

STAT_DIR="../../experiments/all_figures/"
# STAT_DIR="../../experiments/8C_200Mn_Sim/"

CURR_DIR=`pwd`
OUT_FILE="${CURR_DIR}/data/threshold_sensitivity.csv"

cd ${STAT_DIR}/;

echo "SUITE	Config	Threshold	ideal	start_d" > ${OUT_FILE}

# TRH=16

IDEAL_DIR="8C_ideal_T16/"
START_DIR="8C_2b_T16/"

# IDEAL_DIR="IT.T16/"
# START_DIR="2b.T16/"

IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START=`python get_norm_ipc.py ${START_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL START-D T=16" $IDEAL $START >> ${OUT_FILE}

# TRH=64

IDEAL_DIR="8C_ideal_T64/"
START_DIR="8C_2b_T64/"

# IDEAL_DIR="IT.T64/"
# START_DIR="2b.T64/"

IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START=`python get_norm_ipc.py ${START_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL START-D T=64" $IDEAL $START >> ${OUT_FILE}

# TRH=256

IDEAL_DIR="8C_ideal_T256/"
START_DIR="8C_2b_T256/"

# IDEAL_DIR="IT.T256/"
# START_DIR="2b.T256/"

IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START=`python get_norm_ipc.py ${START_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL START-D T=256" $IDEAL $START >> ${OUT_FILE}

# TRH=1K

IDEAL_DIR="8C_ideal_T1K/"
START_DIR="8C_mm_64GBmem_T1K/"

# IDEAL_DIR="IT.T1K/"
# START_DIR="mm.64GBmem.T1K/"

IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START=`python get_norm_ipc.py ${START_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL START-M T=1K" $IDEAL $START >> ${OUT_FILE}

# TRH=4K

IDEAL_DIR="8C_ideal_T4K/"
START_DIR="8C_mm_64GBmem_T4K/"

# IDEAL_DIR="IT.T4K/"
# START_DIR="mm.64GBmem.T4K/"

IDEAL=`python get_norm_ipc.py ${IDEAL_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`
START=`python get_norm_ipc.py ${START_DIR} | grep GEOMEAN_NORM_IPC | awk '{print $2}'`

echo "ALL START-M T=4K" $IDEAL $START >> ${OUT_FILE}
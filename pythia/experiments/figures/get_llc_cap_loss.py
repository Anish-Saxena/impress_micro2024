import numpy as np
import pandas as pd
import sys

base_dir = "./8C_16WLLC/"

stat_dir = sys.argv[1]

if '512GB' in stat_dir or ('mm' in stat_dir and 'lite' not in stat_dir):
    print("512GB single core stats used\n\n\n\n")
    base_dir = "./8C_16W_512GB/"

bmks = pd.read_csv("./bmk_1C_names.csv", delimiter='\t')

avg_cap_loss = 0.0
bmk_count = 0

for bmk in bmks['workload']:
    bmk_name = bmks.loc[bmks['workload'] == bmk, 'name'].iloc[0]
    bmk_filename = bmk_name.replace('.champsimtrace.xz', '')
    curr_bmk_filename = stat_dir + bmk_filename + \
                    '_4T_base/' + bmk_filename + '_4T_base.out'
    curr_bmk_file = open(curr_bmk_filename, 'r')
    content = curr_bmk_file.readlines()
    avg_sets_state_1 = 0
    avg_sets_state_2 = 0
    avg_sets_state_3 = 0
    for line in content:
        if "LLC_RH_AVG_SETS_IN_STATE_1" in line:
            avg_sets_state_1 = int(line.split()[1])
        if "LLC_RH_AVG_SETS_IN_STATE_2" in line:
            avg_sets_state_2 = int(line.split()[1])
        if "LLC_RH_AVG_SETS_IN_STATE_3" in line:
            avg_sets_state_3 = int(line.split()[1])
    cap_loss = (avg_sets_state_3*8 + (avg_sets_state_2 - avg_sets_state_3)*2 +
                (avg_sets_state_1 - avg_sets_state_2)*1)/(16384*16)
    print(round(cap_loss, 4))
    avg_cap_loss += cap_loss
    bmk_count += 1
    if (bmk == "MIS" or bmk == "xalancbmk" or bmk == "streamc"):
        print("0.0")

avg_cap_loss = avg_cap_loss/bmk_count
print(round(avg_cap_loss, 4))
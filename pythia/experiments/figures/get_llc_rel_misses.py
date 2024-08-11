import numpy as np
import pandas as pd
import sys

base_dir = "./8C_16WLLC/"

stat_dir = sys.argv[1]

if '512GB' in stat_dir or ('mm' in stat_dir and 'lite' not in stat_dir):
    print("512GB single core stats used\n\n\n\n")
    base_dir = "./8C_16W_512GB/"

bmks = pd.read_csv("./bmk_1C_names.csv", delimiter='\t')

avg_rel_misses = 0.0
bmk_count = 0

for bmk in bmks['workload']:
    bmk_name = bmks.loc[bmks['workload'] == bmk, 'name'].iloc[0]
    bmk_filename = bmk_name.replace('.champsimtrace.xz', '')
    base_bmk_filename = base_dir + bmk_filename + \
                    '_4T_base/' + bmk_filename + '_4T_base.out'
    base_bmk_file = open(base_bmk_filename, 'r')
    content = base_bmk_file.readlines()
    base_ipc = 0.0
    for line in content:
        if "LLC_MPKI" in line:
            base_ipc = float(line.split()[1])
            break
    curr_bmk_filename = stat_dir + bmk_filename + \
                    '_4T_base/' + bmk_filename + '_4T_base.out'
    curr_bmk_file = open(curr_bmk_filename, 'r')
    content = curr_bmk_file.readlines()
    curr_ipc = 0.0
    for line in content:
        if "LLC_MPKI" in line:
            curr_ipc = float(line.split()[1])
            break
    rel_misses = curr_ipc/base_ipc
    print(round(rel_misses, 4))
    avg_rel_misses += rel_misses
    bmk_count += 1
    if (bmk == "MIS" or bmk == "xalancbmk" or bmk == "streamc"):
        print("0.0")

avg_rel_misses = avg_rel_misses/bmk_count
print(round(avg_rel_misses, 4))
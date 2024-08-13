import numpy as np
import pandas as pd
import sys

base_dir = "./baseline/"
base_1C_dir = "./1C_baseline/"
SIM_INSTS = 250000000 # 10M Warmup + xM sim

stat_dir = sys.argv[1]
DETAILED_OUTPUT = 0
BMK_NAMES_OUTPUT = 0

if len(sys.argv) > 2:
    if sys.argv[2] == "DETAILED_OUTPUT":
        DETAILED_OUTPUT = 1
    elif sys.argv[2] == "BMK_NAMES_OUTPUT":
        BMK_NAMES_OUTPUT = 1
    if len(sys.argv) > 3:
        base_dir = sys.argv[3]

bmks = pd.read_csv("./bmk_1C_names.csv", delimiter='\t')
mixes = pd.read_csv("./mixes.csv", delimiter='\t')

bmks['base_IPC'] = 0.0
geomean = 1.0 # overall GM
bmk_count = 0
bmk_gm = 1.0 # running GM
high_rbl_gm = 1.0
low_rbl_gm = 1.0
parsec_gm = 1.0
stream_gm = 1.0
other_gm = 1.0

if BMK_NAMES_OUTPUT == 1:
    for bmk in mixes['name']:
        print(bmk)
        if ("scale_triad" in bmk or "xalancbmk" in bmk):
            print("0.0")
    print("SPEC")
    print("STREAM")
    exit()

for bmk in bmks['workload']:
    # print(bmk)
    base_bmk_filename = base_1C_dir + bmk + \
                    '_1T_base/' + bmk + '_1T_base.out'
    base_bmk_file = open(base_bmk_filename, 'r')
    content = base_bmk_file.readlines()
    cores = 0
    for line in content:
        if "SYSTEM_IPC" in line:
            bmks.loc[bmks['workload'] == bmk, 'base_IPC'] = float(line.split()[1])
            break

use_8T = False
for bmk in mixes['mix']:
    # print(bmk)
    bmk_name = mixes.loc[mixes['mix'] == bmk, 'mix'].iloc[0]
    bmk_filename = bmk_name.replace('.champsimtrace.xz', '')
    if bmk == "add":
        use_8T = True
    if bmk == "BFS":
        use_8T = False
    if not use_8T:
        base_bmk_filename = base_dir + bmk_filename + \
                        '_4T_base/' + bmk_filename + '_4T_base.out'
    else:
        base_bmk_filename = base_dir + bmk_filename + \
                        '_8T_base/' + bmk_filename + '_8T_base.out'
    base_bmk_file = open(base_bmk_filename, 'r')
    content = base_bmk_file.readlines()
    base_ws = 0.0
    cores = 0
    for line in content:
        if str("CORE_" + str(cores) + "_SIM_IPC") in line:
            wl_ipc = float(line.split()[1])
            wl_idx = "wl" + str(cores)
            wl_name = mixes.loc[mixes['mix'] == bmk, wl_idx].iloc[0]
            base_ipc  = bmks.loc[bmks['workload'] == wl_name, 'base_IPC'].iloc[0]
            base_ws += (wl_ipc/base_ipc)
            cores += 1
            if cores == 8:
                break
    if not use_8T:
        curr_bmk_filename = stat_dir + bmk_filename + \
                        '_4T_base/' + bmk_filename + '_4T_base.out'
    else:
        curr_bmk_filename = stat_dir + bmk_filename + \
                        '_8T_base/' + bmk_filename + '_8T_base.out'
    curr_bmk_file = open(curr_bmk_filename, 'r')
    content = curr_bmk_file.readlines()
    stat_ws = 0.0
    cores = 0
    for line in content:
        if str("CORE_" + str(cores) + "_SIM_IPC") in line:
            wl_ipc = float(line.split()[1])
            wl_idx = "wl" + str(cores)
            wl_name = mixes.loc[mixes['mix'] == bmk, wl_idx].iloc[0]
            base_ipc  = bmks.loc[bmks['workload'] == wl_name, 'base_IPC'].iloc[0]
            stat_ws += (wl_ipc/base_ipc)
            cores += 1
            if cores == 8:
                break
    geomean *= (stat_ws/base_ws)
    bmk_gm *= (stat_ws/base_ws)
    bmk_count += 1
    if not DETAILED_OUTPUT:
        print(bmk, round((stat_ws/base_ws), 4))
    else:
        print(round((stat_ws/base_ws), 4))
        if ("scale_triad" in bmk or "xalancbmk" in bmk):
            print("0.0")
        if ("scale_triad" in bmk):
            high_rbl_gm = bmk_gm**(1/10)
            bmk_gm = 1.0
        elif ('xalancbmk' in bmk):
            low_rbl_gm = bmk_gm**(1/10)
            bmk_gm = 1.0

geomean = geomean**(1/bmk_count)

if not DETAILED_OUTPUT:
    print("GEOMEAN_NORM_IPC ", round(geomean, 4))
    print("GEOMEAN_SLOWDOWN ", round(1/(geomean) - 1, 4))
else:
    print(round(low_rbl_gm, 4))
    print(round(high_rbl_gm, 4))
    # print(round(geomean, 4))
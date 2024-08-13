import numpy as np
import pandas as pd
import sys

base_dir = "./baseline/"
base_1C_dir = "./1C_baseline/"
SIM_INSTS = 20000000 # 10M Warmup + xM sim

stat_dir = sys.argv[1]
DETAILED_OUTPUT = 0
BMK_NAMES_OUTPUT = 0
use_dramsim_stats = False

if len(sys.argv) > 2:
    if sys.argv[2] == "DETAILED_OUTPUT":
        DETAILED_OUTPUT = 1
    elif sys.argv[2] == "BMK_NAMES_OUTPUT":
        BMK_NAMES_OUTPUT = 1
    if len(sys.argv) > 3:
        base_dir = sys.argv[3]

if "id" in stat_dir or "ip" in stat_dir:
    use_dramsim_stats = True

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

# for bmk in bmks['workload']:
#     # print(bmk)
#     base_bmk_filename = base_1C_dir + bmk + \
#                     '_1T_base/' + bmk + '_1T_base.out'
#     base_bmk_file = open(base_bmk_filename, 'r')
#     content = base_bmk_file.readlines()
#     cores = 0
#     for line in content:
#         if "SYSTEM_IPC" in line:
#             bmks.loc[bmks['workload'] == bmk, 'base_IPC'] = float(line.split()[1])
#             break
print("mix baseACT mitACT extraACT")
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
    baseACT = 0
    cores = 0
    for line in content:
        if "LLC_RH_TOT_NUM_ACT" in line:
            baseACT = int(line.split()[1])
            break
    if not use_8T:
        curr_bmk_filename = stat_dir + bmk_filename + \
                        '_4T_base/' + bmk_filename + '_4T_base.out'
    else:
        curr_bmk_filename = stat_dir + bmk_filename + \
                        '_8T_base/' + bmk_filename + '_8T_base.out'
    curr_bmk_file = open(curr_bmk_filename, 'r')
    content = curr_bmk_file.readlines()
    mixACT = 0
    mixMitACT = 0
    cores = 0
    for line in content:
        if not use_dramsim_stats and "RH_MG_ACTS" in line:
            mixACT = int(line.split()[1])
        if "RH_MG_MITS" in line:
            mixMitACT = 2*int(line.split()[1])
            break
    if use_dramsim_stats:
        if not use_8T:
            curr_bmk_filename = stat_dir + bmk_filename + \
                            '_4T_base/' + "DDR5_baseline.txt"
        else:
            curr_bmk_filename = stat_dir + bmk_filename + \
                            '_8T_base/' + "DDR5_baseline.txt"
        curr_bmk_file = open(curr_bmk_filename, 'r')
        content = curr_bmk_file.readlines()
        channels = 0
        for line in content:
            if "num_act_cmds" in line:
                mixACT += int(line.split()[2])
                channels += 1
            # if "num_rhmit_delay" in line:
            #     mixMitACT += 2*int(line.split()[2])
            if channels == 4:
                break
    extraACT = mixACT - baseACT - mixMitACT
    my_baseACT = baseACT
    if extraACT < 0:
        # print("[WARNING] mixACT < baseACT + mixMitACT. \
        #         extraACT: ", extraACT,
        #         " mitACT: ", mixMitACT)
        my_baseACT = mixACT - mixMitACT
        extraACT = 0
    print(bmk, round(my_baseACT/baseACT, 8), 
                round(mixMitACT/baseACT, 8), 
                round(extraACT/baseACT, 8))

# geomean = geomean**(1/bmk_count)

# if not DETAILED_OUTPUT:
#     print("GEOMEAN_NORM_IPC ", round(geomean, 4))
#     print("GEOMEAN_SLOWDOWN ", round(1/(geomean) - 1, 4))
# else:
#     print(round(low_rbl_gm, 4))
#     print(round(high_rbl_gm, 4))
    # print(round(geomean, 4))
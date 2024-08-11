import numpy as np
import pandas as pd
import sys

base_dir = "./8C_16WLLC/"

stat_dir = sys.argv[1]
DETAILED_OUTPUT = 0
BMK_NAMES_OUTPUT = 0

if len(sys.argv) > 2:
    if sys.argv[2] == "DETAILED_OUTPUT":
        DETAILED_OUTPUT = 1
    elif sys.argv[2] == "BMK_NAMES_OUTPUT":
        BMK_NAMES_OUTPUT = 1

if '512GB' in stat_dir or ('mm' in stat_dir and 'lite' not in stat_dir):
    # print("512GB single core stats used\n\n\n\n")
    base_dir = "./8C_16W_512GB/"
elif '1.5MB' in stat_dir:
    base_dir = "./8C_12W_1.5MB/"
elif '3MB' in stat_dir:
    base_dir = "./8C_12W_3MB/"

bmks = pd.read_csv("./bmk_1C_names.csv", delimiter='\t')

bmks['base_IPC'] = 0.0
geomean = 1.0 # overall GM
bmk_count = 0
bmk_gm = 1.0 # running GM
ligra_gm = 1.0
spec_gm = 1.0
parsec_gm = 1.0

if BMK_NAMES_OUTPUT == 1:
    for bmk in bmks['workload']:
        print(bmk)
        if (bmk == "MIS" or bmk == "xalancbmk" or bmk == "streamc"):
            print("0.0")
    print("LIGRA")
    print("SPEC")
    print("PARSEC")
    print("ALL")
    exit()

for bmk in bmks['workload']:
    bmk_name = bmks.loc[bmks['workload'] == bmk, 'name'].iloc[0]
    bmk_filename = bmk_name.replace('.champsimtrace.xz', '')
    base_bmk_filename = base_dir + bmk_filename + \
                    '_4T_base/' + bmk_filename + '_4T_base.out'
    base_bmk_file = open(base_bmk_filename, 'r')
    content = base_bmk_file.readlines()
    base_ipc = 0.0
    for line in content:
        if "SYSTEM_IPC" in line:
            base_ipc = float(line.split()[1])
            break
    curr_bmk_filename = stat_dir + bmk_filename + \
                    '_4T_base/' + bmk_filename + '_4T_base.out'
    curr_bmk_file = open(curr_bmk_filename, 'r')
    content = curr_bmk_file.readlines()
    curr_ipc = 0.0
    for line in content:
        if "SYSTEM_IPC" in line:
            curr_ipc = float(line.split()[1])
            break
    # print(bmk, round((curr_ipc/base_ipc), 4))
    geomean *= (curr_ipc/base_ipc)
    bmk_gm *= (curr_ipc/base_ipc)
    bmk_count += 1
    if not DETAILED_OUTPUT:
        print(round((curr_ipc/base_ipc), 4))
    else:
        print(round((curr_ipc/base_ipc), 4))
        if (bmk == "MIS" or bmk == "xalancbmk" or bmk == "streamc"):
            print("0.0")
        if (bmk == "MIS"):
            ligra_gm = bmk_gm**(1/13)
            bmk_gm = 1.0
        elif (bmk == 'xalancbmk'):
            spec_gm = bmk_gm**(1/10)
            bmk_gm = 1.0
        elif (bmk == "streamc"):
            parsec_gm = bmk_gm**(1/5)

geomean = geomean**(1/bmk_count)

if not DETAILED_OUTPUT:
    print("GEOMEAN_NORM_IPC ", round(geomean, 4))
    print("GEOMEAN_SLOWDOWN ", round(1/(geomean) - 1, 4))
else:
    print(round(ligra_gm, 4))
    print(round(spec_gm, 4))
    print(round(parsec_gm, 4))
    print(round(geomean, 4))
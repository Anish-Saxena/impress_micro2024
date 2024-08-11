import numpy as np
import pandas as pd
import sys

single_core_bmk_dir = "./1C_16WLLC/"
multi_core_base_dir = "./8C_16WLLC/"

stat_dir = sys.argv[1]
BMK_NAMES_OUTPUT = 0

if len(sys.argv) > 2:
    if sys.argv[2] == "BMK_NAMES_OUTPUT":
        BMK_NAMES_OUTPUT = 1

mixes = pd.read_csv("./workload_mixes.csv", delimiter='\t')

bmks = pd.read_csv("./all_bmk_1C_names.csv", delimiter='\t')

bmks['1C_IPC'] = 0.0
mixes['base_ws'] = 0.0

single_workloads = True

if BMK_NAMES_OUTPUT:
    for bmk in mixes['mixname']:
        if not single_workloads:
            print(bmk)
        if "streamc" in bmk:
            single_workloads = False
        if (bmk == "cloud9" or bmk == "cs_mix5"):
            print("0.0")
    print("LIGRA")
    print("SPEC")
    print("PARSEC")
    print("CLOUD")
    print("MIX-ALL")
    print("ALL-51")
    exit()

# Get 1C IPC
for bmk in bmks['workload']:
    bmk_filename = single_core_bmk_dir + bmk + '_1T_base/' + bmk + '_1T_base.out'
    bmk_file = open(bmk_filename, 'r')
    content = bmk_file.readlines()
    for line in content:
        if "CORE_0_SIM_IPC" in line:
            bmks.loc[bmks['workload'] == bmk, '1C_IPC'] = float(line.split()[1])
            break

single_workloads = True

# Get base ws
for mix in mixes['mixname']:
    if single_workloads:
        mix_filename = multi_core_base_dir + mix + '_4T_base/' + mix + '_4T_base.out'
    else:
        mix_filename = multi_core_base_dir + mix + '_8T_base/' + mix + '_8T_base.out'
    mix_file = open(mix_filename, 'r')
    content = mix_file.readlines()
    core_idx = 0
    ws = 0.0
    for line in content:
        if single_workloads:
            stat_name = "SYSTEM_IPC"
        else:
            stat_name = "CORE_" + str(core_idx) + "_SIM_IPC"
        if stat_name in line:
            bmk_num = "bmk" + str(core_idx)
            bmk_name = mixes.loc[mixes['mixname'] == mix, bmk_num].iloc[0]
            single_core_ipc = bmks.loc[bmks['workload'] == bmk_name, '1C_IPC'].iloc[0]
            curr_ipc = float(line.split()[1])
            ws += curr_ipc/single_core_ipc
            core_idx += 1
            if core_idx == 8:
                break
    mixes.loc[mixes['mixname'] == mix, 'base_ws'] = ws
    if 'streamcluster' in mix:
        single_workloads = False

gm_ligra = 1.0
gm_spec = 1.0
gm_parsec = 1.0
gm_cloud = 1.0
gm_mix_all = 1.0
gm_all = 1.0
bmk_gm = 1.0
bmk_count = 0

print_enable = False
single_workloads = True

# Get norm. ws
for mix in mixes['mixname']:
    if single_workloads:
        mix_filename = stat_dir + mix + '_4T_base/' + mix + '_4T_base.out'
    else:
        mix_filename = stat_dir + mix + '_8T_base/' + mix + '_8T_base.out'
    mix_file = open(mix_filename, 'r')
    content = mix_file.readlines()
    core_idx = 0
    ws = 0.0
    for line in content:
        if single_workloads:
            stat_name = "SYSTEM_IPC"
        else:
            stat_name = "CORE_" + str(core_idx) + "_SIM_IPC"
        if stat_name in line:
            bmk_num = "bmk" + str(core_idx)
            bmk_name = mixes.loc[mixes['mixname'] == mix, bmk_num].iloc[0]
            single_core_ipc = bmks.loc[bmks['workload'] == bmk_name, '1C_IPC'].iloc[0]
            curr_ipc = float(line.split()[1])
            ws += curr_ipc/single_core_ipc
            core_idx += 1
            if core_idx == 8:
                break
    base_ws = mixes.loc[mixes['mixname'] == mix, 'base_ws'].iloc[0]
    bmk_gm *= (ws/base_ws)
    gm_all *= (ws/base_ws)
    bmk_count += 1
    if print_enable or (mix == 'cassandra'):
        print_enable = True
    if print_enable:
        print(round(ws/base_ws, 4))
    if ("MIS" in mix):
        gm_ligra = bmk_gm**(1/13)
        bmk_gm = 1.0
    elif ("xalancbmk" in mix):
        gm_spec = bmk_gm**(1/10)
        bmk_gm = 1.0
    elif ("streamc" in mix):
        gm_parsec = bmk_gm**(1/5)
        bmk_gm = 1.0
    elif (mix == 'cloud9'):
        gm_cloud = bmk_gm**(1/4)
        bmk_gm = 1.0
        print("0.0")
    elif (mix == 'cs_mix5'):
        gm_mix_all = bmk_gm**(1/19)
        bmk_gm = 1.0
        print("0.0")
    if 'streamcluster' in mix:
        single_workloads = False

gm_all = gm_all**(1/51)
print(round(gm_ligra, 4))
print(round(gm_spec, 4))
print(round(gm_parsec, 4))
print(round(gm_cloud, 4))
print(round(gm_mix_all, 4))
print(round(gm_all, 4))
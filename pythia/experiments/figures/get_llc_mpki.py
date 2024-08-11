import numpy as np
import pandas as pd
import sys

stat_dir = sys.argv[1]

mixes = pd.read_csv("./workload_mixes.csv", delimiter='\t')

# print("mix norm_ipc")
for mix in mixes['mixname']:
    mix = mix.replace('.champsimtrace.xz','')
    mix_filename = stat_dir + mix + '_8T_base/' + mix + '_8T_base.out'
    mix_file = open(mix_filename, 'r')
    content = mix_file.readlines()
    roi_found = False
    misses = 0
    evicts = 0
    ctr_misses = 0
    rcc_misses = 0
    for line in content:
        stat_name = "LLC TOTAL"
        if 'Region of Interest' in line:
            roi_found = True
        if stat_name in line and roi_found == True:
            misses += int(line.split()[7])
        if 'LLC_RH_MM_SET_EVICTS' in line:
            evicts += int(line.split()[1])
        if 'LLC_RH_MM_SET_MISSES' in line:
            ctr_misses += int(line.split()[1])
        if 'H_RCC_MISS' in line:
            rcc_misses += int(line.split()[1])
    # print(mix, misses)
    print(rcc_misses)

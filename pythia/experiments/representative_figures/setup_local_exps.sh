#!/bin/bash

while IFS= read -r line
do
    dir=`echo $line | awk '{print $2}'`
    bin=`echo $line | awk '{print $2}'`
    bmks=`echo $line | awk '{print $3}'`
    if [[ "$bin" == "1C_16WLLC" ]]; then
        mkdir -p 1C_16WLLC
        cp ../1C_all_workloads.local.sh 1C_16WLLC/jobfile.sh
        continue
    fi
    echo $dir " -> " $bin
    mkdir -p $dir
    if [[ "$bmks" == "single" ]]; then
        cp ../single_workloads.local.sh $dir/jobfile.sh
    else
        cp ../all_workloads.local.sh $dir/jobfile.sh
    fi
    cd $dir
    sed -i "s/8C_16WLLC/${bin}/g" jobfile.sh
    cd ..
done < "configure.csv"
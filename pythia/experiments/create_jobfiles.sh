#!/bin/bash

while IFS= read -r line
do
    bin=`echo $line | awk '{print $1}'`
    statdir=`echo $line | awk '{print $2}'`
    echo $bin $statdir
    perl ../scripts/create_jobfile.pl --exe \
    /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/impress_rowhammer/champsim/bin/$bin \
    --tlist ART_8C_CS.tlist --exp ART_8C.exp > 8C_200Mn_Sim/cloudsuite/$statdir/jobfile.sh
done  < "bin_statdir.list"
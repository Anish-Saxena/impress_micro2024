#!/bin/bash

curr_dir=`pwd`

while IFS= read -r line
do
    cd ./${line}/
    bin_name=`grep "SBATCH -J" jobfile.sh | awk '{print $3}'`
    sed -i 's/ntasks 57/ntasks 63/g' jobfile.sh
    sed -i '198,220d' jobfile.sh
    sed -i 's/wait/yolo/g' jobfile.sh
    sed -i '/yolo/r  '<(sed -n '1,30p' $curr_dir/stream_2wl_mix.txt) jobfile.sh 
    sed -i 's/yolo//g' jobfile.sh
    sed -i "s/baseline/${bin_name}/g" jobfile.sh
    cd $curr_dir
done < $1


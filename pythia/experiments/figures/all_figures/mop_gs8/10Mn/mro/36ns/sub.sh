#!/bin/bash
bin_name=`grep "SBATCH -J" jobfile.sh | awk '{print $3}'`
sed -i 's/wait/yolo/g' jobfile.sh
sed -i '/yolo/r  '<(sed -n '1,30p' ../../stream_2wl_mix.txt) jobfile.sh 
sed -i 's/yolo//g' jobfile.sh
sed -i "s/baseline/${bin_name}/g" jobfile.sh

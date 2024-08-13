#!/bin/bash

curr_dir=`pwd`

cd ../../../../
root_dir=`pwd`

cd $curr_dir
export IMPRESS_AE_ROOT_DIR=$root_dir
while IFS= read -r line
do
    echo "Launching config " $line
    cd ./${line}/
    rm -rf *base
    sbatch jobfile.sh
    sleep 1
    cd $curr_dir
done < $1


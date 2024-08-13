#!/bin/bash

curr_dir=`pwd`

while IFS= read -r line
do
    echo "Launching config " $line
    cd ./${line}/
    rm -rf *base
    sbatch jobfile.sh
    sleep 1
    cd $curr_dir
done < $1

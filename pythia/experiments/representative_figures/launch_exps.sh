#!/bin/bash

while IFS= read -r line
do
    dir=`echo $line | awk '{print $2}'`
    bin=`echo $line | awk '{print $2}'`
    echo "Launching config " $bin
    cd $dir
    sbatch jobfile.sh
    sleep 2
    cd ..
done < "configure.csv"
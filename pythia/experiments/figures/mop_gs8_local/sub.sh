#!/bin/bash

curr_dir=`pwd`

while IFS= read -r line
do
    echo $line
    python sub.py $line/jobfile.backup $line/jobfile_temp.sh
    mv $line/jobfile_temp.sh $line/jobfile.sh
done < $1


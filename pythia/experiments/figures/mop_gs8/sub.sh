#!/bin/bash

curr_dir=`pwd`

while IFS= read -r line
do
    cd ./${line}/
    sed -i '/ligra/s/^/#/' jobfile.sh
    sed -i 's/#mkdir/mkdir/g' jobfile.sh
    sed -i '/parsec/s/^/#/' jobfile.sh
    sed -i 's/#mkdir/mkdir/g' jobfile.sh
    sed -i 's/ntasks 63/ntasks 26/g' jobfile.sh
    cd $curr_dir
done < $1


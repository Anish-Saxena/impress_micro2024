#!/bin/bash

CHAMPSIM_PATH=$(echo $PWD | sed 's_/_\\/_g')
cd ../dramsim3;
DRAMSIM3_PATH=$(echo $PWD | sed 's_/_\\/_g')
cd ../champsim;

ORIG_PATH="\/storage\/home\/hcoda1\/4\/asaxena317\/p-mqureshi4-0\/impress_rowhammer\/champsim\/dramsim3_configs"

echo "Updating dramsim3 config path in configs/<config> files..."
while IFS= read -r line;
do
    sed -i "s/$ORIG_PATH/$CHAMPSIM_PATH\/dramsim3_configs/g" configs/$line
done < "configs/configs.txt"
echo "Done"

ORIG_PATH="\/storage\/home\/hcoda1\/4\/asaxena317\/p-mqureshi4-0\/impress_rowhammer\/dramsim3"

echo "Updating dramsim3 lib path in config.py"
sed -i "s/$ORIG_PATH/$DRAMSIM3_PATH/g" config.py
echo "Done"
#!/bin/bash

while IFS= read -r config
do
	./config.py configs/$config
	make -j32
	echo
	echo built $config
	sleep 1
	echo
done < $1

#!/bin/bash


while IFS= read -r config
do
	echo ${config}
	cp 4C_${config} 8C_${config}
	sed -i 's/4C_/8C_/g' 8C_${config}
	sed -i 's/"num_cores": 4/"num_cores": 8/g' 8C_${config}
	sed -i 's/"sets": 8192/"sets": 16384/g' 8C_${config}
	sed -i 's/"rq_size": 128/"rq_size": 256/g' 8C_${config}
	sed -i 's/"wq_size": 128/"wq_size": 256/g' 8C_${config}
	sed -i 's/"pq_size": 128/"pq_size": 256/g' 8C_${config}
	sed -i 's/"mshr_size": 512/"mshr_size": 1024/g' 8C_${config}
	sed -i 's/"latency": 20/"latency": 30/g' 8C_${config}
	sed -i 's/2ch_4800.ini/4ch_4800.ini/g' 8C_${config}
	sed -i 's/"channels": 2/"channels": 4/g' 8C_${config}
	sed -i 's/34359738368/68719476736/g' 8C_${config}
done < configs.txt

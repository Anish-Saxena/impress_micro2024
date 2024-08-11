#!/bin/bash

#SBATCH -A gts-mqureshi4

#SBATCH -J pythia_test

#SBATCH --cpus-per-task 1

#SBATCH --ntasks 20

#SBATCH --mem-per-cpu=4G

#SBATCH -t 0-6:00:00

#SBATCH -o /storage/home/hcoda1/4/asaxena317/scratch/cxl/pythia/results/%j.out

source ~/.bashrc

source /storage/home/hcoda1/4/asaxena317/p-mqureshi4-0/hybrid_cxl_memsys/Pythia/setvars.sh

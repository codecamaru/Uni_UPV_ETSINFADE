#!/bin/bash
#SBATCH --nodes=1
#SBATCH --time=5:00
#SBATCH --partition=cpa
./imagenes
OMP_NUM_THREADS=2 ./pimagenes1
OMP_NUM_THREADS=4 ./pimagenes1
OMP_NUM_THREADS=8 ./pimagenes1
OMP_NUM_THREADS=16 ./pimagenes1
OMP_NUM_THREADS=32 ./pimagenes1
OMP_NUM_THREADS=64 ./pimagenes1

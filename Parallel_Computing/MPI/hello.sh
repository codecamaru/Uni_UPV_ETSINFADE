#!/bin/sh
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --time=5:00
#SBATCH --partition=cpa
scontrol show hostnames $SLURM_JOB_NODELIST

mpiexec ./hello
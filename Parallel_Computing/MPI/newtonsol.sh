#!/bin/sh
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --time=5:00
#SBATCH --partition=cpa
scontrol show hostnames $SLURM_JOB_NODELIST

mpiexec ./newtonsol -c1 -onewton1
mpiexec ./newtonsol -c2 -onewton2
mpiexec ./newtonsol -c3 -onewton3
mpiexec ./newtonsol -c4 -onewton4
mpiexec ./newtonsol -c5 -onewton5
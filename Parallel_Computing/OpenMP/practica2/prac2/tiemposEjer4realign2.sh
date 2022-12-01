#!/bin/sh
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#SBATCH -o realign2.txt
echo "Código paralelo con planificación estática y chunk=0 (reparto por bloques)"
OMP_SCHEDULE=static,0 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=1 (reparto cíclico de 1 en 1)"
OMP_SCHEDULE=static,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación dinámica y chunk=1"
OMP_SCHEDULE=dynamic,1 ./realign2 large.ppm realign2large.ppm

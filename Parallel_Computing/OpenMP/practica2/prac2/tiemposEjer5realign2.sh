#!/bin/sh
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#SBATCH -o realign2.txt
echo "Código paralelo con planificación estática y chunk=0 (reparto por bloques) y 2 hilos"
OMP_NUM_THREADS=2 OMP_SCHEDULE=static,0 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=1 (reparto cíclico de 1 en 1) y 2 hilos"
OMP_NUM_THREADS=2 OMP_SCHEDULE=static,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación dinámica y chunk=1 y 2 hilos"
OMP_NUM_THREADS=2 OMP_SCHEDULE=dynamic,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=0 (reparto por bloques) y 4 hilos"
OMP_NUM_THREADS=4 OMP_SCHEDULE=static,0 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=1 (reparto cíclico de 1 en 1) y 4 hilos"
OMP_NUM_THREADS=4 OMP_SCHEDULE=static,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación dinámica y chunk=1 y 4 hilos"
OMP_NUM_THREADS=4 OMP_SCHEDULE=dynamic,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=0 (reparto por bloques) y 8 hilos"
OMP_NUM_THREADS=8 OMP_SCHEDULE=static,0 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=1 (reparto cíclico de 1 en 1) y 8 hilos"
OMP_NUM_THREADS=8 OMP_SCHEDULE=static,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación dinámica y chunk=1 y 8 hilos"
OMP_NUM_THREADS=8 OMP_SCHEDULE=dynamic,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=0 (reparto por bloques) y 16 hilos"
OMP_NUM_THREADS=16 OMP_SCHEDULE=static,0 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=1 (reparto cíclico de 1 en 1) y 16 hilos"
OMP_NUM_THREADS=16 OMP_SCHEDULE=static,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación dinámica y chunk=1 y 16 hilos"
OMP_NUM_THREADS=16 OMP_SCHEDULE=dynamic,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=0 (reparto por bloques) y 32 hilos"
OMP_NUM_THREADS=32 OMP_SCHEDULE=static,0 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación estática y chunk=1 (reparto cíclico de 1 en 1) y 32 hilos"
OMP_NUM_THREADS=32 OMP_SCHEDULE=static,1 ./realign2 large.ppm realign2large.ppm
echo "Código paralelo con planificación dinámica y chunk=1 y 32 hilos"
OMP_NUM_THREADS=32 OMP_SCHEDULE=dynamic,1 ./realign2 large.ppm realign2large.ppm
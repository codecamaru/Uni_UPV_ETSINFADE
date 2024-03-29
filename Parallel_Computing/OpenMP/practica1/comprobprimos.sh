#!/bin/sh
#PBS -l nodes=1,walltime=00:10:00
#PBS -q cpa
#PBS -o primos.txt
echo "Código paralelo con planificación estática y chunk=0 (reparto por bloques)"
OMP_SCHEDULE=static,0 ./primo_numeros
echo "Código paralelo con planificación estática y chunk=1 (reparto cíclico de 1 en 1)"
OMP_SCHEDULE=static,1 ./primo_numeros
echo "Código paralelo con planificación estática y chunk=2 (reparto cíclico de 2 en 2)"
OMP_SCHEDULE=static,1 ./primo_numeros
echo "Código paralelo con planificación dinámica y chunk=1"
OMP_SCHEDULE=dynamic,1 ./primo_numeros
echo "Código paralelo con planificación dinámica y chunk=2"
OMP_SCHEDULE=dynamic,2 ./primo_numeros

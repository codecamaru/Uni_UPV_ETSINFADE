#include <stdio.h>
#include <mpi.h>

int main (int argc, char *argv[]) {
    int id; // id del proceso de cada comunicador
    int p; // numero de procesos en cada comunicador
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &id);
    MPI_Comm_size(MPI_COMM_WORLD, &p);
    printf("Hello, soy el proceso %d y somos %d procesos en este comunicador\n", id,p);
    MPI_Finalize();
    return 0;
}
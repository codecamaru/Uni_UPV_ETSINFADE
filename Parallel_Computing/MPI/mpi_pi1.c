#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc,char *argv[])
{
  int    n, myid, numprocs, i;
  double mypi, pi, h, sum, x;

  MPI_Init(&argc,&argv);
  MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
  MPI_Comm_rank(MPI_COMM_WORLD,&myid); // myID ID PROCESO

  if (argc==2) n = atoi(argv[1]);
  else n = 100;
  if (n<=0) MPI_Abort(MPI_COMM_WORLD,MPI_ERR_ARG);

  /* Cálculo de PI. Cada proceso acumula la suma parcial de un subintervalo */
  
  h   = 1.0 / (double) n;
  sum = 0.0;
  for (i = myid + 1; i <= n; i += numprocs) {
    x = h * ((double)i - 0.5);
    sum += (4.0 / (1.0 + x*x));
  }
  mypi = h * sum; // myPI RESULTADO DE CADA PROCESO
  
  
  /* Reducción: el proceso 0 obtiene la suma de todos los resultados */
  if(myid == 0){ 
  	pi = mypi;
  	for(i = 1; i < numprocs; i++){
  	     MPI_Recv(&mypi, 1, MPI_DOUBLE, MPI_ANY_SOURCE, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
  	     pi += mypi;
  	}
  }
  else{
  	MPI_Send(&mypi, 1, MPI_DOUBLE, 0, 100, MPI_COMM_WORLD); // para el envío la tag no puede ser cualquiera
  }
  

  if (myid==0) {
    printf("Cálculo de PI con %d procesos\n",numprocs);
    printf("Con %d intervalos, PI es aproximadamente %.16f (error = %.16f)\n",n,pi,fabs(pi-M_PI));
  }

  MPI_Finalize();
  return 0;
}


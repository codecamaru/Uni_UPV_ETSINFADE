/* Ping-pong program */

#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

#define NMAX 1000000
#define NREPS 100

char buf[NMAX];

int main(int argc,char *argv[])
{
  int n, myid, numprocs, i;
  double g, g2; // current time

  MPI_Init(&argc,&argv);
  MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
  MPI_Comm_rank(MPI_COMM_WORLD,&myid);

  /* The program takes 1 argument: message size (n), with a default size of 100
     bytes and a maximum size of NMAX bytes*/
  if (argc==2) n = atoi(argv[1]);
  else n = 100;
  if (n<0 || n>NMAX) n=NMAX;

  /* COMPLETE: Get current time, using MPI_Wtime() */
   g = MPI_Wtime();

  /* COMPLETE: loop of NREPS iterations.
     In each iteration, P0 sends a message of n bytes to P1, and P1 sends the same
     message back to P0. The data sent is taken from array buf and received into
     the same array. */
   for(i = 0; i < NREPS; i++){
      if (myid == 0){
         MPI_Send(buf, n, MPI_BYTE, 1, 100, MPI_COMM_WORLD);
         MPI_Recv(buf, n, MPI_BYTE, 1, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      }
      else if (myid == 1){
         MPI_Recv(buf, n, MPI_BYTE, 0, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
         MPI_Send(buf, n, MPI_BYTE, 0, 100, MPI_COMM_WORLD);
      }
   }


  /* COMPLETE: Get current time, using MPI_Wtime() */
   g = MPI_Wtime() - g;

  /* COMPLETE: Only in process 0.
     Compute the time of transmission of a single message (in milliseconds) and print it.
     Take into account there have been NREPS repetitions, and each repetition involves 2
     messages. */
   if (myid==0) {
      g2 = g / NREPS; 
      g = g / (NREPS*2); // average time per message
      printf("tiempo medio transcurrido desde la operación de envío hasta que termina la recepción de la respuesta: %d\n",g2);
      printf("average time per message: %d\n",g);
   }
   

  MPI_Finalize();
  return 0;
}

/*
   Ejercicio 5: ¿Por qué se envían dos mensajes en cada iteración del bucle? ¿se podría eliminar el mensaje
   de respuesta de P1 a P0?
   Porque si no me envía una respuesta no tengo forma de saber cuánto tarda en llegar o volver el mensaje, no 
   podría iniciar un contador en el proceso que recibe una vez ha recibido el mensaje sin que haya una respuesta, 
   algo con lo que pueda comparar. Debe haber un cronómetro y una respuesta. 

   Ejercicio 6: En cada iteración, el proceso P0 tiene que hacer un envío y una recepción. ¿Podría utilizar
   para ello la función MPI_Sendrecv_replace? ¿Y el proceso P1?
   Pienso que P0 sí porque primero envía , pero P1 no porque tiene que recibir primero lo que inicialmente le manda P0,
   si directamente hace sendrec pienso que le está mandando lo que ya tenía P1 en lugar de esperarse a tener lo que le 
   mande P0. 
*/


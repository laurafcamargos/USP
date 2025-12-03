// para compilar: mpicc 04-tokenring-mpi-omp.c -o 04-tokenring-mpi-omp -fopenmp
// para rodar: mpirun -np <num_de_processos_desejado> 04-tokenring-mpi-omp

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <omp.h>

int  main(int argc, char *argv[])	{
	int npes, myrank, src, dest;
	int nthreads;
	int token, nekot;
	int count  = 1;
	int msgtag = 4;

	MPI_Status status;

	if (argc != 2) {
	  printf("Nr errado de argumentos. Você deve fornecer o nr de threads a criar por processo C/MPI. \n");
	  return(-1);
	}
	  
	nthreads = atoi(argv[1]);
	if (nthreads < 2) {
	  printf("Numero errado de threads. Deve ser maior ou igual a 2. \n");
	  return(-1);
	}
	
	printf("nthreads = %d \n", nthreads);
	fflush(0);
	
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &npes);
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank);

	//printf("Tecle algo para continuar... \n");
	//getchar();

	printf("myrank = %d  total of processes = %d nthreads = %d \n", myrank, npes, nthreads);
	fflush(0);
	
	//---------------------------------------------------------
	MPI_Barrier(MPI_COMM_WORLD);
	//---------------------------------------------------------

	dest = (myrank + 1) % npes;
	src   = (myrank - 1 + npes) % npes;

	if (myrank == 0) 
	{
		token = myrank;

        printf("Initial value: %d. Press any key to continue.\n", token);
		getchar();

        // blocking send
		MPI_Send(&token, count, MPI_INT, dest, msgtag, MPI_COMM_WORLD);
		// blocking receive
		MPI_Recv(&nekot, count, MPI_INT, src, msgtag, MPI_COMM_WORLD, &status);
		printf("Computing done. Final value: %d. \n", nekot);
	}
	else 
	{
		// blocking receive
		MPI_Recv(&nekot, count, MPI_INT, src, msgtag, MPI_COMM_WORLD, &status);
		#pragma omp parallel num_threads(nthreads) shared(nekot)
		{
			#pragma omp critical (incrementa)
			{
				nekot++;
			}
		}
		// blocking send
		MPI_Send(&nekot, count, MPI_INT, dest, msgtag, MPI_COMM_WORLD);
	}

	MPI_Finalize();
	
	return(0);

}

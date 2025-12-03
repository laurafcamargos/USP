// compilação: mpicc hello.c -o hello -Wall
// para rodar
// mpirun -np 2 hello (supondo 4 cores)
// mpirun --oversubscribe -np 2 hello (com sobreposição)
// mpirun -np 2 --hostfile hosts hello (segue o hostfile e deve obedecer limitações
// mpirun -np 2 --host hostname:slots hello (segue -host e segue limitações. slots é opcional)

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mpi.h"

#define MESSAGE "Hello World running!"

int main(int argc, char *argv[]) {
	int npes, myrank, src, dest, msgtag, ret;
	char *bufrecv, *bufsend;
	
	MPI_Status status;
	MPI_Init(&argc, &argv); // inicializando o mpi
	MPI_Comm_size(MPI_COMM_WORLD, &npes); // pegando o número número de processos/nós 
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank); // pegando o rank

	bufrecv = (char *) malloc(strlen(MESSAGE) + 1);
	msgtag = 1;
	// Identficiando o processo 0
	if (myrank == 0) {
		src = dest = 1;
		MPI_Send(MESSAGE, strlen(MESSAGE)+1, MPI_CHAR, dest, msgtag, MPI_COMM_WORLD);
		msgtag = 2;
		MPI_Recv(bufrecv, strlen(MESSAGE)+1, MPI_CHAR, src, msgtag, MPI_COMM_WORLD, &status);
		printf("Received messagem from slave: %s with %d char\n", bufrecv, (int)strlen(bufrecv));
	}

	// Identificando o processo 1
	else {
		bufsend = (char *)malloc(strlen(MESSAGE)+1);
		src = dest = 0;
		MPI_Recv(bufrecv, strlen(MESSAGE)+1, MPI_CHAR, src, msgtag, MPI_COMM_WORLD, &status);
		msgtag = 2;
		strcpy(bufsend, bufrecv);
		MPI_Send(bufsend, strlen(MESSAGE)+1, MPI_CHAR, dest, msgtag, MPI_COMM_WORLD);
		free(bufsend);
	}
	free(bufrecv);
	fflush(0);
	ret = MPI_Finalize();
	if (ret == MPI_SUCCESS) 
		printf("MPI_Finalize success! \n");

	return 0;
}
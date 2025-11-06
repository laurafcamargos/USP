#include <mpi.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int rank, size;
    int tkn;
    int tag = 0;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (size != 4) {
        if (rank == 0)
            printf("Este programa requer exatamente 4 processos!\n");
        MPI_Finalize();
        return 0;
    }
    printf("RANK: %d\n",rank);

    int prev = (rank - 1 + size) % size; // processo anterior
    int next = (rank + 1) % size;        // próximo processo
    printf("prev: %d\n",prev);
    printf("next: %d\n",next);

    if (rank == 0) {
        tkn = 0; // valor inicial do tkn

        MPI_Send(&tkn, 1, MPI_INT, next, tag, MPI_COMM_WORLD);
        MPI_Recv(&tkn, 1, MPI_INT, prev, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        printf("processo %d: tkn recebido = %d\n", rank, tkn);
        tkn++;
    }
    else{
        MPI_Recv(&tkn, 1, MPI_INT, prev, tag, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
        printf("processo %d: tkn recebido = %d\n", rank, tkn);
        tkn++;
        MPI_Send(&tkn, 1, MPI_INT, next, tag, MPI_COMM_WORLD);
    }

    MPI_Finalize();
    return 0;
}

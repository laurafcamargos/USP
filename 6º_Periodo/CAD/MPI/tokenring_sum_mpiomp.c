#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mpi.h>
#include <omp.h>

#define MENSAGEM "Uma mensagem qualquer passada circularmente"

#define MSG_INICIAL 0

int main(int argc, char *argv[]) {

    int total_processos, meu_rank, origem, destino, tag_mensagem = 1;

    int buffer_recebimento, buffer_envio;

    MPI_Status status_mpi;
    
    // criando thread
    int provided;
    MPI_Init_thread(&argc, &argv, MPI_THREAD_SINGLE, &provided);

    // Inicialização do MPI:
    // MPI_Init(&argc, &argv);

    // Contagem do número de processos:
    MPI_Comm_size(MPI_COMM_WORLD, &total_processos);

    // Obtensão da "classificação" entre os processos:
    MPI_Comm_rank(MPI_COMM_WORLD, &meu_rank);


    // Envio / Recebimento de mensagens:
    if (meu_rank == 0) {
        origem = total_processos - 1;
        destino = 1;
        buffer_envio = MSG_INICIAL;
        printf("P0: Enviando mensagem para P%d\n", destino);
        MPI_Send(&buffer_envio, 1, MPI_INT, destino, tag_mensagem, MPI_COMM_WORLD);
        printf("P0: Aguardando mensagem de P%d\n", origem);
        MPI_Recv(&buffer_recebimento, 1, MPI_INT, origem, tag_mensagem, MPI_COMM_WORLD, &status_mpi);
        printf("P0: Recebeu \"%d\" de P%d\n", buffer_recebimento, origem);
    } else {
        origem = meu_rank - 1;
        destino = meu_rank == total_processos - 1 ? 0 : meu_rank + 1;
        printf("P%d: Aguardando mensagem de P%d\n", meu_rank, origem);
        MPI_Recv(&buffer_recebimento, 1, MPI_INT, origem, tag_mensagem, MPI_COMM_WORLD, &status_mpi); 
        printf("P%d: Recebeu \"%d\" de P%d\n", meu_rank, buffer_recebimento, origem);
        buffer_envio = buffer_recebimento;
        printf("P%d: Enviando mensagem para P%d\n", meu_rank, destino);

        #pragma omp parallel reduction(+ : buffer_envio) num_threads(4)
        {   
            int thread = omp_get_thread_num();
            buffer_envio += 1;
            printf("Thread %d adicionando mais 1: %d\n", thread, buffer_envio);
        }

        MPI_Send(&buffer_envio, 1, MPI_INT, destino, tag_mensagem, MPI_COMM_WORLD);
    }

    if (MPI_Finalize() == MPI_SUCCESS)
        printf("Execução terminada com sucesso!\n");

    return 0;
}

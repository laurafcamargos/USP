#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <mpi.h>

int main(int argc,char **argv) {
    //Declara a matriz MAT e o vetor vet_menor
    int *MAT, *vet_menor;
    int dim; 
    //Declara a media para MAT
    int media_MAT;
    int my_rank, num_procs;    

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &num_procs);

    if (argc < 2) {
        printf("Nr errado de argumentos. Execute passando <arq_entrada> como argumento. \n");
        MPI_Finalize();
        exit(-1);
    }
    if (my_rank == 0) {
        FILE *inputfile;      // handler para o arquivo de entrada
        char *inputfilename;  // nome do arquivo de entrada
        inputfilename = (char*) malloc (256*sizeof(char));
        strcpy(inputfilename,argv[1]);

        /*    
            // para depuracao apenas
            printf("inputfilename=%s\n", inputfilename);
            fflush(0);
        */

        if ((inputfile=fopen(inputfilename,"r")) == 0) {
            printf("Mestre: Erro ao abrir arquivo de entrada %s. Saindo. \n", inputfilename);
            exit(-1);
        }
        
        fscanf(inputfile, "%d\n", &dim); //Lê a dimensão de MAT
        /*    
            // para depuracao apenas
            printf("dim=%d\n", dim);
            fflush(0);
        */
        //Aloca a matriz
        MAT = (int *)malloc(dim * dim * sizeof(int));
        //Aloca um vetor para armazenar a quantide de nrs menores que a media por coluna
        vet_menor = (int *)malloc(dim * sizeof(int));

        //Lê a matriz MAT
        for(int i=0;i<dim;i++) {
            for(int j=0;j<dim;j++) {
                fscanf(inputfile, "%d ", &(MAT[i*dim+j]));
                // printf("%d ", MAT[i*dim+j]);
            }
            // printf("\n");
        }
        
        // fecha o arquivo de entrada
        fclose(inputfile);
    }

    MPI_Bcast(&dim, 1, MPI_INT, 0, MPI_COMM_WORLD);

    if (my_rank != 0) {
        //Aloca a matriz
        MAT = (int *)malloc(dim * dim * sizeof(int));
    }
    MPI_Bcast(MAT, dim * dim, MPI_INT, 0, MPI_COMM_WORLD);
    
    int remaining  = (dim % num_procs);
    int chunk_size = dim / num_procs;
    int shift = 0;
    if (my_rank < remaining)
        chunk_size += 1;
    else
        shift = remaining;
    
    int column_start = my_rank * (chunk_size) + shift;
    int column_end   = (my_rank + 1) * (chunk_size) + shift;
    // printf("[%d] %d %d cs: %d\n", my_rank, column_start, column_end-1, chunk_size);
    int sum = 0;
    for (int i = column_start; i < column_end; i++) {
        for (int line = 0; line < dim; line++) {
            sum += MAT[line * dim + i];
        }
    }
    MPI_Reduce(&sum, &media_MAT, 1, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
    
    media_MAT = media_MAT /(dim * dim);
	
    MPI_Bcast(&media_MAT, 1, MPI_INT, 0, MPI_COMM_WORLD);

    // printf("mean: %d\n", media_MAT);
    int *menores = (int *) calloc(chunk_size, sizeof(int));
    for (int i = column_start, k = 0; i < column_end; i++, k++) {
        for (int j = 0; j < dim; j++) {
            // printf("MAT[%d][%d]: %d\n", j,i,MAT[j * dim + i]);
            if (MAT[j * dim + i] < media_MAT)
                menores[k] += 1;
        }
        // printf("[pe %d] [%d] %d\n",my_rank, i, menores[k]);
    }
    
    // for(int i = 0; i < chunk_size; i++){
    //     printf("%d ", menores[i]);
    // }
    // printf("[%d]\n", my_rank);

    if (my_rank == 0) {
        menores = (int*)realloc(menores, dim * sizeof(int));
        // for(int i = 0; i < dim; i++) printf("%d ", menores[i]);
        // printf("\n");
        for (int i = 1; i < num_procs; i++) {
            int m_size = 0;
            MPI_Recv(&m_size, 1, MPI_INT, i, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            int *m_proc = (int *)malloc(m_size * sizeof(int));
            MPI_Recv(m_proc, m_size, MPI_INT, i, MPI_ANY_TAG, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            
            // printf("Processo: %d responsável pelas colunas %d-%d\n", i, column_end, column_end + m_size);
            for (int i = column_end, k = 0; i < column_end + m_size; i++, k++) {
                menores[i] = m_proc[k];
            }
            free(m_proc);
            column_end += m_size;
        }

        for(int i = 0; i < column_end; i++) {
            printf("coluna %d: %d\n", i, menores[i]);
        }

    } else {
        MPI_Send(&chunk_size, 1, MPI_INT, 0, 1, MPI_COMM_WORLD);
        MPI_Send(menores, chunk_size, MPI_INT, 0, 1, MPI_COMM_WORLD);
    }

    //Libera MAT[] e vet_menor[]
    free(MAT);
    free(vet_menor);

    MPI_Finalize();
	
	return(0);
}
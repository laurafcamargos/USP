#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <math.h>

#define N 5
#define T 2
// Esse código foi feito para rodar com T = N

int main(){
    int A[N][N];
    omp_set_num_threads(T);

    // Leitura da matriz
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            scanf("%d", &A[i][j]);
        }
    }

    // Soma das colunas
    int soma_colunas[N];
    #pragma omp parallel
    {
        int j = omp_get_thread_num();
        soma_colunas[j] = 0;
        for(int i = 0; i < N; i++)
            soma_colunas[j] += A[i][j];
    }

    // Média da matriz
    double media = 0;
    #pragma omp parallel for reduction(+:media)
    for(int i = 0; i < N; i++)
        media += soma_colunas[i];
    media = media / (N*N);

    // Vetores auxiliares
    int medial[N], soma_diferenca[N];
    double dsvpdr[N];

    // Criação de tasks
    #pragma omp parallel shared(A, soma_colunas, medial, soma_diferenca, dsvpdr, media)
    {
        #pragma omp single
        {
            for(int j = 0; j < N; j++){
                // Task medial
                #pragma omp task firstprivate(j)
                {
                    medial[j] = 0;
                    for(int i = 0; i < N; i++)
                        if (A[i][j] < media) 
                            medial[j] += 1;
                }
                // Task dsvpdr
                #pragma omp task firstprivate(j)
                {
                    soma_diferenca[j] = 0;
                    for(int i = 0; i < N; i++)
                        soma_diferenca[j] += pow(A[i][j] - soma_colunas[j], 2);
                    dsvpdr[j] = sqrt(soma_diferenca[j] / (double)N);
                }
            }
            #pragma omp taskwait
        }
    }

    // Impressão dos resultados
    for(int i = 0; i < N; i++)
        printf("(%d) dsvpdr = %f; medial = %d\n", i, dsvpdr[i], medial[i]);

    return 0;
}

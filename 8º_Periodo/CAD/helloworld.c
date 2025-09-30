#include <stdio.h>
#include <omp.h>

#define T 16

int main() {
    int thread_num, nthreads, soma = 0;

    // A thread mestra sempre tem ID 0 e, por padrao, o numero de threads é 1
    thread_num = omp_get_thread_num();
    nthreads = omp_get_num_threads();
    printf("Hello-world da thread mestre (regiao seq): %d. Num_threads=%d\n", thread_num, nthreads);

    // ---
    
    #pragma omp parallel private (thread_num, nthreads) num_threads(T) reduction(+: soma) 
    {
        // Esta regiao sera executada por T threads
        thread_num = omp_get_thread_num();
        nthreads = omp_get_num_threads();

        // Para demonstrar a reducao, cada thread adiciona seu proprio ID a uma copia local de 'soma'
        soma += thread_num;
        
        printf("Hello World %d na regiao paralela, num threads aqui: %d\n", thread_num, nthreads);
    }
    
    // ---

    // Após a regiao paralela, a thread mestra continua. 'soma' contem o valor final da reducao.
    thread_num = omp_get_thread_num();
    nthreads = omp_get_num_threads();
    printf("\nRegiao sequencial final: thread_num = %d e soma = %d\n", thread_num, soma);

    return 0;
}
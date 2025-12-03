#include <stdlib.h>
#include <stdio.h>
#include <math.h>

// Número de elementos no vetor
#define N   10000   

// Threads por bloco (TPB = Threads Per Block)
#define TPB 128    

// ----------------------------------------------------------
// KERNEL CUDA: executado na GPU
// ----------------------------------------------------------
__global__ void add( int *a, int *b, int *c ) {

    /*
     threadIdx.x → ID da thread dentro do bloco
     blockIdx.x  → ID do bloco dentro do grid
     blockDim.x  → número de threads por bloco
     gridDim.x   → número total de blocos no grid (não usado aqui)

     Cada thread deve calcular seu índice global (tid):
     tid = thread local + deslocamento do bloco
    */
	 
    int tid = threadIdx.x + blockIdx.x * blockDim.x;

    // Só processa se o índice for válido (evita acessar posição inexistente)
    if(tid < N){
        c[tid] = a[tid] + b[tid];
    }
    /*bloco 0, thread 0 → tid = 0
    bloco 0, thread 1 → tid = 1
    bloco 1, thread 0 → tid = 128
    bloco 1, thread 1 → tid = 129*/
}

// ----------------------------------------------------------
// Função principal: roda na CPU
// ----------------------------------------------------------
int main(void) {

    // Vetores na memória da CPU (host)
    int a[N], b[N], c[N];

    // Ponteiros para memória da GPU (device)
    int *dev_a, *dev_b, *dev_c;

    // ------------------------------------------------------
    // Aloca memória na GPU para vetores A, B e C
    // ------------------------------------------------------
    cudaMalloc((void**)&dev_a, N * sizeof(int));
    cudaMalloc((void**)&dev_b, N * sizeof(int));
    cudaMalloc((void**)&dev_c, N * sizeof(int));

    // ------------------------------------------------------
    // Preenche vetores A e B na CPU
    // ------------------------------------------------------
    for (int i = 0; i < N; i++) {
        a[i] = -i;
        b[i] = i * i;
    }

    // ------------------------------------------------------
    // Copia vetores A e B da CPU → GPU
    // ------------------------------------------------------
    cudaMemcpy(dev_a, a, N * sizeof(int), cudaMemcpyHostToDevice);
    cudaMemcpy(dev_b, b, N * sizeof(int), cudaMemcpyHostToDevice);

    // Número de blocos necessários:
    // fórmula padrão:  blocks = ceil(N / TPB) - quantos blocos são necessários para cobrir todas as posições do vetor,
    //arredondando pra cima
    printf("N=%d, TPB=%d, Nr Blocos=%d \n", 
        N, TPB, (N + TPB - 1) / TPB);

    // ------------------------------------------------------
    // Lançamento do kernel CUDA na GPU
    //  - grid:  (N+TPB-1)/TPB blocos
    //  - bloco: TPB threads por bloco
    // ------------------------------------------------------
    add<<< ( (N + TPB - 1) / TPB ), TPB >>>(dev_a, dev_b, dev_c);

    // ------------------------------------------------------
    // Copia resultado C da GPU → CPU
    // ------------------------------------------------------
    cudaMemcpy(c, dev_c, N * sizeof(int), cudaMemcpyDeviceToHost);

    // ------------------------------------------------------
    // Imprime alguns resultados (1 em cada 1000)
    // ------------------------------------------------------
    for (int i = 0; i < N; i++) {
        if (i % 1000 == 0)
            printf("%d + %d = %d\n", a[i], b[i], c[i]);
    }

    // ------------------------------------------------------
    // Libera memória da GPU
    // ------------------------------------------------------
    cudaFree(dev_a);
    cudaFree(dev_b);
    cudaFree(dev_c);

    return 0;
}

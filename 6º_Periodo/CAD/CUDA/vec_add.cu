#include <stdio.h>
#include <cuda.h>

// --------------------------------------
// Kernel CUDA: soma elemento a elemento
// --------------------------------------
__global__ void vec_add_kernel(float *a, float *b, float *c, int n) {
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < n) {
        c[i] = a[i] + b[i];
    }
}

// --------------------------------------
// Função CUDA que prepara e chama o kernel
// --------------------------------------
void vec_add(float *a, float *b, float *c, int n) {
    int size = n * sizeof(float);
    float *a_dev, *b_dev, *c_dev;

    // ---------------------------
    // 1) Aloca memória no device
    // ---------------------------
    cudaMalloc((void**) &a_dev, size);
    cudaMalloc((void**) &b_dev, size);
    cudaMalloc((void**) &c_dev, size);

    // Copia a e b do host para o device
    cudaMemcpy(a_dev, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(b_dev, b, size, cudaMemcpyHostToDevice);

    // ---------------------------
    // 2) Execução do kernel
    // ---------------------------
    int threadsPerBlock = 256;
    int blocksPerGrid = (n + threadsPerBlock - 1) / threadsPerBlock;

    vec_add_kernel<<<blocksPerGrid, threadsPerBlock>>>(a_dev, b_dev, c_dev, n);

    cudaDeviceSynchronize();

    // ---------------------------
    // 3) Copia resultado do device para o host
    // ---------------------------
    cudaMemcpy(c, c_dev, size, cudaMemcpyDeviceToHost);

    // ---------------------------
    // Libera a memória no device
    // ---------------------------
    cudaFree(a_dev);
    cudaFree(b_dev);
    cudaFree(c_dev);
}

#include <stdio.h>
#include <cuda.h>

%__global__ 
void helloFromGPU (int n)
{
	int blockIdx.x=0, threadIdx.x=0;
	
	printf("Hello from GPU with grid %d, block %d, and thread %d\n", n, blockIdx.x, threadIdx.x);
	//printf("From:%d, %d ", n, blockIdx.x);
}

void Helder_cudaDeviceSynchronize()
{
???	
}


int main (void)
{
	helloFromGPU(1); //<<<1,10>>>(1);

	Helder_cudaDeviceSynchronize();

	helloFromGPU(2); //<<<10,1>>>(2);

	Helder_cudaDeviceSynchronize();

	printf("Hello CPU\n");

	return 0;
}

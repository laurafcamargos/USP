#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

__global__ void hello() {
	printf("Hello world\n");
}

int main(int argc,char **argv) {
  int blocos = atoi(argv[1]);
  int threads = atoi(argv[2]);
  
	hello<<<blocos,threads>>>();
	
	cudaDeviceSynchronize(); // Barreira Explícita
	return(0);
}
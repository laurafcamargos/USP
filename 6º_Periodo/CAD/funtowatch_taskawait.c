#include <stdio.h>
#include <omp.h>

int main() {
#pragma omp parallel
{
	#pragma omp single
  {
		printf("A ");
    #pragma omp task
		{
			printf("race "); // task 1
		}
		#pragma omp task
		{
			printf("car "); // task 2
		}
		#pragma omp taskwait
		printf("is fun to watch.\n");
  } // fim  da região single
} // fim da região paralela
    return 0;
}


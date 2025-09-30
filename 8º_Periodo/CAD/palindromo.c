#include <stdio.h>
#include <omp.h>

int main() {
    #pragma omp parallel
    {
        #pragma omp single
        {
            #pragma omp task
            {
                printf("race"); // task 1
            }
            #pragma omp task
            {
                printf(" car"); // task 2
            }
        } // fim da região single
    } // fim da região paralela
    
    printf("\n");
    return 0;
}
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
            printf("is fun to watch.\n");
        } // fim da região single
    } // fim da região paralela
    //printf("is fun to watch.\n");
    return 0;
}
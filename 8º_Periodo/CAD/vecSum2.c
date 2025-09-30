#include <stdlib.h>
#include <stdio.h>
#include <omp.h>

int main() {
    int vector_size, seed;
    scanf("%d %d", &vector_size, &seed);
    srand(seed);

    int num_threads = omp_get_num_threads();

    int *vector = malloc(vector_size * sizeof(int));
    for (int i = 0; i < vector_size; i++)
        vector[i] = rand() % 10;
    
    int sum = 0, i;
    #pragma omp parallel for num_threads(num_threads) private(i)
    for (i = 0; i < vector_size; i++) {
        #pragma omp critical
        {
            sum += vector[i];
        }
    }
    
    printf("%d\n", sum);

    free(vector);
    return 0;
}

#include <stdio.h>
#include <omp.h>
#include <math.h>

int main() {
    int N = 10;
    double x[10] = {1,2,3,4,5,6,7,8,9,10};
    double norm = 0.0;

    // calcular a soma dos quadrados (redução)
    #pragma omp parallel for reduction(+:norm)
    for (int i = 0; i < N; i++) {
        norm += x[i] * x[i];
    }

    norm = sqrt(norm);

    // Normalizar o vetor (paralelo)
    #pragma omp parallel for
    for (int i = 0; i < N; i++) {
        x[i] /= norm;
    }

    // Print do resultado
    for (int i = 0; i < N; i++)
        printf("%.4f ", x[i]);
    printf("\n");

    return 0;
}

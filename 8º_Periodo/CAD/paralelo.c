#include <stdio.h>
#include <omp.h>

int main() {
    int i, soma = 0;

    #pragma omp parallel for reduction(+:soma)
    for (i = 0; i < 1000; i++) {
        soma += i;
    }

    printf("Soma = %d\n", soma);
    return 0;
}

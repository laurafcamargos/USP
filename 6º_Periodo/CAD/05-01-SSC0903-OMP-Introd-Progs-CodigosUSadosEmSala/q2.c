#include <stdio.h>
#include <stdlib.h>
#include <omp.h>
#include <time.h>

#define N 5        // ordem da matriz (trocar para outros testes)
#define T 4        // número de threads

// Função para calcular a potência ao quadrado: x^2
double power2(double x) {
    return x * x;
}

// Implementação simples da raiz quadrada (Método de Newton)
// Não é a forma mais precisa, mas evita o uso de <math.h>
double my_sqrt(double x) {
    if (x < 0) return 0;
    if (x == 0) return 0;
    
    // Estimativa inicial
    double guess = x / 2.0; 
    
    // Iteração para refinar a estimativa
    for (int i = 0; i < 10; i++) { // 10 iterações para precisão razoável
        guess = 0.5 * (guess + (x / guess));
    }
    return guess;
}


int main() {
    int A[N][N];
    int i, j;
    double media = 0.0;

    // Inicializa o gerador de números aleatórios com a hora
    srand(time(NULL)); 
    omp_set_num_threads(T);

    // Preenche matriz com valores aleatórios
    #pragma omp parallel for collapse(2) private(i,j) shared(A)
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            A[i][j] = rand() % 100;  // valores entre 0 e 99
        }
    }

    // 1. Calcula a média de todos os elementos
    #pragma omp parallel for reduction(+:media) private(i,j)
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            media += A[i][j];
        }
    }
    media = media / (N * N);

    // Vetores de saída
    int medial[N];
    double dsvpdr[N];

    // 2. Para cada coluna: calcula medial[j] e desvio padrão
    // Paralelismo sobre colunas (j)
    #pragma omp parallel for private(i) shared(medial, dsvpdr, A, media)
    for (j = 0; j < N; j++) {
        int count = 0;
        double soma_diff = 0.0;
        
        // Loop interno (i) para cálculo por coluna
        for (i = 0; i < N; i++) {
            // (i) Contagem de elementos menores que a média geral
            if (A[i][j] < media) {
                count++;
            }
            
            // (ii) Soma das diferenças ao quadrado: pow(x, 2) --> power2(x)
            soma_diff += power2(A[i][j] - media); 
        }

        medial[j] = count;
        // Raiz quadrada: sqrt(x) --> my_sqrt(x)
        dsvpdr[j] = my_sqrt(soma_diff / N); 
    }

    // 3. Imprime matriz (opcional para depuração)
    printf("Matriz A (%dx%d):\n", N, N);
    for (i = 0; i < N; i++) {
        for (j = 0; j < N; j++) {
            printf("%3d ", A[i][j]);
        }
        printf("\n");
    }

    // 4. Resultados
    printf("\nResultados:\n");
    printf("Média Geral (X): %.2f\n", media);
    for (j = 0; j < N; j++) {
        printf("medial[%d] = %d  dsvpdr[%d] = %.2f\n", j, medial[j], j, dsvpdr[j]);
    }

    return 0;
}
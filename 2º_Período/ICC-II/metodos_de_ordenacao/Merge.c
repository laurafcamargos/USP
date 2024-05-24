#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void merge(int a[], int n);
void merge2(int a[], int c, int f, int b[]);

void merge(int a[], int n) // qntd de elementos do vetor
{
    int *b = (int *)malloc(n * sizeof(int));
    merge2(a, 0, n - 1, b); // indice do ultimo elemento, b eh o vetor auxiliar
    free(b);
}
/*
    Função Recursiva do Algoritmo Merge Sort

    Parâmetros:
        - a: vetor a ser ordenado;
        - c: começo do vetor (incluso);
        - f: fim do vetor (incluso);
        - b: vetor extra pré alocado para cópias;
*/
void merge2(int a[], int c, int f, int b[]) {

    // Caso base: 
    if (c >= f) {
        // ou o vetor é de tamanho 0 ou de
        // tamanho 1, ou seja, já está ordenado
        return;   
    }

    // Cálculo da posição central do vetor:
    int m = (c + f) / 2;

    // Chamadas recursivas para as 2 metades:
    merge2(a, c, m, b);
    merge2(a, m + 1, f, b);

    // Inicialização dos apontadores para os vetores 
    // da esquerda e da direita, sabendo que o primeiro vetor
    // vai de c à m e que o segundo vetor de m + 1 à f:
    int i1 = c;
    int i2 = m + 1; 
    int j = 0;

    // Junção ordenada e estável dos 2 vetores:
    while (i1 <= m && i2 <= f) {
        if (a[i1] <= a[i2]) {
            b[j] = a[i1];
            i1++;
        }
        else {
            b[j] = a[i2];
            i2++;
        }
        j++;
    }

    // Junção dos elementos restantes do primeiro
    // vetor (se ele não tiver terminado):
    while (i1 <= m) {
        b[j] = a[i1];
        i1++;
        j++;
    }

    // Junção dos elementos restantes do segundo
    // vetor (se ele não tiver terminado):
    while (i2 <= f) {
        b[j] = a[i2];
        i2++;
        j++;
    }

    // Cópia dos elementos ordenados de b para a:
    j = 0;
    for(int i = c; i <= f; i++) {
        a[i] = b[j];
        j++;
    }
}
void printa_vetor(int *vetor, int n)
{
    int i;
    for (i = 0; i < n; i++)
    {
        printf("%d ", vetor[i]);
    }
}
int main()
{
    int n;
    scanf("%d", &n);
    int vetor[n];
    srand(time(NULL));

    for (int i = 0; i < n; i++)
    {
        vetor[i] = rand() % 100;
    }
    for (int i = 0; i < n; i++)
    {
        printf("%d ", vetor[i]);
    }
    printf("\n");
    merge(vetor, n);
    printa_vetor(vetor, n);
}

//Laura Fernandes Camargos 13692334
#include <stdio.h>
#include <stdlib.h>

int busca_binaria(int a[], int n, int x)
{ // vetor ordenado
    int c = 0;
    int f = n - 1;
    int m;
    while (c <= f)
    {
        m = (c + f) / 2;
        if (x == a[m])
            return a[m];
        else if (x < a[m])
        {
            f = m - 1;
        }
        else
        { // x > a[m]
            c = m + 1;
        }
    }
    return 0;
}

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


int main()
{
    int N, K;
    scanf("%d", &N);
    int *V1,*V2,*VAUX;
    
    V1 = (int *)malloc(N * sizeof(int));//vetor principal
    for (int i = 0; i < N; i++)
    {
        scanf("%d", &V1[i]);
    }

    scanf("%d", &K);
    V2 = (int *)malloc(K * sizeof(int));//vetor q armazena inteiros k
    VAUX = (int *)malloc(K * sizeof(int));//vetor auxiliar
    for (int i = 0; i < K; i++){

        scanf("%d", &V2[i]);
    }
    //ordena o vetor principal
    merge(V1,N);
    int recebe;
        for (int i = 0; i < K; i++)
        {
            recebe = V2[i];
            VAUX[i] = busca_binaria(V1,N,recebe);
            if (VAUX[i] == recebe)
            {
                printf("1\n");
            }
            else printf("0\n");
        }
    }

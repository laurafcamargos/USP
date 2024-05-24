#include <stdio.h>
#include <stdlib.h>

int busca_binaria(int a[], int n, int x);


int busca_binaria(int a[], int n, int x)
{ // vetor ordenado
    int c = 0;
    int f = n - 1;
    int m;
    while (c <= f)
    {
        m = (c + f) / 2;
        if (x == a[m])
            return m;
        else if (x < a[m])
        {
            f = m - 1;
        }
        else
        { // x > a[m]
            c = m + 1;
        }
    }
}

int main() {
    int N,K;
    scanf("%d",&N);
    int vetor[N];
    for (int i = 0; i < N; i++)
    {
        scanf("%d ",&vetor[i]);
    }
    scanf("%d",&K);
    int aux[K];
    for (int i = 0; i < K; i++)
    {
        scanf("%d",&aux[i]);
        int recebe = busca_binaria(vetor,K,aux[i]);
        printf("%d",recebe);
    }
    
    return 0; 
}
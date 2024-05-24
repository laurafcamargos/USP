#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void bubble_sort(int *vetor, int n);
void selection_sort(int *vetor, int max);
int *ler_vetor(int *vetor, int n);
void printa_vetor(int *vetor, int n);

int *ler_vetor(int *vetor, int n)
{
    for (int i = 0; i < n; i++)
    {
        scanf("%d", &vetor[i]);
    }
    return vetor;
}

void bubble_sort(int *vetor, int n)
{
    int i, j, aux, troca;
    int sentinela;
    int p = n - 1;

    for (i = n - 1; i >= 0; i--)
    {
        troca = 0;
        for (j = 0; j < p; j++)
        {
            printf("C %d %d\n", j, j + 1);
            if (vetor[j] > vetor[j + 1])
            {
                aux = vetor[j];
                vetor[j] = vetor[j + 1];
                vetor[j + 1] = aux;
                sentinela = j;
                printf("T %d %d\n", j, j + 1);
                troca++;
            }
        }
        p = sentinela;
        if (troca == 0)
        {
            break;
        }
    }
}

void selection_sort(int *vetor, int n)
{
    int i, j, menor, aux;

    for (i = 0; i < (n - 1); i++)
    {
        menor = i;
        for (j = i + 1; j < n; j++)
        {
            printf("C %d %d\n", menor, j);
            if (vetor[j] < vetor[menor])
            {
                menor = j;
            }
        }
        if (i != menor)
        {
            aux = vetor[i];
            vetor[i] = vetor[menor];
            vetor[menor] = aux;
            printf("T %d %d\n", i, menor);
        }
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
    int tam, ret;
    char met[10];
    char sel[10] = "selecao";
    scanf("%s", met);
    scanf("%d", &tam);
    int vetor[tam];
    ler_vetor(vetor, tam);
    ret = strcmp(met, sel);
    if (ret == 0)
    {
        selection_sort(vetor, tam);
        printa_vetor(vetor, tam);
    }
    else
    {
        bubble_sort(vetor, tam);
        printa_vetor(vetor, tam);
    }

    return 0;
}
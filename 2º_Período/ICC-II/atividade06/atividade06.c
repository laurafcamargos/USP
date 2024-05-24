#include <stdio.h>
#include <stdlib.h>

int contadorShell(int flag)
{
  static int count = 0;

  if (!flag)
  {

    ++count;
    return 0;
  }
  else
  {
    int aux = count;
    count = 0;
    return aux;
  }
}

int contadorQuick(int flag)
{
  static int count = 0;

  if (!flag)
  {

    ++count;
    return 0;
  }
  else
  {
    int aux = count;
    count = 0;
    return aux;
  }
}

void Shell(int *v, int n)
{

    int gap = 1;

    while (gap <= n)
    {
        gap *= 2;
    }

    gap = (gap / 2) - 1;

    while (gap > 0)
    {
        for (int i = gap; i < n; i += gap)
        {

            int x = v[i];
            int j = i - gap;
            contadorShell(0);

            while (j >= 0 && v[j] > x)
            {
                v[j + gap] = v[j];
                contadorShell(0);
                j -= gap;
                contadorShell(0);
            }
            if (j >= 0)
                contadorShell(0);

            v[j + gap] = x;
            contadorShell(0);
        }

        gap /= 2;
    }
    
}


void Quick(int *v, int f, int l,int fim)
{
    if (f >= l)
    {
        return;
    }

    int m = (l + f) / 2;

    int pivot = v[m];
    contadorQuick(0);

    int i = f;

    int j = l;

    while (1)
    {

        while (v[i] < pivot)
        {
            contadorQuick(0);
            i++;
        }
        contadorQuick(0);
        while (v[j] > pivot)
        {
            contadorQuick(0);
            j--;
        }
        contadorQuick(0);

        if (i >= j)
        {

            break;
        }

        int aux = v[i];
        contadorQuick(0);

        v[i] = v[j];
        contadorQuick(0);
        
        v[j] = aux;
        contadorQuick(0);
        
        i++;
        j--;
    }
    Quick(v, f, j,fim);
    Quick(v, j + 1, l,fim);
}

int main()
{
    int N;
    int *vetor;
    int *vetor1;
    int *vetoraux;
    int c1, c2;
    scanf("%d", &N);

    vetor = (int *)malloc(N * sizeof(int));
    vetor1 = (int *)malloc(N * sizeof(int));
    vetoraux = (int *)malloc(N * sizeof(int));

    for (int i = 0; i < N; i++)
    {
        scanf("%d", &vetor[i]);
    }
    
    for (int i = 0; i < N; i++)
    {
        vetor1[i] = vetor[i];
        vetoraux[i] = vetor[i];
    }

    for (int i = 1; i <=N; i++)
    {
        for (int j = 0; j<N; j++)
        {
            vetor[j] = vetoraux[j];
            vetor1[j] = vetoraux[j];
        }

        Shell(vetor, i);
        Quick(vetor1, 0, i-1,i);
        c1 = contadorShell(1);
        c2 = contadorQuick(1);

        if (c1 == c2)
        {
            printf("- ");
        }
        if (c1 > c2)
        {
            printf("Q ");
        }
        if (c1 < c2)
        {
            printf("S ");
        }
    }
    free(vetoraux);
    free(vetor1);
    free(vetor);
    return 0;
}
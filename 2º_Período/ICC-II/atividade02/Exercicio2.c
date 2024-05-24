#include <stdio.h>
#include <stdlib.h>

void merge(int *a, int n);
void merge2(int a[], int c, int f, int b[]);
void insertion(int *a, int n);
void liberarMemoria(int **v, int n);
int merge_troca(int flag);
int merge_comparacao(int flag);

/*
    Função responsável por contabilizar uma troca no merge ou retornar o total de trocas.
    O parâmetro "flag" possui 2 estados:
        - 0: contabiliza uma troca (retornando 0).
        - 1: retorna o numero de trocas que já aconteceram.
*/
int merge_troca(int flag)
{

  static int tr = 0;

  if (!flag)
  {

    ++tr;
    return 0;
  }
  else
  {
    int aux = tr;
    tr = 0;
    return aux;
  }
}

/*
    Função responsável por contabilizar uma comparação no merge ou retornar o total de comparações.
    O parâmetro "flag" possui 2 estados:
        - 0: contabiliza uma comparação (retornando 0).
        - 1: retorna o numero de comparações que já aconteceram.
*/
int merge_comparacao(int flag)
{

  static int cmp = 0;

  if (!flag)
  {

    ++cmp;
    return 0;
  }
  else
  {
    int aux = cmp;
    cmp = 0;
    return aux;
  }
}

/*
    Função merge original retirada do canal de texto "recursos" do servidor do
    discord da disciplina SSC0503.2022.2. Fornecida pelo monitor Luiz Fernando Rabelo.

    Alterações feitas para seguir o proposito da atividade.
*/

/*
    Função Recursiva do Algoritmo Merge Sort

    Parâmetros:
        - a: vetor a ser ordenado;
        - c: começo do vetor (incluso);
        - f: fim do vetor (incluso);
        - b: vetor extra pré alocado para cópias;
*/
void merge2(int a[], int c, int f, int b[])
{

  // Caso base:
  if (c >= f)
  {
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
  while (i1 <= m && i2 <= f)
  {

    merge_comparacao(0); // contabilizar comparação
    if (a[i1] <= a[i2])
    {

      merge_troca(0); // contabilizar troca
      b[j] = a[i1];
      i1++;
    }
    else
    {

      merge_troca(0); // contabilizar troca
      b[j] = a[i2];
      i2++;
    }
    j++;
  }
  // Junção dos elementos restantes do primeiro
  // vetor (se ele não tiver terminado):
  while (i1 <= m)
  {

    merge_troca(0); // contabilizar troca
    b[j] = a[i1];
    i1++;
    j++;
  }

  // Junção dos elementos restantes do segundo
  // vetor (se ele não tiver terminado):
  while (i2 <= f)
  {

    merge_troca(0); // contabilizar troca
    b[j] = a[i2];
    i2++;
    j++;
  }

  // Cópia dos elementos ordenados de b para a:
  j = 0;
  for (int i = c; i <= f; i++)
  {

    merge_troca(0); // contabilizar troca
    a[i] = b[j];
    j++;
  }
}
/*
    Função que ordena um vetor, chamando a função recursiva do Merge Sort

    Parâmetros:
        a: vetor a ser ordenado
        n: número de elementos do vetor
*/
void merge(int a[], int n)
{
  int *b = (int *)malloc(sizeof(int) * n);
  merge2(a, 0, n - 1, b);
  printf("M %d %d %d\n", n, merge_troca(1), merge_comparacao(1));
  free(b);
}
void insertion(int *a, int n) //
{
  int count_c = 0, count_t = 0;
  for (int p = 1; p < n; p++)
  {
    int x = a[p];
    int i = p - 1;
    count_t++;
    while (i >= 0 && x < a[i])
    {
      count_c++;
      a[i + 1] = a[i];
      count_t++;
      i--;
    }
    if (i >= 0 && x >= a[i])
    {
      count_c++;
    }
    a[i + 1] = x;
    count_t++;
  }
  printf("I %d %d %d\n", n, count_t, count_c);
}
void liberarMemoria(int **v, int n)
{
  for (int i = 0; i < n; i++)
  {
    free(v[i]);
  }
  free(v);
}
int main()
{
  int q;
  int **vetor;
  int **vetor1;
  scanf("%d", &q);
  int n[q];
  for (int i = 0; i < q; i++)
  {
    scanf("%d", &n[i]);
  }
  vetor = (int **)malloc(q * sizeof(int *));
  for (int i = 0; i < q; i++)
  {
    vetor[i] = (int *)malloc(n[i] * sizeof(int));
    for (int j = 0; j < n[i]; j++)
    {
      scanf("%d", &vetor[i][j]);
    }
  }
  vetor1 = malloc(q * sizeof(int *));
  for (int i = 0; i < q; i++)
  {
    vetor1[i] = malloc(n[i] * sizeof(int));
  }
  for (int i = 0; i < q; i++)
  {
    for (int j = 0; j < n[i]; j++)
    {
      vetor1[i][j] = vetor[i][j];
    }
  }
  for (int i = 0; i < q; i++)
  {
    insertion(vetor[i], n[i]); // passa cada elemento do n por vez, por isso o [i]
    merge(vetor1[i], n[i]);
  }
  liberarMemoria(vetor, q);
  liberarMemoria(vetor1, q);
  return 0;
}
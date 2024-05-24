#include<stdio.h>
#include<stdlib.h>
//Júlio César Cabral - 13672922
//Laura Fernandes Camargos - 13692334
//Lucas Masaki Maeda - 13692272
//Matheus Henrique da Silva - 13696658

int insere(int *hash, int elemento, int M);
int busca(int *hash, int elemento, int M);
void remove_elemento(int *hash, int elemento, int M);

int insere(int *hash, int elemento, int M) {
    int h;
    for (int i = 0; i < M; i++)
    {
        h = (elemento+i) % M;
        if (hash[h] == -1) {
            hash[h] = elemento; //onde tiver vazio coloca o elemento
        }
        if (hash[h] == elemento) {
            return 0;//não permite insercao repetida
        }
    }
    return 0;
}
void remove_elemento(int *hash, int elemento, int M) {

    int h = busca(hash,elemento,M);
    for (int i = 0; i < M; i++) {
        if(h != -1) 
            hash[h] = -1; //se encontrar a posicao, coloca -1 e deleta o elemento
    }
}
int busca(int *hash, int elemento, int M) {
    int h;
    for (int i = 0; i < M; i++)
    {
        h = (elemento+i) % M;
        if (hash[h] == elemento) {
            return h; //retorna posição se achar
        }
    }
    return -1;//se nao achar retorna -1
}

int main() {
    int M;//capacidade
    int N;//inserções
    int D;//remoções
    int B;//busca
    int elemento;
    int recebe;
    
    scanf("%d",&M);
    int *hash = (int*)malloc(sizeof(int) * M);
    for (int i = 0; i < M; i++) {
        hash[i] = -1; //inicia todas as posições com -1
    }
    scanf("%d",&N);
    for (int i = 0; i < N; i++) {

        scanf("%d",&elemento);
        insere(hash,elemento,M);
    }
    scanf("%d",&D);
    for (int i = 0; i < D; i++) {

        scanf("%d",&elemento);
        remove_elemento(hash,elemento,M);           
    }
    scanf("%d",&B);
    for (int i = 0; i < B; i++) {

        scanf("%d",&elemento);
       recebe = busca(hash,elemento,M);
       printf("%d ",recebe);
    }
}
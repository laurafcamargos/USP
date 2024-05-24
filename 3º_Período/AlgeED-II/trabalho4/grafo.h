#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#define GRAFO_H
#ifdef GRAFO_H


#define MAX_VERTICES 50 //número máximo de vértices no grafo
#define MAX_NOME 20 //tamanho máximo para o nome do cliente

//estrutura para representar uma aresta
struct Aresta {
    int destino;
    float peso;
};

//estrutura para representar um vértice
struct Vertice {
    char nome[MAX_NOME];
};

//estrutura para representar um grafo
struct Grafo {
    struct Aresta arestas[MAX_VERTICES][MAX_VERTICES];
    struct Vertice vertices[MAX_VERTICES];
    int numVertices;
};

//estrutura da heap binaria
struct HeapNo {
    int vertice;
    float distancia;
};

struct Heap {
    struct HeapNo *vetor;
    int tamanho;
    int capacidade;
};

//funções utilizadas envolvendo o grafo
void inicializarGrafo(struct Grafo* grafo);
void adicionarVertice(struct Grafo* grafo, char nome[]);
void adicionarAresta(struct Grafo* grafo, int origem, int destino, float peso);
void dijkstra(struct Grafo* grafo, int pizzaria, int cliente);

//funções utilizadas envolvendo a heap

struct HeapNo extrairMin(struct Heap* heap);
void inserir(struct Heap* heap, struct HeapNo node);
void heapifyDown(struct Heap *heap, int index);
void trocar(struct HeapNo* a, struct HeapNo* b);
void heapifyUp(struct Heap *heap, int index);
struct Heap* criarHeap(int capacidade);
void relax(struct Grafo* grafo, int u, int v, float* distancias, struct Heap* heap);
struct HeapNo criarHeapNode(int vertice, float distancia);

#endif
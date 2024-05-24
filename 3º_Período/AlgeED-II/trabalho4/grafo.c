#include "grafo.h"

//inicializa o grafo colocando o numero de vértices = 0
void inicializarGrafo(struct Grafo* grafo) {
    grafo->numVertices = 0;
}

//adiciona um vértice ao grafo
void adicionarVertice(struct Grafo* grafo, char nome[]) {
    strcpy(grafo->vertices[grafo->numVertices].nome, nome);
    grafo->numVertices++;
}

//adiciona uma aresta ao grafo
void adicionarAresta(struct Grafo* grafo, int origem, int destino, float peso) {
    grafo->arestas[origem][destino].destino = destino;
    grafo->arestas[origem][destino].peso = peso;
}


//encontra o caminho mais curto usando o algoritmo Dijkstra
void dijkstra(struct Grafo* grafo, int pizzaria, int cliente) {

    float distancias[MAX_VERTICES]; // vetor de distâncias
    int visitado[MAX_VERTICES] = { 0 }; // vetor para marcar os vértices visitados

    // inicializa as distâncias como infinito para todos os vértices, exceto a pizzaria (0)
    for (int i = 0; i < grafo->numVertices; i++) {
        distancias[i] = INT_MAX;
    }

    distancias[pizzaria] = 0; // a distância da pizzaria até ela mesma é 0

    struct Heap* heap = criarHeap(grafo->numVertices);
    inserir(heap, criarHeapNode(pizzaria, 0));

    while (heap->tamanho > 0) {
        struct HeapNo min = extrairMin(heap);
        int verticeAtual = min.vertice;
        visitado[verticeAtual] = 1; // marca o vértice como visitado

        if (verticeAtual == cliente) {
            break; // chegou ao cliente, interrompe o algoritmo
        }

        // atualiza as distâncias dos vértices adjacentes ao vértice atual
        for (int j = 0; j < grafo->numVertices; j++) {
            if (!visitado[j] && grafo->arestas[verticeAtual][j].peso != 0) {
                relax(grafo, verticeAtual, j, distancias, heap);
            }
        }
    }

    // verifica se foi encontrado um caminho até o cliente
    if (distancias[cliente] != INT_MAX) {
        float calculo = distancias[cliente] * 0.2 + 1.5;
        printf("%.2f\n", calculo); // realiza o cálculo total da entrega
    }

    free(heap->vetor);
    free(heap);
}


/*funções utilizadas na heap*/

struct HeapNo criarHeapNode(int vertice, float distancia) {
    struct HeapNo no;
    no.vertice = vertice;
    no.distancia = distancia;
    return no;
}

struct Heap* criarHeap(int capacidade) {
    struct Heap* heap = (struct Heap*)malloc(sizeof(struct Heap));
    heap->vetor = (struct HeapNo*)malloc(capacidade * sizeof(struct HeapNo));
    heap->tamanho = 0;
    heap->capacidade = capacidade;
    return heap;
}
void trocar(struct HeapNo* a, struct HeapNo* b) {
    struct HeapNo temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(struct Heap* heap, int index) {
    int parent = (index - 1) / 2;

    while (index > 0 && heap->vetor[index].distancia < heap->vetor[parent].distancia) {
        trocar(&heap->vetor[index], &heap->vetor[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(struct Heap* heap, int index) {
    int leftChild = 2 * index + 1;
    int rightChild = 2 * index + 2;
    int menor = index;

    if (leftChild < heap->tamanho && heap->vetor[leftChild].distancia < heap->vetor[menor].distancia) {
        menor = leftChild;
    }

    if (rightChild < heap->tamanho && heap->vetor[rightChild].distancia < heap->vetor[menor].distancia) {
        menor = rightChild;
    }

    if (menor != index) {
        trocar(&heap->vetor[index], &heap->vetor[menor]);
        heapifyDown(heap, menor);
    }
}

void inserir(struct Heap* heap, struct HeapNo node) {
    if (heap->tamanho == heap->capacidade) {
        return;
    }

    heap->vetor[heap->tamanho] = node;
    heapifyUp(heap, heap->tamanho);
    heap->tamanho++;
}

struct HeapNo extrairMin(struct Heap* heap) {
    struct HeapNo min = heap->vetor[0];
    heap->vetor[0] = heap->vetor[heap->tamanho - 1];
    heap->tamanho--;
    heapifyDown(heap, 0);
    return min;
}

void relax(struct Grafo* grafo, int u, int v, float* distancias, struct Heap* heap) {
    float peso = grafo->arestas[u][v].peso;
    if (distancias[u] + peso < distancias[v]) {
        distancias[v] = distancias[u] + peso;
        inserir(heap, criarHeapNode(v, distancias[v]));
    }
}
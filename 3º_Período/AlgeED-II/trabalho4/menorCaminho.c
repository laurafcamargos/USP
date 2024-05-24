#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "grafo.h"
//Laura Fernandes Camargos - 13692334

int main() {
    //lê os dados de entrada
    int numVertices;
    scanf("%d", &numVertices);

    struct Grafo grafo;
    inicializarGrafo(&grafo);

    //lê os vértices
    for (int i = 0; i < numVertices; i++) {
        char nome[MAX_NOME];
        scanf("%s", nome);
        adicionarVertice(&grafo, nome);
    }

    int numArestas;
    scanf("%d", &numArestas);

    //lê as arestas
    for (int i = 0; i < numArestas; i++) {
        char origem[MAX_NOME], destino[MAX_NOME];
        float peso;

        scanf("%s", origem);
        scanf("%s", destino);
        scanf("%f", &peso);

        int indexOrigem = -1, indexDestino = -1;

        //encontra o índice do vértice de origem
        for (int j = 0; j < grafo.numVertices; j++) {
            if (strcmp(grafo.vertices[j].nome, origem) == 0) {
                indexOrigem = j;
                break;
            }
        }

        //encontra o índice do vértice de destino
        for (int j = 0; j < grafo.numVertices; j++) {
            if (strcmp(grafo.vertices[j].nome, destino) == 0) {
                indexDestino = j;
                break;
            }
        }

        //verifica se os vértices foram encontrados
        if (indexOrigem != -1 && indexDestino != -1) {
            adicionarAresta(&grafo, indexOrigem, indexDestino, peso);
            adicionarAresta(&grafo, indexDestino, indexOrigem, peso); // Grafo não direcionado
        } else {
            exit(1); //algum vértice não foi encontrado
        }
    }

    int numPedidos;
    scanf("%d", &numPedidos);

    //interpreta os pedidos
    for (int i = 0; i < numPedidos; i++) {
        char cliente[MAX_NOME];
        scanf("%s", cliente);

        int indexCliente = -1;

        //encontra o índice do cliente que fez o pedido
        for (int j = 0; j < grafo.numVertices; j++) {
            if (strcmp(grafo.vertices[j].nome, cliente) == 0) {
                indexCliente = j;
                break;
            }
        }

        //verifica se o cliente foi encontrado
        if (indexCliente != -1) {
            dijkstra(&grafo, 0, indexCliente); //considera que a pizzaria é o vértice de índice 0
        } else {
            exit(1); //cliente não foi encontrado 
        }
    }

    return 0;
}

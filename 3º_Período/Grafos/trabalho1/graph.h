#ifndef GRAPH_H
#define GRAPH_H
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

#define MAX(a,b) a >= b ? a : b
#define MIN(a,b) a <= b ? a : b

typedef struct {
   bool exist;
   int weight;
} EDGE;

typedef struct graph {
   EDGE **matrix;
   int N;
} GRAPH;


//functions
int GraphExists(GRAPH* graph); // função para verificar se o grafo existe

GRAPH *MyGraph(int N); //criar matriz

bool Exist_Edge(int v1, int v2, GRAPH *graph); // verifica se aresta existe

void Add_Edge(int v1, int v2, GRAPH *graph); // inserir aresta no grafo

int* Get_Adj_Vertex(int vertex, GRAPH* graph); // retorna lista de vertices adjacentes a um determinado vertice

void Remove_Edge(int v1, int v2, GRAPH* graph); // remove uma aresta

int Number_Of_Vertexs(GRAPH* graph); // retorna o numero de vertices do grafo

void Print_Info(GRAPH* graph); // imprime vertices e arestas

void Remove_Graph(GRAPH* graph); // remove o grafo

void Adjacency_Matrix(GRAPH* graph); // retorna a matriz de adjacencia

void Remove_Edge_Weight(GRAPH* graph); // remove aresta de menor peso

void Add_Wheighted_Edge(int v1, int v2, int w, GRAPH *graph); // insere aresta com um peso especifico

void FreeGraph(GRAPH* graph);
int Number_Of_Edges(GRAPH* graph);

bool Exist_Vertex(int v, GRAPH *graph);

#endif
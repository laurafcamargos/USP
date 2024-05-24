#include "graph.h"

int GraphExists(GRAPH* graph) {
    return (graph != NULL) ? 1 : 0; //a função retorna 1 se o grafo existir e 0 se não existir
}

GRAPH *MyGraph(int N) {
   GRAPH *adj_matrix = (GRAPH *)malloc(sizeof(GRAPH));
   if (adj_matrix != NULL) {
      adj_matrix->N = N;
      adj_matrix->matrix = (EDGE **)malloc(sizeof(EDGE *) * N);
      for (int i = 0; i < N; i++)
         adj_matrix->matrix[i] = (EDGE *)malloc(sizeof(EDGE) * N);
      for (int i = 0; i < N; i++)
         for (int j = 0; j < N; j++){
            adj_matrix->matrix[i][j].exist = false;  //nao existem arestas ate o momento
            adj_matrix->matrix[i][j].weight = 0;  //peso da aresta é 0 por padrão
         }
   }
   return adj_matrix;
}

bool Exist_Edge(int v1, int v2, GRAPH *graph){ // o que que isso esta fazendo MDS 
   v1--;
   v2--;

   return graph->matrix[v1][v2].exist;
}

void Add_Edge(int v1, int v2, GRAPH *graph){

   v1--;
   v2--;

   if (graph->matrix[v1][v2].exist){
      printf("Aresta já existe\n");
      return;
   }
   graph->matrix[v1][v2].exist = true;
   graph->matrix[v2][v1].exist = true;
   printf("Aresta add com sucesso!!\n");
}

int* Get_Adj_Vertex(int vertex, GRAPH* graph){   
   
   if(vertex > graph->N){
      return NULL;
   }
   int *neighbours = calloc(graph->N, sizeof(int));
   vertex--;
   
   for (int i = 0; i < graph->N; i++) {
      if(graph->matrix[vertex][i].exist && i != vertex){
         neighbours[i] = 1;
      }
      
      //printf("vertice %d : vizinho %d\n",i+1, neighbours[i]);
   }

   return neighbours;
   
}

void Remove_Edge(int v1, int v2, GRAPH* graph){
   v1--;
   v2--;
   if (!graph->matrix[v1][v2].exist){
      printf("Aresta não existe\n");
      return;
   }
   graph->matrix[v1][v2].exist = false;
   graph->matrix[v2][v1].exist = false;
   printf("Aresta removida com sucesso!!\n");
}


int Number_Of_Vertexs(GRAPH* graph){
   return graph->N;
}

int Number_Of_Edges(GRAPH* graph){
   int n = 0;
   if(graph != NULL){
      for(int i = 0; i < graph->N; i++){
         for(int j = 0; j < graph->N; j++){
            if(graph->matrix[i][j].exist){
               n++;
            }
         }
      }
   }
   return n;
}

void Print_Info(GRAPH* graph){
   printf("Number of Vertexes: %d, Number of Edges: %d\n", Number_Of_Vertexs(graph), Number_Of_Edges(graph)/2);
   for(int i = 0; i < graph->N; i++){
      printf("Vertex %d, edges:{", i+1);
      for(int j = 0; j < graph->N; j++){
         if(graph->matrix[i][j].exist == true){
            printf("(%d,%d)",i+1, j+1);
         } 
      }
      printf("}");
      printf("\n");      
   }   
}

void Adjacency_Matrix(GRAPH* graph) {
   for (int i = 0; i < graph->N; i++) {
      for (int j = 0; j < graph->N; j++) {
       if (graph->matrix[i][j].exist)
          printf("[%2d] ",graph->matrix[i][j].weight); // Se existe uma aresta entre os vértices i e j, imprime [x]
       else
          printf("[-1] "); // Se não existe uma aresta entre os vértices i e j, imprime [ ]
      }
      printf("\n");
   }     
}

void FreeGraph(GRAPH* graph) {
    if (graph != NULL) {
        if (graph->matrix != NULL) {
            for (int i = 0; i < graph->N; i++) {
                free(graph->matrix[i]);
            }
            free(graph->matrix);
        }
        free(graph);
    }
}

void Remove_Edge_Weight(GRAPH* graph){

   int v1, v2, j;

   for(int i = 0; i < graph->N; i++){
      for(j = 0; j < graph->N; j++){
         if(graph->matrix[i][j].exist){
            v1 = i;
            v2 = j;
            break;
         } 
      }
      if(graph->matrix[i][j].exist){
            break;
      }
   }

   for (int i = 0; i < graph->N; i++){
      for(int j = 0; j < graph->N; j++){
         if(graph->matrix[i][j].exist && (graph->matrix[i][j].weight < graph->matrix[v1][v2].weight)){
            v1 = i;
            v2 = j;
         }
      }
   }
   graph->matrix[v1][v2].exist = false;
   graph->matrix[v2][v1].exist = false;
   graph->matrix[v1][v2].weight = 0;
   graph->matrix[v2][v1].weight = 0;
   printf("Aresta de menor peso %d %d removida com sucesso!!\n",v1+1,v2+1);
}

void Add_Wheighted_Edge(int v1, int v2, int w, GRAPH *graph){
   v1--;
   v2--;
   if (graph->matrix[v1][v2].exist){
      printf("Aresta já existe\n");
      return;
   }
   graph->matrix[v1][v2].exist = true;
   graph->matrix[v2][v1].exist = true;
   graph->matrix[v1][v2].weight = w;
   graph->matrix[v2][v1].weight = w;
   printf("Aresta add com sucesso!!\n");
}

bool Exist_Vertex(int v, GRAPH *graph){ // Verifica se o vertice existe retornando false para caso nao exista e true para se existir
   if(v > graph->N){
      return false;
   }
   else{
      return true;
   }
}
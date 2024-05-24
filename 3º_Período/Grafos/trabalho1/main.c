#include "graph.h"

int main () {
   GRAPH *graph = NULL;
   int f;
   int isGraphCreated = 0; // Variável para verificar se o grafo foi criado

   printf("Digite: \n 1 Para criar um Grafo\n 2 Para verificar a existência de uma aresta\n 3 Para obter os vértices adjacentes a outro\n 4 Para remover uma aresta\n 5 Para imprimir os vértices e arestas\n 6 Para obter o número de vértices do grafo\n 7 Para excluir o grafo e sair do programa\n 8 Para inserir uma aresta\n 9 Para remover a aresta de menor peso\n 10 Para obter a matriz de adjecência\n");

   while(1){
      printf("Digite a operação: ");
      scanf("%d", &f);
      switch(f){
         int a, b, p, n, *v;
         case 1: 
            printf("Digite o número de vértices: ");
            scanf("%d", &n);
            graph = MyGraph(n);
            isGraphCreated = GraphExists(graph); // Verifica se o grafo foi criado
            break;
         case 2: 
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            printf("Digite os vértices da aresta separados por espaço (ex.: <vertice> <vertice>): ");
            scanf("%d %d", &a, &b);
            if(Exist_Vertex(a, graph) == false){ // Verifica se o primeiro vertice digitado existe
               printf("O vertice %d vértice não existe\n", a);
               break;
            }
            if(Exist_Vertex(b, graph) == false){ // Verifica se o segundo vertice digitado existe
               printf("O vertice %d vértice não existe\n", b);
               break;
            }
            if(Exist_Edge(a, b, graph))
               printf("A aresta existe.\n");
            else
               printf("A aresta não existe.\n");
            break;

         case 3: 
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            printf("Digite o vértice: ");
            scanf("%d", &a);
            if(Exist_Vertex(a, graph) == false){ // Verifica se o vertice digitado existe
               printf("O vertice %d vértice não existe\n", a);
               break;
            }
            v = Get_Adj_Vertex(a, graph);
            printf("Os vizinhos são: ");
            for(int i = 0; i < n; i++){
               if(v[i]){
                  printf("%d ", i+1);
               }
            }
            printf("\n");
            break;
         case 4:
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            printf("Digite os vértices da aresta separados por espaço (ex.: <vertice> <vertice>): ");
            scanf("%d %d", &a, &b);
            Remove_Edge(a, b, graph);
            break;

         case 5:
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            Print_Info(graph);
            break;
         
         case 6: 
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            printf("%d\n", Number_Of_Vertexs(graph));
            break;
         
         case 7:
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            FreeGraph(graph);
            return 0;
         
         case 8:
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            printf("Digite os vértices da aresta e o peso separados por espaço (ex.: <vertice> <vertice> <peso>): ");
            scanf("%d %d %d", &a, &b, &p);
            if(Exist_Vertex(a, graph) == false){ // Verifica se o primeiro vertice digitado existe
               printf("O vertice %d vértice não existe\n", a);
               break;
            }
            if(Exist_Vertex(b, graph) == false){ // Verifica se o segundo vertice digitado existe
               printf("O vertice %d vértice não existe\n", b);
               break;
            }
            Add_Wheighted_Edge(a, b, p, graph);
            break;
         case 9:
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            Remove_Edge_Weight(graph);
            break;
         case 10:
            if (!isGraphCreated) { // Verifica se o grafo foi criado
               printf("O grafo não foi criado ainda.\n");
               break;
            }
            Adjacency_Matrix(graph);
            break;
         default:
            printf("Operação não permitida\n");
            break;  
      }
   }

   return 0;
}

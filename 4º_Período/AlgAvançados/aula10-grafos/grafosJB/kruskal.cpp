#include <iostream>
#include <cstdio>
#include <cstring>
#include <vector>
#include <algorithm>

#include "UnionFind.h"

using namespace std;

// par de inteiros: guarda o vertice v e o peso da aresta
typedef pair<int,int> ii;

// todos os vertices v adjacentes a u 
typedef vector<ii> vii;

// lista de adjacencia para todo vertice u do meu grafo..
//vector<vii> AdjList(200);

vector<pair<int, ii> > EdgeList;  //Lista arestas que é um par (w, (u,v))

typedef vector<int> vi;

int A;
int V; 

int  main(int argc, char const *argv[])
{
	cin >> V >> A;
	
	int v, u, w;
	// cria a lista de arestas, onde o peso é o list.first !!!!
	for (int i = 0; i < A; ++i){
		cin >> u >> v >> w;
		EdgeList.push_back(make_pair(w, ii(u, v)));
	}

	// ordena a lista de arestas
	sort(EdgeList.begin(), EdgeList.end());

	int custo = 0;

	UnionFind uf(V);

	// consome a lista de arestas....
	for (int i = 0; i < EdgeList.size(); ++i) {
		pair<int,ii> el = EdgeList[i];

		// verifica se u e v nao formam ciclo
		if (!uf.isSameSet(el.second.first, el.second.second)){
			custo = custo + el.first;
			// coloque u e v no mesmo conjunto....
			uf.unionSet(el.second.first, el.second.second);
		}

	}

	printf("O custo da arvore geradora minima = %d\n", custo);

	return 0;
}
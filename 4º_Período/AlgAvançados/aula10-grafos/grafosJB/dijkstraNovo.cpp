#include <iostream>
#include <cstdio>
#include <cstring>
#include <vector>
#include <queue>

using namespace std;

// par de inteiros: guarda o vertice v e o peso da aresta
typedef pair<int,int> ii;

// todos os vertices v adjacentes a u 
typedef vector<ii> vii;

// lista de adjacencia para todo vertice u do meu grafo..
vector<vii> AdjList(200);

typedef vector<int> vi;

//#define VISITADO 1
//#define NAOVISITADO 0
#define INF 10000000

vi d; // vetor de distancia....
vi pai;

void printAdjList(int nv){
	for (int u = 0; u < nv; ++u){ // para todo vertice u
		printf("%d -> ", u);
		for (int i = 0; i < AdjList[u].size(); ++i) { // para todo adjacente v de u
			ii v = AdjList[u][i];
			printf("(%d, %d) -> ", v.first, v.second);
		}
		printf("\n");
	}
}

void dijkstra(int s, int nv){
	// cria uma lista MIN HEAP !!!
	priority_queue<ii, vector<ii>, greater<ii> > q;

	//vi d(nv,INF);
	d.assign(nv, INF);
	pai.assign(nv,-1);
	d[s] = 0; // a distancia de u para u eh zero.
	q.push(ii(0,s)); 

	while(!q.empty()){
		ii k = q.top(); q.pop();
		int dist = k.first; 
		int u = k.second;
		printf(" (%d,%d) ", dist, u);

		if (dist > d[u])
			continue;

		for (int i = 0; i < AdjList[u].size(); ++i) { // para todo adjacente v de u
			ii v = AdjList[u][i];
			if (d[u] + v.second < d[v.first]){ // relaxa o vertice v
				d[v.first] = d[u] + v.second;  // o nivel do adj v eh o do pai k + 1
				pai[v.first] = u;
				q.push(ii(d[v.first],v.first));  // coloca o adj na fila...
			}
		}
	}

}

void printPath(int s, int t){
	if (t == s){
		printf("%d", s);
		return;
	}
	printPath(s, pai[t]);
	printf(" -> %d", t);
}

int main(int argc, char const *argv[])
{
	int A, V, s,t;

	cin >> V >> A; 

	int u,v,w;

	for (int i = 0; i < A; ++i){
		cin >> u >> v >> w;
		AdjList[u-1].push_back(make_pair(v-1, w));
		//AdjList[v-1].push_back(make_pair(u-1, w));
	}

	printAdjList(V);

	dijkstra(0, V); printf("\n");
	printf("A distancia de %d para os demais vertices eh\n", s);
	for (int i = 0; i < V; ++i){
		printf("d[%d] = %d\n", i, d[i]);
	}

	//printf("O caminho de %d ate %d eh \n", s,t);
	//printPath(s,t);

	return 0;
}


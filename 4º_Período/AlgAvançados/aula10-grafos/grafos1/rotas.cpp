#include <iostream>
#include <cstdio>
#include <vector>
#include <algorithm>

using namespace std;

// par de inteiros: guarda o vértice v e o peso da aresta
typedef pair<int, int> ii;

// todos os vértices v adjacentes a u
typedef vector<ii> vii;

// lista de adjacência para todo vértice u do meu grafo
vector<vii> AdjList(2000), AdjListT(2000); //inclui o grafo transposto

typedef vector<int> vi;

#define VISITADO 1
#define NAOVISITADO 0

int nv;    // Número de vértices
vi vis;    // Vetor de visitados

//depurar
void printAdjList(vector<vii>& adj, const string& name) {
    printf("%s:\n", name.c_str());
    for (int u = 0; u < nv; ++u) { // para todo vértice u
        printf("%d -> ", u + 1);
        for (int i = 0; i < adj[u].size(); ++i) { // para todo adjacente v de u
            ii v = adj[u][i];
            printf("%d -> ", v.first + 1);
        }
        printf("\n");
    }
}

//dfs
void dfs(int u, vector<vii>& adj) {
    vis[u] = VISITADO;
    for (int i = 0; i < adj[u].size(); ++i) { // para todo adjacente v de u
        ii v = adj[u][i];
        if (vis[v.first] == NAOVISITADO)
            dfs(v.first, adj);
    }
}

int main(int argc, char const* argv[]) {
    int ar;
    while (true) {
        cin >> nv >> ar;
        if (nv == 0 && ar == 0) break;

        AdjList.assign(nv, vii());
        AdjListT.assign(nv, vii());
        vis.assign(nv, NAOVISITADO);

        int u, v, r;

        while (ar--) { // leia todas as arestas
            cin >> u >> v >> r;
            --u, --v; 
            AdjList[u].push_back({v, 0}); //grafo original
            AdjListT[v].push_back({u, 0}); //grafo transposto
            if (r == 2) { //se a relação é recíproca
                AdjList[v].push_back({u, 0});
                AdjListT[u].push_back({v, 0});
            }
        }

        // Debug: imprimir as listas de adjacência
        // printAdjList(AdjList, "Original");
        // printAdjList(AdjListT, "Transposto");

        dfs(0, AdjList);
        if (find(vis.begin(), vis.end(), NAOVISITADO) != vis.end()) {
            cout << 0 << endl;
            continue;
        }

        fill(vis.begin(), vis.end(), NAOVISITADO);
        dfs(0, AdjListT);
        if (find(vis.begin(), vis.end(), NAOVISITADO) != vis.end()) {
            cout << 0 << endl;
            continue;
        }

        //se ambas as verificações passaram -> o grafo é fortemente conectado
        cout << 1 << endl;
    }

    return 0;
}

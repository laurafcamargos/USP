#include <bits/stdc++.h>
using namespace std;
//pode visitar uma mesma farmacia mas uma mesma aresta não
int max_trajeto;  

void backtrack(int v, vector<vector<int>>& grafo, vector<vector<bool>>& aresta_visitada, int comprimento_atual) {
    max_trajeto = max(max_trajeto, comprimento_atual);

    //tenta visitar todos os vizinhos de v
    for (int vizinho : grafo[v]) {
        //aresta ja foi visitada?
        if (!aresta_visitada[v][vizinho]) {
            aresta_visitada[v][vizinho] = aresta_visitada[vizinho][v] = true;
            backtrack(vizinho, grafo, aresta_visitada, comprimento_atual + 1);
            //desmarca a aresta para permitir backtracking
            aresta_visitada[v][vizinho] = aresta_visitada[vizinho][v] = false;
        }
    }
}

int turismo_farmaceutico(int n, vector<vector<int>>& grafo) {
    max_trajeto = 0;
    vector<vector<bool>> aresta_visitada(n, vector<bool>(n, false));  //matriz de arestas visitadas

    //tenta iniciar o backtracking a partir de cada farmácia
    for (int v = 0; v < n; v++) {
        backtrack(v, grafo, aresta_visitada, 0); 
    }
    return max_trajeto;  
}

int main() {
    while (true) {
        int n, m;
        cin >> n >> m;

        if (n == 0 && m == 0) break;  

        vector<vector<int>> grafo(n);  
        for (int i = 0; i < m; i++) {
            int u, v;
            cin >> u >> v;
            grafo[u].push_back(v);
            grafo[v].push_back(u);
        }
        cout << turismo_farmaceutico(n, grafo) << endl;
    }

    return 0;
}

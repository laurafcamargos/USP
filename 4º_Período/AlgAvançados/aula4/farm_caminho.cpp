#include <bits/stdc++.h>
using namespace std;

int max_trajeto;
vector<int> caminho_atual;  // Armazena o caminho atual
vector<int> caminho_mais_longo;  // Armazena o caminho mais longo encontrado

// Função de busca com backtracking
void backtrack(int v, vector<vector<int>>& grafo, vector<vector<bool>>& aresta_visitada, int comprimento_atual) {
    // Adiciona o nó atual ao caminho
    caminho_atual.push_back(v);

    // Atualiza o maior trajeto encontrado
    if (comprimento_atual > max_trajeto) {
        max_trajeto = comprimento_atual;
        caminho_mais_longo = caminho_atual;  // Atualiza o caminho mais longo
    }

    // Tenta visitar todos os vizinhos de v
    for (int vizinho : grafo[v]) {
        // Verifica se a aresta entre v e vizinho já foi visitada
        if (!aresta_visitada[v][vizinho]) {
            // Marca a aresta como visitada nos dois sentidos
            aresta_visitada[v][vizinho] = aresta_visitada[vizinho][v] = true;

            // Continua a exploração a partir do vizinho
            backtrack(vizinho, grafo, aresta_visitada, comprimento_atual + 1);

            // Desmarca a aresta para permitir backtracking
            aresta_visitada[v][vizinho] = aresta_visitada[vizinho][v] = false;
        }
    }

    // Remove o nó atual do caminho antes de voltar na recursão
    caminho_atual.pop_back();
}

int turismo_farmaceutico(int n, vector<vector<int>>& grafo) {
    max_trajeto = 0;
    caminho_mais_longo.clear();  // Limpa o caminho mais longo
    vector<vector<bool>> aresta_visitada(n, vector<bool>(n, false));  // Matriz de arestas visitadas

    // Tenta iniciar o backtracking a partir de cada farmácia (vértice)
    for (int v = 0; v < n; v++) {
        backtrack(v, grafo, aresta_visitada, 0);  // Começa o backtracking com comprimento 0
    }

    return max_trajeto;  // Retorna o maior trajeto encontrado
}

int main() {
    while (true) {
        int n, m;
        cin >> n >> m;

        if (n == 0 && m == 0) break;  // Condição de parada

        vector<vector<int>> grafo(n);  // Inicializa o grafo

        // Lê as arestas e constrói o grafo
        for (int i = 0; i < m; i++) {
            int u, v;
            cin >> u >> v;
            grafo[u].push_back(v);
            grafo[v].push_back(u);
        }

        // Calcula o maior trajeto
        int resultado = turismo_farmaceutico(n, grafo);

        // Imprime o maior trajeto
        cout << "Comprimento do maior trajeto: " << resultado << endl;

        // Imprime o caminho mais longo
        cout << "Caminho mais longo: ";
        for (int no : caminho_mais_longo) {
            cout << no << " ";
        }
        cout << endl;
    }

    return 0;
}

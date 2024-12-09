#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class UnionFind {
private:
    vector<int> p, rank, size; // Vetores para pais, rank e tamanho
    int num_components;       // Número de componentes
    int max_size;             // Tamanho do maior componente

public:
    UnionFind(int N) {
        p.assign(N, 0);
        rank.   (N, 0);
        size.assign(N, 1);  // Inicialmente, cada componente tem tamanho 1
        num_components = N; // Inicialmente, cada nó é seu próprio componente
        max_size = 1;       // O maior componente tem tamanho 1 no início
        for (int i = 0; i < N; i++) {
            p[i] = i; // Cada nó é pai de si mesmo
        }
    }

    int find(int i) {
        if (p[i] != i) {
            p[i] = find(p[i]); // Compressão de caminho
        }
        return p[i];
    }

    bool merge(int i, int j) {
        int x = find(i);
        int y = find(j);

        if (x == y) return false; // Já estão no mesmo componente

        // Une os componentes com base no rank
        if (rank[x] > rank[y]) {
            p[y] = x;            // x se torna pai de y
            size[x] += size[y];  // Atualiza o tamanho do componente
        } else {
            p[x] = y;            // y se torna pai de x
            size[y] += size[x];  // Atualiza o tamanho do componente
            if (rank[x] == rank[y]) {
                rank[y]++;       // Aumenta o rank de y se forem iguais
            }
        }

        num_components--; 
        max_size = max(max_size, max(size[x], size[y])); // Atualiza o maior tamanho
        return true;
    }

    int getNumComponents() {
        return num_components;
    }

    int getMaxSize() {
        return max_size;
    }
};

int main() {
    int n, m;
    cin >> n >> m;

    UnionFind uf(n); // Union-Find com n nós

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        a--; b--; 
        uf.merge(a, b);
        cout << uf.getNumComponents() << " " << uf.getMaxSize() << endl;
    }

    return 0;
}

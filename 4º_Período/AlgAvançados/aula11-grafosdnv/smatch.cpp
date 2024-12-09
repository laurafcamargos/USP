#include <bits/stdc++.h>
using namespace std;

// Alias para vetor de inteiros
typedef vector<int> vi;

// Função para pré-processar o padrão usando KMP
vi pi(const string &patt) {
    int m = patt.size();
    vi borda(m, 0);

    for (int i = 1, j = 0; i < m; i++) {
        while (j > 0 && patt[j] != patt[i])
            j = borda[j - 1];
        if (patt[i] == patt[j])
            j++;
        borda[i] = j;
    }
    return borda;
}

// Função que usa o algoritmo KMP para buscar ocorrências
pair<int, vi> kmpSearch(const string &texto, const string &patt) {
    int n = texto.size();
    int m = patt.size();
    vi borda = pi(patt);
    vi indices;
    int count = 0;

    for (int i = 0, j = 0; i < n; i++) {
        while (j > 0 && patt[j] != texto[i])
            j = borda[j - 1];
        if (texto[i] == patt[j])
            j++;
        if (j == m) {
            indices.push_back(i - m + 1); // Índice da ocorrência
            count++;
            j = borda[j - 1];
        }
    }
    return {count, indices};
}

// Função principal
int main() {
    string texto, patt;

    // Entrada
    getline(cin, texto);
    getline(cin, patt);

    // Busca usando KMP
    auto [qtd, indices] = kmpSearch(texto, patt);

    // Saída conforme especificado
    if (qtd >= 100) {
        cout << qtd << endl;
    } else {
        cout << qtd << endl;
        for (int idx : indices)
            cout << idx << endl;
    }

    return 0;
}

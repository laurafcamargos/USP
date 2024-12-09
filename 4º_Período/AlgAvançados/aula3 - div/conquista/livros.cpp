#include <bits/stdc++.h>
using namespace std;

//verifica se o valor mínimo atual é viável ou não
bool ehViavel(vector<int>& pags, int n, int m, int min) {
    int estudantes = 1;
    int soma = 0;

    for (int i = 0; i < n; i++) {
        //número atual de páginas é maior que o min?
        if (pags[i] > min)
            return false;

        if (soma + pags[i] > min) {
            estudantes++;
            soma = pags[i];

            //se o número de estudantes necessários for maior que m, retorna falso
            if (estudantes > m)
                return false;
        } else {
            soma += pags[i];
        }
    }
    return true;
}

//retorna negativo se a < b, 0 se a == b, positivo se a > b
int comparar(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

//encontra o número mínimo de páginas
int findpags(vector<int>& pags, int n, int m) {

    long long total_pags = 0;
    int max_pags = INT_MIN;

    //se o número de livros for menor que o número de estudantes é impossível
    if (n < m)
        return -1;

    //conta o total de páginas e encontra o livro com o maior número de páginas
    for (int i = 0; i < n; i++) {
        total_pags += pags[i];
        max_pags = max(max_pags, pags[i]);
    }

    //inicializa o início como o maior livro e o fim como o total de páginas
    int inicio = max_pags; 
    int fim = total_pags;
    int min = INT_MAX;

    //realiza busca binária(bisseção) para encontrar o número mínimo de páginas
    while (inicio <= fim) {
        int meio = (inicio + fim) / 2;
        if (ehViavel(pags, n, m, meio)) {
            min = meio;
            fim = meio - 1; 
        } else {
            inicio = meio + 1;
        }
    }

    return min;
}

int main() {
    int n, m;
    cin >> n >> m;
    vector<int> pags(n);

    for (int i = 0; i < n; i++) {
        cin >> pags[i];
    }

    qsort(pags.data(), n, sizeof(int), comparar);
    int min = findpags(pags, n, m);
    
    cout << min << endl;

    return 0;
}

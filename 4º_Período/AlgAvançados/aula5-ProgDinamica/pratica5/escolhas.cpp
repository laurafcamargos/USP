#include <bits/stdc++.h>
using namespace std;

int main() {
    int n;
    cin >> n;

    vector<long long> d(n+1, 0);      // Vetor para armazenar os custos de cada terno
    vector<long long> dmin(n+1, 0);   // Vetor para armazenar os custos mínimos até cada terno

    // Leitura dos custos dos ternos
    for (long long i = 1; i <= n; ++i) {
        cin >> d[i];
    }

    // Condição inicial: O custo de estar no primeiro terno é 0
    dmin[1] = 0;

    // Se houver pelo menos dois ternos, inicializamos o custo para chegar ao terno 2
    if (n > 1) {
        dmin[2] = abs(d[1] - d[2]);  // O único caminho possível é vindo do terno 1
    }

    // Processamos do terno 3 até o terno n (caso haja 3 ou mais ternos)
    for (long long i = 3; i <= n; ++i) {
        // Calculamos o custo mínimo de chegar ao terno i, vindo de i-1 ou pulando de i-2
        dmin[i] = min(dmin[i-1] + abs(d[i] - d[i-1]), dmin[i-2] + abs(d[i] - d[i-2]));
    }

    // O custo mínimo para chegar ao último terno
    cout << dmin[n] << endl;

    return 0;
}

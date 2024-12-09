#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>
#include <bitset>
using namespace std;

typedef long long ll;
typedef vector<ll> vll;

ll tamCrivo;   // capacidade de elementos no crivo
bitset<10000010> crivo; // crivo até 10^7
vll primos;

// Função para gerar os números primos até um limite utilizando o crivo de Eratóstenes
void crivoErastotenes(ll M) {
    tamCrivo = M + 1; // para acrescentar o próprio M
    crivo.set();      // todo mundo é primo
    crivo[0] = crivo[1] = 0;  // 0 e 1 não são primos

    for (ll i = 2; i <= tamCrivo; ++i) {
        if (crivo[i]) { // se i for primo, descarta todos os seus múltiplos
            for (ll j = i * i; j <= tamCrivo; j += i)
                crivo[j] = 0;
            primos.push_back(i);  // guarda i no vetor de primos
        }
    }
}

// Função para verificar se um número é primo
bool primo(ll n) {
    if (n <= tamCrivo)
        return crivo[n];   // retorna se é ou não primo em O(1)

    for (ll i = 0; i < primos.size() && primos[i] * primos[i] <= n; ++i) {
        if (n % primos[i] == 0)
            return false;
    }
    return true;
}

// Função para encontrar o próximo primo maior ou igual a x
ll acha_prox_primo(ll x) {
    if (primo(x)) return x; // se já for primo, retorna ele mesmo
    for (ll i = x + 1; i <= tamCrivo; ++i) {
        if (primo(i)) return i; // encontra o próximo primo
    }
    return x; // caso não encontre (nunca deve acontecer com o crivo grande o suficiente)
}

int main() {
    int n, m;
    cin >> n >> m;

    vector<vector<int>> matrix(n, vector<int>(m));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            cin >> matrix[i][j];
        }
    }

    // Gerar primos até um pouco acima de 10^5 usando o crivo fornecido
    ll max_value = 100000 + 1000;
    crivoErastotenes(max_value);

    // Vetores para armazenar o número de operações para transformar linhas e colunas
    vector<int> linha(n, 0);
    vector<int> coluna(m, 0);

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < m; ++j) {
            int current_value = matrix[i][j];
            if (primo(current_value)) continue; // Se já for primo, pula
            
            // Encontra o próximo primo
            int next_prime = acha_prox_primo(current_value);
            
            // Calcula os incrementos necessários
            int increment = next_prime - current_value;
            
            // Acumula os incrementos para a linha e coluna
            linha[i] += increment;
            coluna[j] += increment;
        }
    }

    int min_op = *min_element(linha.begin(), linha.end());
    min_op = min(min_op, *min_element(coluna.begin(), coluna.end()));

    cout << min_op << endl;

    return 0;
}

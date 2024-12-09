#include <bits/stdc++.h>
using namespace std;
typedef vector<int> vi;


const int MAX = 1000000;
vi divisores(MAX + 1, 0); // Vetor para armazenar a quantidade de divisores de cada número

void precomputar_divisores() {
    for (int i = 1; i <= MAX; ++i) {
        for (int j = i; j <= MAX; j += i) {
            divisores[j]++;  // Para cada múltiplo de i, i é um divisor           
        }
    }
}

int main(int argc, char const *argv[]){
    precomputar_divisores();
	int n;
	cin >> n;
    vi x(n);
	while (n--) {
        int x;
        cin >> x; 
        cout << divisores[x] << endl; 
    }
	return 0;
}
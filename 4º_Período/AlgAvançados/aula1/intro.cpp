#include <iostream>
#include <vector>
#include <map>
using namespace std;

typedef vector<int> vi;
typedef map<int, int> m;

int main() {
    int n, soma;
    cin >> n >> soma;

    vi vet(n);
    for(int i = 0; i < n; i++)
        cin >> vet[i];

    int qnt = 0;
    m contador;

    for(int i = 0; i < n; i++){    
        int comp = soma - vet[i];
        if(comp > 0) //se o complemento for positivo
            qnt += contador[comp];
        contador[vet[i]]++;
    }

    cout << qnt << endl;
    return 0;
}

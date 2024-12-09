#include <bits/stdc++.h>
using namespace std;

long int n;
vector<long long> MEMO;  

long long solveRECPD(const vector<long long>& distMax, int j) {

    if (j >= n - 1)  //já estamos no último ponto ou além
        return 0;

    if (MEMO[j] != -1)  //se já foi calculado, retorna o valor armazenado
        return MEMO[j];

    MEMO[j] = INT_MAX; 

    for (int k = 1; k <= distMax[j]; ++k) {
        if (j + k < n) {  
            MEMO[j] = min(MEMO[j], solveRECPD(distMax, j + k) + 1);
        }
    }

    return MEMO[j];  
}

int main() {
    cin >> n;

    vector<long long> distMax(n);  
    for (long int i = 0; i < n; i++) {
        cin >> distMax[i];
    }

    MEMO.assign(n, -1);

    long long resultado = solveRECPD(distMax, 0);

    if (resultado == INT_MAX) {
        cout << "Salto impossivel" << endl;
    } else {
        cout << resultado << endl;  
    }

    return 0;
}

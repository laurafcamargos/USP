#include <bits/stdc++.h>
using namespace std;


int maxPags(vector<int>& pags,vector<int>& precos, int n, int x) {
    vector<int> dp(x + 1, 0); //todos orcamentos iniciais sao 0


    for (int i = 0; i < n; i++) {
        for (int j = x; j >= precos[i]; j--) {
            dp[j] = max(dp[j], dp[j - precos[i]] + pags[i]);
        }
    }
    return dp[x];
}

int main() {
    int n, x; //num de livros e orçamento
    cin >> n >> x;
    vector<int> precos(n);
    vector<int> pags(n);

    for (int i = 0; i < n; i++) {
        cin >> precos[i];
    }
        for (int i = 0; i < n; i++) {
        cin >> pags[i];
    }

    int max = maxPags(pags,precos, n, x);
    
    cout << max << endl;

    return 0;
}
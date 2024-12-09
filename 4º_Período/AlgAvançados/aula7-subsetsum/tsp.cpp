#include <bits/stdc++.h>
using namespace std;

const int INF = 1e9;  

int n, start;
vector<vector<int>> dist;
vector<vector<int>> memo;

int tsp(int pos, int mask) {
    //se todas as cidades foram visitadas, retornamos à cidade inicial
    if (mask == (1 << n) - 1) {
        return dist[pos][start];  
    }

    
    if (memo[pos][mask] != -1) {
        return memo[pos][mask];
    }

    int ans = INF;

    for (int nxt = 0; nxt < n; nxt++) {
        //se a cidade nxt ainda não foi visitada
        if (!(mask & (1 << nxt))) {
            ans = min(ans, dist[pos][nxt] + tsp(nxt, mask | (1 << nxt))); //regra geral
        }
    }

    return memo[pos][mask] = ans;
}

int main() {
    cin >> n;

    cin >> start;

    dist.resize(n, vector<int>(n));

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cin >> dist[i][j];
        }
    }

    memo.assign(n, vector<int>(1 << n, -1));

    //chama a função a partir da cidade inicial com apenas ela visitada (bitmask = 1 << start)
    int result = tsp(start, 1 << start);

    cout << result << endl;

    return 0;
}

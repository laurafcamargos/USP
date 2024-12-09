#include <iostream>
#include <vector>
using namespace std;

const int MOD = 1e9 + 7;

int caminhos(int n, vector<string>& grid) {
    vector<vector<int>> dp(n, vector<int>(n, 0));
    
    if (grid[0][0] == '.') {
        dp[0][0] = 1;
    }
    
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            if (grid[i][j] == '*') {
                dp[i][j] = 0; //bbstáculo
            } else {
                if (i > 0) {
                    dp[i][j] = (dp[i][j] + dp[i-1][j]) % MOD; // Cima
                }
                if (j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i][j-1]) % MOD; // Esquerda
                }
                if (i > 0 && j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i-1][j-1]) % MOD; // Diagonal
                }
            }
        }
    }
    
    return dp[n-1][n-1];
}

int main() {
    int n;
    cin >> n;
    vector<string> grid(n);
    
    for (int i = 0; i < n; ++i) {
        cin >> grid[i];
    }

    cout << caminhos(n, grid) << endl;

    return 0;
}

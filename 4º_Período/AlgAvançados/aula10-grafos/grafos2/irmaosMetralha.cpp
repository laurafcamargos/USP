#include <iostream>
#include <vector>
#include <stack>
#include <algorithm>
using namespace std;

const int MAXN = 100005;

vector<int> graph[MAXN], rev_graph[MAXN];
vector<vector<int>> scc_graph; 
vector<long long> fortune, scc_fortune;
vector<int> scc_id(MAXN, -1);
vector<bool> visited(MAXN);
stack<int> finish_order;
int scc_count = 0;

// Kosaraju's algorithm - Step 1: Normal DFS to get finish order
void dfs1(int u) {
    visited[u] = true;
    for (int v : graph[u]) {
        if (!visited[v]) {
            dfs1(v);
        }
    }
    finish_order.push(u);
}

// Kosaraju's algorithm - Step 2: Transposed DFS to find SCCs
void dfs2(int u) {
    visited[u] = true;
    scc_id[u] = scc_count;
    scc_fortune[scc_count] += fortune[u];
    for (int v : rev_graph[u]) {
        if (!visited[v]) {
            dfs2(v);
        }
    }
}

// DFS on DAG to compute max path sum
void computeDP(int u, vector<long long>& dp) {
    dp[u] = scc_fortune[u]; // Inicializa com a fortuna da SCC atual
    for (int v : scc_graph[u]) {
        if (dp[v] == -1) { // Se não foi calculado, chama recursivamente
            computeDP(v, dp);
        }
        dp[u] = max(dp[u], dp[v] + scc_fortune[u]); // Atualiza o valor máximo
    }
}

int main() {
    int n, m;
    cin >> n >> m;

    fortune.resize(n);
    for (int i = 0; i < n; i++) {
        cin >> fortune[i];
    }

    for (int i = 0; i < m; i++) {
        int a, b;
        cin >> a >> b;
        a--; b--; // Ajusta para índices baseados em 0
        graph[a].push_back(b);
        rev_graph[b].push_back(a); // Grafo transposto
    }

    // Step 1: Kosaraju's Algorithm - First DFS to compute finish order
    fill(visited.begin(), visited.end(), false);
    for (int i = 0; i < n; i++) {
        if (!visited[i]) {
            dfs1(i);
        }
    }

    // Step 2: Kosaraju's Algorithm - Second DFS to identify SCCs
    fill(visited.begin(), visited.end(), false);
    scc_fortune.assign(n, 0); // Inicializa a fortuna acumulada das SCCs
    while (!finish_order.empty()) {
        int u = finish_order.top();
        finish_order.pop();
        if (!visited[u]) {
            dfs2(u);
            scc_count++;
        }
    }

    // Step 3: Build the DAG
    scc_graph.resize(scc_count); // Inicializa o grafo condensado
    for (int u = 0; u < n; u++) {
        for (int v : graph[u]) {
            int scc_u = scc_id[u];
            int scc_v = scc_id[v];
            if (scc_u != scc_v) {
                scc_graph[scc_u].push_back(scc_v);
            }
        }
    }

    // Step 4: DFS to Compute DP
    vector<long long> dp(scc_count, -1); // Inicializa o vetor DP com -1 (não calculado)
    long long max_fortune = 0;

    for (int i = 0; i < scc_count; i++) {
        if (dp[i] == -1) { // Se o nó ainda não foi visitado
            computeDP(i, dp);
        }
        max_fortune = max(max_fortune, dp[i]); // Atualiza o valor máximo
    }

    cout << max_fortune << endl;

    return 0;
}

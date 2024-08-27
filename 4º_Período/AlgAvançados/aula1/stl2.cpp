#include <iostream>
#include <queue>
#include <vector>
using namespace std;

struct myComp {
    bool operator()(pair<int, int> const& a, pair<int, int> const& b) const noexcept {
        if (a.second == b.second) {
            return a.first > b.first;  // menor ID primeiro se as durações forem iguais
        }
        return a.second > b.second;    // menor duração primeiro
    }
};

int main() {
    int n, K, id, duracao;
    string query;
    cin >> n;
    
    vector<int> duracoes(3001); //vetor pra guardar os anos 

    priority_queue<pair<int, int>, vector<pair<int, int>>, myComp> fila;

    for (int i = 0; i < n; i++) {
        cin >> query >> id >> duracao;
        
        if (query == "query") {
            fila.push(make_pair(id, duracao));
            duracoes[id] = duracao;
        }
    }
    
    cin >> K;

    for(int i = 0; i < K; i++) {
        pair<int, int> top = fila.top();
        fila.pop(); //tira o topo
        cout << top.first << endl; 
        int duracao_nova = top.second + duracoes[top.first]; //duracao nova = duracao atual + duracao do que tava no topo
        fila.push(make_pair(top.first, duracao_nova));
    }

    return 0;
}

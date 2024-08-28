//a duração da tarefa é o que importa, começar pela tarefa que tem a menor
//vale a pena olhar pra diferença entre a duração das tarefas e nao pro deadline

#include <bits/stdc++.h>
using namespace std;


int limparVetor(int n, const vector<int>& vetor) {
    vector<int> pos(n + 1);
    
    // coloca no vetor a posição de cada número
    for (int i = 0; i < n; ++i) {
        pos[vetor[i]] = i;
    }

    int trocas = 1;  //a primeira rodada sempre acontece
    for (int i = 2; i <= n; ++i) {
        //se o número anterior está numa posição maior, significa que a sequência foi quebrada
        if (pos[i] < pos[i - 1]) { //vai percorrendo o vetor da direta pra esquerda
            trocas++;
        }
    }

    return trocas;
}

int main() {
    int n;
    cin >> n;
    vector<int> vetor(n);
    
    for (int i = 0; i < n; ++i) {
        cin >> vetor[i];
    }
    
    cout << limparVetor(n, vetor) << endl;
    
    return 0;
}


//limpeza do vetor
//guloso: vetor de indice e contar quantos ta atras e depois do 1
//nao precisa ordenar
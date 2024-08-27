//a duração da tarefa é o que importa, começar pela tarefa que tem a menor
//vale a pena olhar pra diferença entre a duração das tarefas e nao pro deadline

#include <bits/stdc++.h>
using namespace std;

struct Tarefa {
    int duracao;
    int tempo_limite;
};

// Função para ordenar as tarefas pela duração (menor para maior)
bool compare(const Tarefa& a, const Tarefa& b) {
    return a.duracao < b.duracao;
}

long long calcularCustoMaximo(vector<Tarefa>& tarefas) {
    // Ordena as tarefas pela duração
    sort(tarefas.begin(), tarefas.end(), compare);

    long long tempo_atual = 0; //caso 7 deu errado pq tava usando int
    long long custo_total = 0;

    // Calcula o custo acumulado ao longo da execução das tarefas
    for (const auto& tarefa : tarefas) {
        tempo_atual += tarefa.duracao;  // Atualiza o tempo atual com a duração da tarefa
        long long custo = tarefa.tempo_limite - tempo_atual;  // Cálculo do custo da tarefa
        
        // Se o custo for negativo, acumula normalmente
        custo_total += custo;
    }

    return custo_total;
}

int main() {
    int n;
    cin >> n;

    vector<Tarefa> tarefas(n);

    // Leitura das tarefas
    for (int i = 0; i < n; i++) {
        cin >> tarefas[i].duracao >> tarefas[i].tempo_limite;
    }

    // Chama a função para calcular o custo máximo
    long long custo_maximo = calcularCustoMaximo(tarefas);
    
    // Exibe o custo máximo (pode ser negativo)
    cout << custo_maximo << endl;

    return 0;
}

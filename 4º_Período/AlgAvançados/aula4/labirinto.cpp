#include <bits/stdc++.h>
using namespace std;

#define MAX 20 

typedef struct {
    int linha;
    int coluna;
} Move;

void labirinto(int M[MAX][MAX], Move move[], int Li, int Ci, int Lf, int Cf, int *min, int *qtd_caminhos) {
    int L, C;
    
    //se a posição atual for a posição final (objetivo)
    if ((Li == Lf) && (Ci == Cf)) {
        if (M[Lf][Cf] < *min) {
            *min = M[Li][Ci];  //atualiza a menor distância
        }
        (*qtd_caminhos)++;  // Incrementa o número de caminhos encontrados
    } else {
        //testa todos os 4 movimentos possíveis (cima, baixo, esquerda, direita)
        for (int i = 0; i < 4; i++) {
            L = Li + move[i].linha;  // Atualiza a linha para o próximo movimento
            C = Ci + move[i].coluna; // Atualiza a coluna para o próximo movimento

            // Verifica se o movimento está dentro dos limites do labirinto
            if (L >= 0 && L < MAX && C >= 0 && C < MAX && M[L][C] == -1) {
                //marca a célula como visitada com a nova distância
                M[L][C] = M[Li][Ci] + 1;
                labirinto(M, move, L, C, Lf, Cf, min, qtd_caminhos);

                //desmarca a célula após o retorno da recursão para permitir outros caminhos
                M[L][C] = -1;
            }
        }
    }
}

int main() {
    int M, N;
    cin >> M >> N;
    int matriz[MAX][MAX];
    
    //-1 representa célula livre
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            matriz[i][j] = -1;  
        }
    }
    int x, y; //obstaculos = 1
    while (cin >> x >> y) {
        matriz[x][y] = 1;  
    }

    //cima, baixo, esquerda, direita
    Move move[4] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    int Li = 0, Ci = 0, Lf = M - 1, Cf = N - 1;
    int min_dist = INT_MAX;
    int qtd_caminhos = 0;

    matriz[Li][Ci] = 0;  //ponto inicial com distância 0
    labirinto(matriz, move, Li, Ci, Lf, Cf, &min_dist, &qtd_caminhos);

    cout << qtd_caminhos << " " << min_dist << endl;

    return 0;
}

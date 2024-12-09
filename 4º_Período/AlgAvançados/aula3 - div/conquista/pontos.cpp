#include <bits/stdc++.h>
using namespace std;
 
//representa um ponto no plano
struct Ponto {
    int x, y;
};

//auxilia na ordenação dos pontos de acordo com a coordenada X
int compararX(const void* a, const void* b) {
    Ponto *p1 = (Ponto *)a, *p2 = (Ponto *)b; //ponteiros que apontam para os dois pontos a serem comparados
    return (p1->x - p2->x);
}

//auxilia na ordenação dos pontos de acordo com a coordenada Y
int compararY(const void* a, const void* b) {
    Ponto *p1 = (Ponto *)a, *p2 = (Ponto *)b;
    return (p1->y - p2->y);
}

//função euclidiana para encontrar a distância entre dois pontos
float distancia(Ponto p1, Ponto p2) {
    return sqrt((p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y));
}

//método de força bruta para retornar a menor distância entre dois pontos em P[] de tamanho n
float forcaBruta(Ponto P[], int n) {
    float min = FLT_MAX; //maior valor que posso representar

    for (int i = 0; i < n; ++i)
        for (int j = i + 1; j < n; ++j)
            if (distancia(P[i], P[j]) < min)
                min = distancia(P[i], P[j]);
    return min;
}

//encontrar o mínimo entre dois valores float
float minimo(float x, float y) {
    return (x < y)? x : y;
}

//encontra a menor distância entre ponos que estão em metades diferentes, mas prox a linha que divide
float faixaMaisProxima(Ponto faixa[], int tamanho, float d) {
    float min = d; //inicializa a distância mínima como d
 
    qsort(faixa, tamanho, sizeof(Ponto), compararY); //reduz comparações
 
    //pega todos os pontos um por um e tenta os próximos pontos até que a diferença
    // entre as coordenadas y seja menor que d.
    for (int i = 0; i < tamanho; ++i)
        for (int j = i + 1; j < tamanho && (faixa[j].y - faixa[i].y) < min; ++j)
            if (distancia(faixa[i], faixa[j]) < min)
                min = distancia(faixa[i], faixa[j]);
    //na prática o loop interno roda no máximo 6 vezes para cada iteração do loop externo(prop. geom.)
    return min;
}

//função recursiva para encontrar a menor distância
float menorDistRecursiva(Ponto P[], int n) {
    if (n <= 3)
        return forcaBruta(P, n);
 
    int meio = n / 2;
    Ponto ponto_medio = P[meio];
 
    float d_esq = menorDistRecursiva(P, meio); //recursivo pra esquerda
    float d_dir = menorDistRecursiva(P + meio, n - meio); //recursivo pra direita
 
    float d = minimo(d_esq, d_dir); //menor valor entre as duas menores distâncias encontradas
 
    Ponto faixa[n]; //pontos cuja coordenada X está dentro de d da linha divisória
    int j = 0;
    for (int i = 0; i < n; i++)
        if (abs(P[i].x - ponto_medio.x) < d) {
            faixa[j] = P[i];
            j++;
        }
    return minimo(d, faixaMaisProxima(faixa, j, d));
}

//função principal que encontra a menor distância
float maisProxima(Ponto P[], int n) {
    qsort(P, n, sizeof(Ponto), compararX);
    return menorDistRecursiva(P, n);
}

int main() {
    int n;
    cin >> n; //num de pontos

    Ponto P[n];
    
    //pontos da entrada
    for (int i = 0; i < n; i++) {
        cin >> P[i].x >> P[i].y;
    }

    printf("%.2f\n", maisProxima(P, n));
    
    return 0;
}

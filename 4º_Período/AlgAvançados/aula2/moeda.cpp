#include <bits/stdc++.h>
using namespace std;

//complexidade com programação dinâmica é o(n.v) -> depender de V é um problema 
//força bruta com memória = PD, testa todas as soluções
int V = 6;
int moedas[3] = {1,3,4};

int solve(int V);
int main (int argc, char const *argv[]) {

    printf("o numero min de moedas eh %d\n", solve(V));
    return 0;

}

int solve (int V) {
    if (V ==0) {
        return 0;
    }

    int minimo = INT_MAX;
    for(int i =0 ; i< 3;i++){
        if(V-moedas[i] >= 0)
            minimo = min(minimo, solve(V-moedas[i])+1);

    }
    return minimo;
    
}



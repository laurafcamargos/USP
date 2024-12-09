/*

Para fatorar um nro em fatores primos, vamos usar o Crivo para
o vetor de primos (que pode ser integer), por que o maior valor
será sempre da ordem de raiz(N).

e a complexidade (lembrando do teorema de nros primos diz que a qtd de 
primos <= M está limitado a O(N/ln(N)-1)) será de O(N/ln(raiz(N)))
*/

#include <iostream>
#include <cstdio>
#include <bitset>
#include <vector>
#include <map>

using namespace std;

typedef long long ll;
typedef vector<int> vi;
typedef vector<ll> vll;
typedef map<int, int> mii;

ll tamCrivo;   // capacidade de elementos no crivo


bitset<10000010> crivo; // vamos fazer um crivo até 10^7 !!!
vi primos;

void crivoErastotenes(ll M){
	tamCrivo = M+1; // para acrescentar o proprio M
	crivo.set();      // todo mundo é primo

	crivo[0] = crivo[1] = 0;  // 0 e 1 nao sao primos..

	for (ll i = 2; i <= tamCrivo; ++i){
		if (crivo[i]){           // se i for primo, descarta todos os seus multiplos
			for (ll j = i*i; j <= tamCrivo; j += i)
				crivo[j]=0;
			primos.push_back((int)i);  // guarda i no vetor de primos
		}
	}
}


vi fatoresPrimos(ll N){
	vi fatores;

	for (int i = 0, fp = primos[i]; fp*fp <=N; i++, fp = primos[i]){
		while (N % fp == 0){
			N = N/fp;
			fatores.push_back(fp);
		}
	}

	// se N for primo, nada acima acontece
	if (N != 1)
		fatores.push_back(N);

	return fatores;
}


mii fatoresPrimosMap(ll N){
	mii fatMap;

	for (int i = 0, fp = primos[i]; fp*fp <=N; i++, fp = primos[i]){
		while (N % fp == 0){
			N = N/fp;
			fatMap[fp]++;
		}
	}

	// se N for primo, nada acima acontece
	if (N != 1)
		fatMap[N] = 1;

	return fatMap;
}


int main(int argc, char const *argv[]){
	
	crivoErastotenes(10000000);

	printf("quantidade de fatores primos = %ld\n", primos.size());

	ll n;
	cin >> n;

	vi fatores = fatoresPrimos(n);

	for (int i = 0; i < fatores.size(); ++i){
		printf("%d * ", fatores[i]);
	}
	printf("\n");




	mii fatMap = fatoresPrimosMap(n);

	for (auto i : fatMap)   
		printf("(%d,%d) * ", i.first, i.second);
	printf("\n");

	
	return 0;
}
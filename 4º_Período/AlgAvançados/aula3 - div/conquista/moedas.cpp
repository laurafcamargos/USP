#include <iostream>
#include <cstdio>
#include <climits>
#include <vector>
#include <cstring>

using namespace std;

#define INF INT_MAX
#define MAX 10000
#define M 3

//vi moedas(3) = {1,3,4};
int moedas[M] = {1,3,4};

int MEMO[MAX];


void printMEMO(int *vet, int TAM){
	for (int i = 0; i <= TAM; ++i)
		cout << vet[i] << " ";
	cout << endl;
}

int solve(int x){
	if (x == 0)
		return 0;
	if (x < 0)
		return INF-1;
	int minimo = INF;
	// seleciona das n moedas aquela que minimiza !
	for (int i = 0; i < M; ++i){
		minimo = min(solve(x-moedas[i])+1, minimo);
	}
	return minimo;
}

int solve2(int x){
	if (x == 0)
		return 0;
	//if (x < 0)
	//	return INF-1;
	int minimo = INF;
	// seleciona das n moedas aquela que minimiza !
	for (int i = 0; i < M; ++i){
		if (x >= moedas[i])
			minimo = min(solve2(x-moedas[i])+1, minimo);
	}
	return minimo;
}

int solveRecPD(int x){
	if (x == 0)
		return (MEMO[0] = 0);
	if (MEMO[x] != -1)
		return MEMO[x];
	MEMO[x] = INF;
	// seleciona das n moedas aquela que minimiza !
	for (int i = 0; i < M; ++i){
		if (x >= moedas[i])
			MEMO[x] = min(solveRecPD(x-moedas[i])+1, MEMO[x]);
	}
	return MEMO[x];
}


int solvePD(int V){
	
	int MEMO[MAX];
	MEMO[0] = 0;

	// para todos os valores possíveis, a partir de 1 !!
	for (int x = 1; x <= V; ++x){
		MEMO[x] = INF;
		// seleciona das n moedas aquela que minimiza !
		for (int i = 0; i < M; ++i){
			if (x >= moedas[i])
				MEMO[x] = min(MEMO[x-moedas[i]]+1, MEMO[x]);
		}
	}
	printMEMO(MEMO, V);
	return MEMO[V];
}



int main(int argc, char const *argv[])
{
	
	int V;

	cin >> V;

	//cout << solve2(V) << endl;

	memset(MEMO, -1, sizeof(MEMO));
	cout << solveRecPD(V) << endl;
	printMEMO(MEMO, V);

	cout << solvePD(V) << endl;

	//printMEMO(MEMO, V);

	return 0;
}
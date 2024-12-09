#include <iostream>
#include <cstdio>
#include <vector>

using namespace std;

typedef vector<int> vi;

int N;
vi Prox;
vi V;

vi MEMO;

int solveREC(int j){
	if (j == 0)
		return 0;
	// retorna o maximo entre nao estar e estar presente na solucao..
	else return max(solveREC(j-1), solveREC(Prox[j])+V[j]);

}


int solveRECPD(int j){
	if (j == 0)
		return 0;
	if (MEMO[j] != -1)
		return MEMO[j];
	// retorna o maximo entre nao estar e estar presente na solucao..
	MEMO[j] =  max(solveRECPD(j-1), solveRECPD(Prox[j])+V[j]);
	return MEMO[j];

}

int solvePD(){
	MEMO[0] = 0;
	for (int j = 1; j <= N; ++j){
		// retorna o maximo entre nao estar e estar presente na solucao..
		MEMO[j] =  max(MEMO[j-1], MEMO[Prox[j]]+V[j]);
	}
	
	return MEMO[N];

}

int main(int argc, char const *argv[])
{
	cin >> N;
	V.assign(N+1,0);
	Prox.assign(N+1,0);

	for (int i = 0; i <=N; ++i)
		cin >> V[i];
	for (int i = 0; i <=N; ++i)
		cin >> Prox[i];

	cout << solveREC(N) << endl;

	MEMO.assign(N+1, -1);
	//cout << solveRECPD(N) << endl;
	cout << solvePD() << endl;


	return 0;
}
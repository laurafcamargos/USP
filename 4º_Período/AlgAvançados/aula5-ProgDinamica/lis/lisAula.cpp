#include <iostream>
#include <cstdio>
#include <cstring>

#define MAX 10000

using namespace std;


int n;
int A[MAX];
int MEMO[MAX];


int lisREC(int i){
	if (i == 0)
		return 1;
	// para todo j menor que i, pega o lis max...
	int maior = 1;
	for (int j = i-1; j >=0; j--){
		//int res = lisREC(j);
		if (A[j] < A[i])
			maior = max(lisREC(j)+1, maior);
	}

	return maior;

}

int lisREC2(int i, int &maxlis){
	if (i == 0)
		return 1;
	// para todo j menor que i, pega o lis max...
	int maior = 1;
	for (int j = i-1; j >=0; j--){
		// calcula o lis para cada j, regardless!
		int res = lisREC2(j, maxlis);
		if (A[j] < A[i])
			maior = max(res+1, maior);
	}

	if (maior > maxlis)
		maxlis = maior;

	return maior;

}


int lisREC2PD(int i, int &maxlis){
	if (i == 0)
		return 1;
	if (MEMO[i] != -1)
		return MEMO[i];

	// para todo j menor que i, pega o lis max...
	int maior = 1;
	for (int j = i-1; j >=0; j--){
		int res = lisREC2PD(j, maxlis);
		if (A[j] < A[i])
			maior = max(res+1, maior);
	}

	MEMO[i] = maior;

	if (maior > maxlis)
		maxlis = maior;

	return MEMO[i];

}


int lisPD(){

	MEMO[0] = 1;
	int maxlis = 1;
	
	// PARA TODOS I's.....
	for (int i = 1; i <n; ++i) {
		// para todo j menor que i, pega o lis max...
		int maior = 1;
		for (int j = i-1; j >=0; j--){
			if (A[j] < A[i])
				maior = max(MEMO[j]+1, maior);
		}
		MEMO[i] = maior;
		if (maior > maxlis)
			maxlis = maior;
	}

	return maxlis;

}



int main(int argc, char const *argv[])
{
	cin >> n;
	for (int i = 0; i < n; ++i)
		cin >> A[i];

	printf("O LIS REC ERRADO= %d\n", lisREC(n-1));
	int maxlis = 1;
	lisREC2(n-1, maxlis);
	printf("O LIS REC CORRETO= %d\n", maxlis);

	maxlis = 1;
	memset(MEMO, -1, sizeof(MEMO));
	lisREC2PD(n-1, maxlis);
	printf("O LIS REC PD= %d\n", maxlis);

	
	printf("O LIS PD= %d\n", lisPD());




	return 0;
}
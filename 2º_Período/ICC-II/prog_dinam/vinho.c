#include<stdio.h>
#include<stdlib.h>

int vinho_aux(int ***cache, int *toneis, int ano, int e, int d) {
	if (cache[ano][e][d] == -1) {
		int res;
		if (e > d) {
			res = 0;
		} else {
			int ve = toneis[e] * ano + vinho_aux(cache, toneis, ano + 1, e + 1, d);
			int vd = toneis[d] * ano + vinho_aux(cache, toneis, ano + 1, e, d - 1);
			if (ve > vd) {
				res = ve;
			} else {
				res = vd;
			}
		}
		cache[ano][e][d] = res;
	}
	return cache[ano][e][d];
}

int vinho(int *toneis, int n) {
	int ***cache = (int ***)malloc(sizeof(int **) * (n + 2));
	for (int i = 0; i < n + 2; i++) {
		cache[i] = (int **) malloc(sizeof(int *) * (n + 1));
		for (int j = 0; j < n + 1; j++) {
			cache[i][j] = (int *) malloc(sizeof(int) * (n + 1));
			for (int k = 0; k < n + 1; k++) {
				cache[i][j][k] = -1;
			}
		}
	}
	int res = vinho_aux(cache, toneis, 1, 0, n - 1);
	for (int i = 0; i < n + 2; i++) {
		for (int j = 0; j < n + 1; j++) {
			free(cache[i][j]);
		}
		free(cache[i]);
	}
	free(cache);
	return res;
}

int main(int argc, char *argv[]) {
	int n;
	scanf("%d", &n);
	int toneis[n];
	for(int i = 0; i < n; i++) {
		scanf("%d", &toneis[i]);
	}
	
	int valor = vinho(toneis, n);
	printf("Valor maximo Ã© %d\n", valor);
}
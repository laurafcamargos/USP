#include<stdio.h>

#define MAXNOME 128
#define MAXDEPS 10
#define MAXVENDAS 50

typedef struct Vendedor {
	char nome[MAXNOME];
	char cpf[11];
	struct {
		int ano;
		int mes;
		int dia;
	} nascimento;
	char uf[3];
	int numDeps;
	int dependentes[MAXDEPS];
	int numVendas;
	int vendas[MAXVENDAS];
} Vendedor;

void processa(Vendedor vs[], int n) {
	for (int i = 0; i < n; i++) {
		int m = i;
		int dm = 0;
		for (int k = 0; k < vs[i].numDeps; k++) {
			if (vs[i].dependentes[k] < 10) {
				dm++;
			}
		}
		for (int j = i + 1; j < n; j++) {
			int dj = 0;
			for (int k = 0; k < vs[j].numDeps; k++) {
				if (vs[j].dependentes[k] < 10) {
					dj++;
				}
			}
			if (dj > dm) {
				m = j;
				dm = dj;
			}
		}
		Vendedor tmp = vs[m];
		vs[m] = vs[i];
		vs[i] = tmp;
	}
	for (int i = 0; i < 5; i++) {
		int m = i;
		int dm = 0;
		for (int k = 0; k < vs[i].numVendas; k++) {
			dm += vs[i].vendas[k];
		}
		for (int j = i + 1; j < 5; j++) {
			int dj = 0;
			for (int k = 0; k < vs[j].numVendas; k++) {
				dj += vs[j].vendas[k];
			}
			if (dj < dm) {
				m = j;
				dm = dj;
			}
		}
		Vendedor tmp = vs[m];
		vs[m] = vs[i];
		vs[i] = tmp;
	}
	for (int i = 0; i < 3; i++) {
		int s = 0;
		for (int k = 0; k < 3; k++) {
			int m = k;
			for (int j = k + 1; j < vs[i].numVendas; j++) {
				if (vs[i].vendas[j] < vs[i].vendas[m]) {
					m = i;
				}
			}
			int tmp = vs[i].vendas[m];
			vs[i].vendas[m] = vs[i].vendas[k];
			vs[i].vendas[k] = tmp;
			s += m;
		}
		printf("(%s, %s, %d) ", vs[i].nome, vs[i].uf, s);
	}
}


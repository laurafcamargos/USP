#include<stdlib.h>
#include<stdio.h>

struct Aluno {
	char nome[128];
	int curso;
	int ano;
	int mes;
	int dia;
	float n1;
	float n2;
	float n3;
};

typedef int (*FtnTestaAluno)(struct Aluno *);
typedef int (*FtnComparaAluno)(struct Aluno *, struct Aluno *);

void printAluno(struct Aluno *a) {
	printf("Nome: %s\nCurso: %d\nNascimento: %d/%d/%d\nNotas: %f, %f, %f\n\n", a->nome, a->curso, a->dia, a->mes, a->ano, a->n1, a->n2, a->n3);
}

void printAlunos_old(struct Aluno alunos[], int n, int test) {
	for (int i = 0; i < n; i++) {
		int cnd = 0;
		switch(test) {
			case 0:
				cnd = 1;
			break;
			case 1:
				cnd = (alunos[i].curso == 0);
			break;
			case 2:
				cnd = (alunos[i].n1 > 8.0);
			break;
			case 3:
				cnd = (alunos[i].ano < 1980);
			break;
		}
		if (cnd) {
			printAluno(&alunos[i]);
		}
	}
	printf("\n");
}

void printAlunos(struct Aluno alunos[], int n, FtnTestaAluno test) {
	for (int i = 0; i < n; i++) {
		if (test(&alunos[i])) {
			printAluno(&alunos[i]);
		}
	}
	printf("\n");
}

int aceitaTodos(struct Aluno *a) {
	return 1;
}

int aceitaCurso0(struct Aluno *a) {
	return a->curso == 0;
}

int aceitaN1Maior8(struct Aluno *a) {
	return a->n1 > 8.0;
}

int aceitaVelho(struct Aluno *a) {
	return a->ano < 1980;
}

int aceita5Bola(struct Aluno *a) {
	return a->n1 == 5.0 || a->n2 == 5.0 || a->n3 == 5.0;
}

void printTodosAlunos(struct Aluno alunos[], int n) {
	for (int i = 0; i < n; i++) {
		if (1) {
		  printAluno(&alunos[i]);
		}
	}
	printf("\n");
}

void printAlunosCursoZero(struct Aluno alunos[], int n) {
	for (int i = 0; i < n; i++) {
		if (alunos[i].curso == 0) {
		  printAluno(&alunos[i]);
		}
	}
	printf("\n");
}

void printAlunosComMaisQue8NaPrimeiraProva(struct Aluno alunos[], int n) {
	for (int i = 0; i < n; i++) {
		if (alunos[i].n1 > 8.0) {
		  printAluno(&alunos[i]);
		}
	}
	printf("\n");
}

void bubble(struct Aluno *a, int n, FtnComparaAluno cmp) {
	for(int i = n - 1; i > 0; i--) {
		for(int j = 0 ; j < i; j++) {
			if (cmp(&a[j], &a[j+1])) {
				struct Aluno tmp = a[j];
				a[j] = a[j+1];
				a[j+1] = tmp;
			}
		}
	}
}

int maiorN1(struct Aluno *a1, struct Aluno *a2) {
	return a1->n1 > a2->n2;
}

int max_old(struct Aluno *alunos, int n, FtnComparaAluno cmp) {
	int m = 0;
	for(int i = 1; (i < n); i++) {
		if (cmp(&alunos[i], &alunos[m])) {
			m = i;
		}
	}
	return m;
}

int max_rec(struct Aluno *alunos, int m, int i, int n, FtnComparaAluno cmp) {
	if (!(i < n)) {
		return m;
	}
	if (cmp(&alunos[i], &alunos[m])) {
		return max_rec(alunos, i, i + 1, n, cmp);
	} else {
    return max_rec(alunos, m, i + 1, n, cmp);
	}
}

int max(struct Aluno *alunos, int n, FtnComparaAluno cmp) {
	return max_rec(alunos, 0, 0, n, cmp);
}

void main(int argc, char *argv[]) {
	struct Aluno alunos[] = {
		{"Adenilso", 0, 1976, 2, 28, 10.0, 9.8, 9.1},
		{"Adilson", 1, 1985, 7, 13, 7.2, 5.0, 8.2},
		{"Pedro", 1, 1999, 3, 12, 8.1, 9.2, 6.0},
		{"Joao", 0, 1988, 5, 13, 9.1, 9.3, 9.4},
	};

	FtnTestaAluno testes[] = {
		aceitaTodos,
		aceitaCurso0,
		aceitaN1Maior8,
		aceitaVelho,
		aceita5Bola
	};
	for(int i = 0; i < 5; i++) {
		printAlunos(alunos, 4, testes[i]);
	}

	bubble(alunos, 4, maiorN1);
	//bubble(alunos, 4, alfabetica);

	int m = max(alunos, 4, maiorN1);
}

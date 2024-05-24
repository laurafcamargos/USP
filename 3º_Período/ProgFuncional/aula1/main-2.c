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

typedef int (*FtnTestAluno)(struct Aluno *);
typedef void (*FtnAcaoAluno)(struct Aluno *);
typedef void (*FtnFinaliza)();
typedef int (*FtnComparaAluno)(struct Aluno *, struct Aluno *);

void printAlunos_old(struct Aluno *alunos, int n, int test) {
	for(int i = 0; i < 6; i++) {
		int cnd = 0;
		switch(test) {
			case 0:
				cnd = (1);
			break;
			case 1:
				cnd = (alunos[i].curso == 1);
			break;
			case 2:
			  cnd = (alunos[i].ano < 1990);
			break;
			case 3:
				cnd = (alunos[i].n1 == 5.0 || alunos[i].n2 == 5.0 || alunos[i].n3 == 5.0);
			break;
		}
		if (cnd) {
			printf("Nome: %s\nCurso: %d\nNascimento: %d/%d/%d\nNotas: %f, %f, %f\n\n", alunos[i].nome, alunos[i].curso, alunos[i].dia, alunos[i].mes, alunos[i].ano, alunos[i].n1, alunos[i].n2, alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAluno(struct Aluno *a) {
	printf("Nome: %s\nCurso: %d\nNascimento: %d/%d/%d\nNotas: %f, %f, %f\n\n", a->nome, a->curso, a->dia, a->mes, a->ano, a->n1, a->n2, a->n3);
}

void transferTo2(struct Aluno *a) {
	a->curso = 2;
}

void printBarras() {
	printf("=====\n");
}

void noop() {
}

void transfer0to2(struct Aluno *alunos, int n, FtnTestAluno test) {
	for (int i = 0; i < n; i++) {
		if (test(&alunos[i])) {
			alunos[i].curso = 2;
		}
	}
}

void printAlunos(struct Aluno *alunos, int n, FtnTestAluno test) {
	for(int i = 0; i < n; i++) {
		if (test(&alunos[i])) {
			printAluno(&alunos[i]);
		}
	}
	printf("=====\n");
}

void processaAlunos(struct Aluno *alunos, int n, FtnTestAluno test, FtnAcaoAluno acao, FtnFinaliza final) {
	for(int i = 0; i < n; i++) {
		if (test(&alunos[i])) {
			acao(&alunos[i]);
		}
	}
	final();
}

int aceitaTodos(struct Aluno *a) {
	return 1;
}

int aceitaCurso1(struct Aluno *a) {
	return (a->curso == 1);
}

int aceitaCurso0(struct Aluno *a) {
	return (a->curso == 0);
}

int aceitaAlunoVelho(struct Aluno *a) {
	return (a->ano < 1990);
}

int aceita5Bola(struct Aluno *a) {
	return (a->n1 == 5.0 || a->n2 == 5.0 || a->n3 == 5.0);
}

int aceita5BolaN1(struct Aluno *a) {
	return (a->n1 == 5.0);
}

void transferTo3(struct Aluno *a) {
	a->curso = 3;
}

void printAlunosTodos(struct Aluno *alunos, int n) {
	for(int i = 0; i < 6; i++) {
		if (1) {
			printf("Nome: %s\nCurso: %d\nNascimento: %d/%d/%d\nNotas: %f, %f, %f\n\n", alunos[i].nome, alunos[i].curso, alunos[i].dia, alunos[i].mes, alunos[i].ano, alunos[i].n1, alunos[i].n2, alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAlunosCurso1(struct Aluno *alunos, int n) {
	for(int i = 0; i < 6; i++) {
		if (alunos[i].curso == 1) {
			printf("Nome: %s\nCurso: %d\nNascimento: %d/%d/%d\nNotas: %f, %f, %f\n\n", alunos[i].nome, alunos[i].curso, alunos[i].dia, alunos[i].mes, alunos[i].ano, alunos[i].n1, alunos[i].n2, alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAlunosVelhos(struct Aluno *alunos, int n) {
	for(int i = 0; i < 6; i++) {
		if (alunos[i].ano < 1990) {
			printf("Nome: %s\nCurso: %d\nNascimento: %d/%d/%d\nNotas: %f, %f, %f\n\n", alunos[i].nome, alunos[i].curso, alunos[i].dia, alunos[i].mes, alunos[i].ano, alunos[i].n1, alunos[i].n2, alunos[i].n3);
		}
	}
	printf("=====\n");
}

void bubble(struct Aluno *alunos, int n, FtnComparaAluno cmp) {
	for(int i = n - 1; i >= 0; i--) {
		for(int j = 0; j < i; j++) {
			if (cmp(&alunos[j], &alunos[j+1])) {
				struct Aluno tmp = alunos[j];
				alunos[j] = alunos[j+1];
				alunos[j+1] = tmp;
			}
		}
	}
}

int max_old(struct Aluno *alunos, int n, FtnComparaAluno cmp) {
	int m = 0;
	for(int i = 0; i < n; i++) {
		if (cmp(&alunos[i], &alunos[m])) {
			m = i;
		} else {
			m = m;
		}
	}
	return m;
}

int max_rec(struct Aluno *alunos, int m, int i, int n, FtnComparaAluno cmp) {
	if(!(i < n)) {
		return m;
	} else {
		if (cmp(&alunos[i], &alunos[m])) {
			return max_rec(alunos, i, i + 1, n, cmp);
		} else {
			return max_rec(alunos, m, i + 1, n, cmp);
		}
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
		{"Eduardo", 0, 2003, 2, 17, 9.0, 8.3, 9.1},
		{"Fabiana", 0, 1981, 6, 23, 5.0, 8.3, 9.1},
	};

	printAlunosTodos(alunos, 6);
	printAlunosCurso1(alunos, 6);
	printAlunosVelhos(alunos, 6);
	
	FtnTestAluno tests[] = {
		aceitaTodos,
		aceitaCurso1,
		aceitaAlunoVelho,
		aceita5Bola,
		aceitaCurso0,
	};

	processaAlunos(alunos, 6, aceitaCurso0, transferTo2, noop);
	processaAlunos(alunos, 6, aceita5BolaN1, transferTo3, noop);
	for (int i = 0; i < 5; i++) {
		processaAlunos(alunos, 6, tests[i], printAluno, printBarras);
	}
}


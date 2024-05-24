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
typedef int (*FtnTest)(struct Aluno *);
typedef void (*FtnAcao)(struct Aluno *);
typedef void (*FtnAcaoFinal)();
typedef int (*FtnCompara)(struct Aluno *, struct Aluno *);

void printAlunosV1(struct Aluno *alunos, int n, int test) {
	for(int i = 0; i < n; i++) {
		int cnd = 0;
		switch(test) {
			case 0:
				cnd = (1);
			break;
			case 1:
				cnd = (alunos[i].curso == 0);
			break;
			case 2:
				cnd = (alunos[i].ano > 2000);
			break;
			case 3:
				cnd = (alunos[i].n1 == 5.0 || alunos[i].n2 == 5.0 || alunos[i].n3 == 5.0);
			break;
			case 4:
				cnd = (alunos[i].mes == 2);
			break;
		}
		if (cnd) {
			printf("Nome: %s\ncurso: %d\nNasc: %d/%d/%d\nNotas: %f, %f, %f\n\n", 
					alunos[i].nome,
					alunos[i].curso,
					alunos[i].dia,
					alunos[i].mes,
					alunos[i].ano,
					alunos[i].n1,
					alunos[i].n2,
					alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAlunosV2(struct Aluno *alunos, int n, FtnTest test) {
	for(int i = 0; i < n; i++) {
		if (test(&alunos[i])) {
			printf("Nome: %s\ncurso: %d\nNasc: %d/%d/%d\nNotas: %f, %f, %f\n\n", 
					alunos[i].nome,
					alunos[i].curso,
					alunos[i].dia,
					alunos[i].mes,
					alunos[i].ano,
					alunos[i].n1,
					alunos[i].n2,
					alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAluno(struct Aluno *a) {
	printf("Nome: %s\ncurso: %d\nNasc: %d/%d/%d\nNotas: %f, %f, %f\n\n", 
			a->nome,
			a->curso,
			a->dia,
			a->mes,
			a->ano,
			a->n1,
			a->n2,
			a->n3);
}

void acaoFinal() {
	printf("======\n");
}

void acaoNoop() {
}

void curso0To2(struct Aluno *a) {
	a->curso = 2;
}

void processaAlunos(struct Aluno *alunos, int n, FtnTest test, FtnAcao acao, FtnAcaoFinal acaoFinal) {
	for(int i = 0; i < n; i++) {
		if (test(&alunos[i])) {
			acao(&alunos[i]);
		}
	}
	acaoFinal();
}

int aceitaTodos(struct Aluno *a) {
	return 1;
}

int aceitaCurso0(struct Aluno *a) {
	printf("olar!\n");
	return a->curso == 0;
}

int aceitaNovos(struct Aluno *a) {
	return a->ano > 2000;
}

/*
		int cnd = 0;
		switch(test) {
			case 0:
				cnd = (1);
			break;
			case 1:
				cnd = (alunos[i].curso == 0);
			break;
			case 2:
				cnd = (alunos[i].ano > 2000);
			break;
			case 3:
				cnd = (alunos[i].n1 == 5.0 || alunos[i].n2 == 5.0 || alunos[i].n3 == 5.0);
			break;
			case 4:
				cnd = (alunos[i].mes == 2);
			break;
		}
*/

void printAlunosTodos(struct Aluno *alunos, int n) {
	for(int i = 0; i < n; i++) {
		if (1) {
			printf("Nome: %s\ncurso: %d\nNasc: %d/%d/%d\nNotas: %f, %f, %f\n\n", 
					alunos[i].nome,
					alunos[i].curso,
					alunos[i].dia,
					alunos[i].mes,
					alunos[i].ano,
					alunos[i].n1,
					alunos[i].n2,
					alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAlunosCurso0(struct Aluno *alunos, int n) {
	for(int i = 0; i < n; i++) {
		if (alunos[i].curso == 0) {
			printf("Nome: %s\ncurso: %d\nNasc: %d/%d/%d\nNotas: %f, %f, %f\n\n", 
					alunos[i].nome,
					alunos[i].curso,
					alunos[i].dia,
					alunos[i].mes,
					alunos[i].ano,
					alunos[i].n1,
					alunos[i].n2,
					alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAlunosNovos(struct Aluno *alunos, int n) {
	for(int i = 0; i < n; i++) {
		if (alunos[i].ano > 2000) {
			printf("Nome: %s\ncurso: %d\nNasc: %d/%d/%d\nNotas: %f, %f, %f\n\n", 
					alunos[i].nome,
					alunos[i].curso,
					alunos[i].dia,
					alunos[i].mes,
					alunos[i].ano,
					alunos[i].n1,
					alunos[i].n2,
					alunos[i].n3);
		}
	}
	printf("=====\n");
}

void printAlunos5Bola(struct Aluno *alunos, int n) {
	for(int i = 0; i < n; i++) {
		if (alunos[i].n1 == 5.0 || alunos[i].n2 == 5.0 || alunos[i].n3 == 5.0) {
			printf("Nome: %s\ncurso: %d\nNasc: %d/%d/%d\nNotas: %f, %f, %f\n\n", 
					alunos[i].nome,
					alunos[i].curso,
					alunos[i].dia,
					alunos[i].mes,
					alunos[i].ano,
					alunos[i].n1,
					alunos[i].n2,
					alunos[i].n3);
		}
	}
	printf("=====\n");
}

int cmpMaiorNotaN1(struct Aluno *a1, struct Aluno *a2) {
	return a1->n1 > a2->n1;
}

int cmpNome(struct Aluno *a1, struct Aluno *a2) {
	return strcmp(a1->nome, a2->nome) > 0;
}

void bubble(struct Aluno *alunos, int n, FtnCompara cmp) {
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

//int max_old(struct Aluno *alunos, int n, FtnCompara cmp) {
//	int m = 0;
//	for (int i = 0; i < n; i++) {
//		if (cmp(&alunos[i], &alunos[m])) {
//			m = i;
//		} else {
//			m = m;
//		}
//	}
//	return m;
//}
//
//int max(struct Aluno *alunos, int n, FtnCompara cmp) {
//	return max_rec(alunos, n, cmp, 0, 0);
//}
//
//int max_rec(struct Aluno *alunos, int n, FtnCompara cmp, int m, int i) {
//	if (!(i < n)) {
//		return m;
//	} else {
//		if (cmp(&alunos[i], &alunos[m])) {
//			return max_rec(alunos, n, cmp, i, i+1);
//		} else {
//			return max_rec(alunos, n, cmp, m, i+1);
//		}
//	}
//}


void main(int argc, char *argv[]){
	struct Aluno alunos[] = {
		{"Adenilso", 0, 1976, 2, 28, 10.0, 9.8, 9.1},
		{"Adilson", 1, 1985, 7, 13, 7.2, 5.0, 8.2},
		{"Pedro", 1, 1999, 3, 12, 8.1, 9.2, 6.0},
		{"Joao", 0, 1988, 5, 13, 9.1, 9.3, 9.4},
		{"Eduardo", 0, 2003, 2, 17, 9.0, 8.3, 9.1},
		{"Fabiana", 0, 1981, 6, 23, 5.0, 8.3, 9.1},
	};

	int aceitaMes2(struct Aluno *a){
		return a->mes == 2;
	}

	//printAlunosV1(alunos, 6, 0);
	//printAlunosV1(alunos, 6, 1);
	//printAlunosV1(alunos, 6, 2);
	//printAlunosV1(alunos, 6, 3);
	//printAlunosV1(alunos, 6, 4);
	//
	int n = 6;
	FtnTest tests[] = {
		aceitaTodos,
		aceitaCurso0,
		aceitaNovos,
		aceitaMes2
	};

	bubble(alunos, 6, cmpMaiorNotaN1);
	processaAlunos(alunos, n, aceitaCurso0, curso0To2, acaoNoop);
	for (int i = 0; i < 4; i++) {
		//processaAlunos(alunos, n, tests[i], printAluno, acaoFinal);
	}
}

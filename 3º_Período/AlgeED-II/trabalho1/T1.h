#ifndef T1_H
#define T1_H
#define DELIMITADOR_TITULO '|'
#define DELIMITADOR_AUTOR '='
#include <stdio.h>

typedef struct {
	int id;
	char titulo[100];
    char autor[100];
} registroLivro;

void escreveRegnoArq(registroLivro registro, FILE* ptrArq);
void printArq(registroLivro registros, long int byteOffSet,int count);
registroLivro leRegdoArquivo(FILE* ptrArq);

#endif
#ifndef ARQUIVOSECUNDARIO_H
#define ARQUIVOSECUNDARIO_H
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//estrutura do registro para o arquivo secundário
typedef struct {
	int id;
  char autor[100]; //tamanho variável
}RegistroSec;

RegistroSec *criarRegistroSecundario(int id,char autor[]);
void selectionSortSecId(RegistroSec **vetor, int rrn);
void bubbleSort(RegistroSec **vetor,int rrn);
int busca_sequencial(RegistroSec **vetor, char autor[], int rrn, int inicio);
int busca_sequencialID(RegistroSec **vetor, int rrn, int id);
void inserirNoArquivoSecundario(RegistroSec **vetor, int rrn);
void removerDoVetorSecundario(RegistroSec **vetor, int tamVetor, int index);

#endif
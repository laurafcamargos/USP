#ifndef ARQPRIMARIO_H
#define ARQPRIMARIO_H
#define TAMREGISTRO 100
#include <stdio.h>
#include <stdlib.h>

//estrutura do registro para o arquivo primario
typedef struct {
	int id;
    int rrn; 
}RegistroPrim;

RegistroPrim *criar_registroPrim(int id, int rrn);
void selectionSort(RegistroPrim **vetor, int rrn);
int buscaBinariaRecursiva(RegistroPrim **vetor, int inicio, int fim, int id);
void inserirNoArquivoPrimario(RegistroPrim **vetor, int rrn);
void removerDoVetorPrimario(RegistroPrim **vetor, int tamVetor,int id);

#endif
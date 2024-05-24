#include "T1.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void escreveRegnoArq(registroLivro registro, FILE* ptrArq) {
    char delimitadorAutor = '=';
    char delimitadorTitulo = '|';
    int tamAutor = strlen(registro.autor);
    fwrite(&registro.id, sizeof(int), 1, ptrArq);
    fwrite(&registro.titulo, sizeof(char), strlen(registro.titulo), ptrArq );
    fwrite(&delimitadorTitulo, sizeof(char), 1,ptrArq);
    fwrite(&tamAutor, sizeof(int),1, ptrArq);
    fwrite(&registro.autor, sizeof(char),strlen(registro.autor), ptrArq);
    fwrite(&delimitadorAutor, sizeof(char), 1, ptrArq);
}

void printArq(registroLivro registro,long int byteOffSet,int count) { 

    if(count != 0) printf("\n\n");
    printf("Id: %d",registro.id);
    printf("\n");
    printf("Titulo: ");
    printf("%s",registro.titulo);
    printf("\n");
    printf("Autor: ");
    printf("%s",registro.autor);
    printf("\n");
    printf("Byte offset: %ld",byteOffSet);
}

registroLivro leRegdoArquivo(FILE* ptrArq) {
    char delimitadorAutor = '=';
    char delimitadorTitulo = '|';
    registroLivro registro;
    int tamanhoAutor;
    fread(&registro.id, sizeof(int), 1, ptrArq);
    char nome[100];
    int index = 0;
    char c = fgetc(ptrArq);
    while(c != delimitadorTitulo) {
        nome[index++] = c;
        c = fgetc(ptrArq);
    }
    nome[index] = '\0';
    strcpy(registro.titulo,nome);
    fread(&tamanhoAutor, sizeof(int),1, ptrArq);
    fread(&registro.autor, sizeof(char), tamanhoAutor, ptrArq);
    registro.autor[tamanhoAutor]='\0';
    fread(&delimitadorAutor, sizeof(char),1,ptrArq);
    return registro;
}
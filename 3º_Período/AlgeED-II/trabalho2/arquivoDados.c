#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include "arquivoDados.h"


//criar registro
RegistroDados *criar_registroDado(char titulo[], char autor[], int id){
    RegistroDados *registro = (RegistroDados*) calloc(1, sizeof(RegistroDados));

    strcpy(registro->titulo, titulo);
    strcpy(registro->autor, autor);
    registro->id = id;

    return registro;
}

//inserir no arquivo de dados
void inserirNoArquivoDeDados(RegistroDados *registro, int rrn){
    FILE *arquivo;
    arquivo = fopen("arquivo_dados.txt", "r+");
    if(arquivo == NULL){        
        arquivo = fopen("arquivo_dados.txt", "w+");
    }
    fseek(arquivo,(rrn * TAMREGISTRO) ,SEEK_SET);

    if(rrn == 0) fprintf(arquivo, "%d",registro->id);
    else fprintf(arquivo, "\n%d",registro->id);
    fprintf(arquivo, "|%s",registro->titulo);
    fprintf(arquivo, "|%s|",registro->autor);
    fclose(arquivo);
}

//ler registro do arquivo de dados
void lerDoArquivoDeDados(int rrn){
    if(rrn < 0){
        printf("Não encontrado\n");
        return;
    }

    FILE *arquivo;
    arquivo = fopen("arquivo_dados.txt", "r");

    char linha[100];
    int id;
    char titulo[100], autor[100];

    fseek(arquivo,(rrn * TAMREGISTRO) ,SEEK_SET);
    fread(linha, sizeof(char), 100, arquivo);
    
    sscanf(linha, "%d|%[^|]|%[^|]", &id, titulo, autor);
 
    printf("%d - %s - %s\n", id, titulo, autor);
    fclose(arquivo);
}

//remover logicamente um registro do arquivo de dados
void removerDoArquivoDeDados(int rrn){
    if(rrn < 0){
        printf("Não encontrado!\n");
        return;
    }

    //abrindo arquivo
    FILE *arquivo;
    arquivo = fopen("arquivo_dados.txt", "r+");
    if(arquivo == NULL){        
        arquivo = fopen("arquivo_dados.txt", "w+");
    }

    fseek(arquivo,(rrn * TAMREGISTRO) ,SEEK_SET);
    fprintf(arquivo, "\n%d", -1);
    
    fclose(arquivo);
}
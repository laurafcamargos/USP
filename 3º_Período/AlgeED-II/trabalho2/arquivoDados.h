#define TAMREGISTRO 100
#ifndef ARQDADOS_H
#define ARQDADOS_H

//estrutura do registro para o arquivo de dados
typedef struct {
    int id;
    char titulo[100];
    char autor[100];
}RegistroDados;


RegistroDados *criar_registroDado(char titulo[], char autor[], int id);
void inserirNoArquivoDeDados(RegistroDados *registro, int rrn);
void lerDoArquivoDeDados(int rrn);
void removerDoArquivoDeDados(int rrn);

#endif
#ifndef REGISTRO_H
#define REGISTRO_H
#include <stdio.h>

//estrutura do registro para o arquivo de dados
typedef struct {
    int id;
    char *titulo;
    char *autor;
}RegistroDados;


unsigned long long tamanhoRegistro();
void print(RegistroDados *registro);
int devolveID(RegistroDados *registro);
char *devolveTitulo(RegistroDados *registro);
char *devolveAutor(RegistroDados *registro);
RegistroDados *create(char * buffer);


#endif

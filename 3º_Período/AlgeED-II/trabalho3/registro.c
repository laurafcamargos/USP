#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "registro.h"

//função para obter o ID de um registro
int devolveID(RegistroDados *registro) {
    return registro->id;
}

//função para obter o autor de um registro
char *devolveAutor(RegistroDados *registro) {
    return registro->autor;
}

//função para obter o título de um registro
char *devolveTitulo(RegistroDados *registro) {
    return registro->titulo;
}

//função para imprimir um registro
void print(RegistroDados *registro){
    printf("%d - %s - %s\n", registro->id, registro->titulo, registro->autor);
}

//função para criar um registro a partir do buffer
RegistroDados *create(char * buffer) {
    RegistroDados *registro = calloc(1,sizeof (RegistroDados)); //aloca memória para o registro

    //encontra as posições dos campos no buffer
    char *idPos = strstr(buffer, "id='") + 4;
    char *tituloPos = strstr(buffer, "titulo='")+8;
    char *autorPos = strstr(buffer, "autor='")+7;

    registro->id = atoi(idPos); 

    //encontra o fim do título e calcula o tamanho do título
    char *tituloFim = strchr(tituloPos, '\'');
    size_t tamanhoTitulo = tituloFim - tituloPos;
    registro->titulo = malloc((tamanhoTitulo + 5) * sizeof(char)); //aloca memória para o campo título do registro
    strncpy(registro->titulo, tituloPos, tamanhoTitulo); //copia o título do buffer para o campo título do registro
    registro->titulo[tamanhoTitulo] = '\0'; 

    //encontra o fim do autor e calcula o tamanho do autor
    char *autorFim = strchr(autorPos, '\'');
    size_t tamanhoAutor = autorFim - autorPos;
    registro->autor = malloc((tamanhoAutor + 5) * sizeof(char)); //aloca memória para o campo autor do registro
    strncpy(registro->autor, autorPos, tamanhoAutor); //copia o autor do buffer para o campo autor do registro
    registro->autor[tamanhoAutor] = '\0'; 

    return registro; //retorna o registro criado
}

//função que retorna o tamanho do registro em bytes
unsigned long long tamanhoRegistro() {
    return sizeof(RegistroDados); // 
}

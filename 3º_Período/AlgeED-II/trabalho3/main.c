/*
Giovanna Pedrino Belasco 12543287
Laura Fernandes Camargos 13692334
Otavio Augusto Colucci de Oliveira 13692421
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "registro.h"
#include "dados.h"
#include "Btree.h"
#include <locale.h>

int main() {
    setlocale(LC_ALL, "Portuguese"); 

    FILE *indexFile = NULL, *dataFile = NULL;
    char buffer[150] = "";
    RegistroDados *registro = NULL;
    criarArquivos(&indexFile, &dataFile); //cria os arquivos de índice e dados

    while (fgets(buffer, sizeof(buffer), stdin) != NULL) {
        buffer[strcspn(buffer, "\n")] = '\0'; //remove o caractere de nova linha

        
        if (strcmp(buffer, "EXIT") == 0) //condição de parada do loop
            break;

        printf("----------------------------------------------------------\n");

        if (strstr(buffer, "ADD")) { //se a string contém "ADD"
            char *bufferCopy = copyString(buffer); //copia o buffer para outra variável
            char *dadosRegistro = copyString(buffer); 
            long offset = procuraRegistroNoArqIndex(bufferCopy, indexFile); //procura o registro no arquivo de índices
            free(bufferCopy);

            if (offset != -1) { //se o registro já existe
                printf("Erro ao inserir registro, chave primária duplicada\n");
                continue; //pula para a próxima iteração do loop
            }

            registro = create(dadosRegistro); //cria o registro com base nos dados do buffer

            if (escreveRegistroNoArqDados(registro, dataFile, indexFile) != -1) { //escreve o registro no arquivo de dados e no arquivo de índice
                printf("Registro inserido\n");
            }

            free(dadosRegistro);
            free(registro);

        } else if (strstr(buffer, "SEARCH")) { //se a string contém "SEARCH"
            long offset = procuraRegistroNoArqIndex(buffer, indexFile); //procura o registro no arquivo de índices

            if (offset != -1) { //se o registro é encontrado
                pegaRegistroDoArqDados(offset, dataFile); //imprime o registro do arquivo de dados
            } else {
                printf("Não encontrado\n");
            }
        }
    }

    fecharArquivos(indexFile, dataFile); //fecha os arquivos de índice e dados

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "Btree.h"
#include "registro.h"
#include "dados.h"

//função para criar os arquivos de índice e dados
void criarArquivos(FILE **indexFile, FILE **dataFile) {
  (*indexFile) = fopen("arquivoIndex.bin", "wb+"); //abre o arquivo de índice para leitura e escrita
  (*dataFile) = fopen("arquivoDados.bin", "wb+"); //abre o arquivo de dados para leitura e escrita
}

//função para fechar os arquivos de índice e dados
void fecharArquivos(FILE *indexFile, FILE *dataFile) {
  if (!indexFile || !dataFile) {
    printf("Erro ao abrir o arquivo\n");
  }
  fclose(indexFile);
  fclose(dataFile); 
}

//função para escrever um registro no arquivo de dados e retornar o byteoffset dele
long escreveRegistroNoArqDados(RegistroDados *registro, FILE *dataFile, FILE *indexFile) {
    BT_PAGE *page = getOrCreateRoot(indexFile); //pega ou cria a raiz da árvore B do arquivo de índice
    
    fseek(dataFile, 0, SEEK_END); //posiciona o ponteiro no final do arquivo de dados
    if (dataFile == NULL) 
        return 0;
    if (page == NULL) 
      return 0;
    
    long byteOffset = ftell(dataFile); //pega o byteoffset atual do ponteiro no arquivo de dados
    fwrite(registro, tamanhoRegistro(), 1, dataFile); //escreve o registro no arquivo de dados

    INDEX *newRecord = createIndex(devolveID(registro), byteOffset); //cria um novo registro com a chave do registro e o byteoffset correspondente
    bTreeInsert(newRecord, page, indexFile); //insere o novo registro na arvore

    for (int i = 0; i < MAXKEYS; i++){
      free(page->records[i]);
    }

    free(page->records);
    free(page->childs);
    free(page);
    free(newRecord);
    return byteOffset; //retorna o byteoffset do registro no arquivo de dados
}

//função para obter e imprimir um registro do arquivo de dados com base no byteoffset retornado
void pegaRegistroDoArqDados(int offset, FILE *dataFile) {
    RegistroDados *registroDoArq = NULL;
    if (dataFile == NULL) {
      return;
    }
    
    registroDoArq = (RegistroDados  *) calloc(1, tamanhoRegistro()); //aloca memória pro registro

    fseek(dataFile, offset, SEEK_SET); //posiciona o ponteiro no byteoffset fornecido a partir do início do arquivo

    if (!fread(registroDoArq, tamanhoRegistro(), 1, dataFile))
      return;

    print(registroDoArq); //imprime o registro
    free(registroDoArq); //libera a memória alocada para o registro
}

//função para procurar o bos de um registro no arquivo de índice com base em uma chave
long procuraRegistroNoArqIndex(char *buffer, FILE *indexFile) {
    BT_PAGE *page = getOrCreateRoot(indexFile); //obtém ou cria a página raiz da árvore B do arquivo de índice
    int keyToSearch = atoi(strstr(buffer, "id='") + 4); //pega a chave a ser procurada a partir do buffer

    if (indexFile == NULL) {
        return -1; 
    }
    long byteoffset = bTreeSelect(page, keyToSearch, indexFile); //procura o byteoffset do registro na árvore B

    for (int i = 0; i < MAXKEYS; i++){
      free(page->records[i]);
    }
  
    free(page->childs);
    free(page->records);
    free(page);
    return byteoffset; //retorna o byteoffset do registro no arquivo de dados
}

//função para copiar uma string
char *copyString(const char *origin) {
    char *destiny = malloc(strlen(origin) + 1); //aloca memória para a string de destino
    if (destiny != NULL){
      strcpy(destiny, origin); //copia a string de origem para a string de destino
      return destiny; //retorna a string de destino
    }
    return NULL;
}

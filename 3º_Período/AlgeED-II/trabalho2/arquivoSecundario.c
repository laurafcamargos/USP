#include "arquivoSecundario.h"

//criar registro
RegistroSec *criarRegistroSecundario(int id,char autor[]) {

    RegistroSec *registro = (RegistroSec*) calloc(1, sizeof(RegistroSec));
    registro->id = id;
    strcpy(registro->autor, autor);

    return registro;
}

//ordenação por id no vetor secundário
void selectionSortSecId(RegistroSec **vetor, int rrn){

    int i, j, menor;
    RegistroSec *aux;
    for (i = 0; i < (rrn - 1); i++)
    {
        menor = i;
        for (j = i + 1; j < rrn; j++)
        {
            if (vetor[j]->id < vetor[menor]->id)
            {
                menor = j;
            }
        }
        if (i != menor)
        {
            aux = vetor[i];
            vetor[i] = vetor[menor];
            vetor[menor] = aux;
            
        }
    }

}

//ordenação por autor no vetor secundário
void bubbleSort(RegistroSec **vetor,int rrn){
    int i, j;
    int troca;
    for (i = 0; i < rrn - 1; i++) {
        troca = 0;
        for (j = 0; j < rrn - i - 1; j++) {
            if (strcmp(vetor[j]->autor, vetor[j + 1]->autor)  > 0) {
                RegistroSec *temp = vetor[j];
                vetor[j] = vetor[j + 1];
                vetor[j + 1] = temp;
                troca = 1;
            }
        }
        if (troca == 0)
            break;
    }
}

//busca sequencial por autor no vetor secundário 
int busca_sequencial(RegistroSec **vetor, char autor[], int rrn, int inicio){
    for(int x = inicio; x < rrn; x++){
        if (strcmp(vetor[x]->autor, autor) == 0)
           return x;
        }
    return -1;
}

//busca sequencial por ID no vetor secundário
int busca_sequencialID(RegistroSec **vetor, int rrn, int id){
    for(int x = 0; x < rrn; x++){
        if (vetor[x]->id == id) return x;
        }
    return -1;
}

//inserir no arquivo .txt de indice secundario
void inserirNoArquivoSecundario(RegistroSec **vetor, int rrn){

    FILE *arquivo;
    arquivo = fopen("arquivo_secundario.txt", "w+");
    
    for(int x = 0; x < rrn; x++){
        if(strcmp(vetor[x]->autor, "AANULL") != 0){
            fprintf(arquivo, "%s",vetor[x]->autor);
            fprintf(arquivo, "|%d\n",vetor[x]->id);
        }

        //free na struct escrita
        free(vetor[x]);
    }
    fclose(arquivo);
}

//remover registro do arquivo secundário(manipular no vetor)
void removerDoVetorSecundario(RegistroSec **vetor, int tamVetor, int index){
    if(index < 0){
        printf("Não encontrado!\n"); //caso index seja invalido
        return;
    }
    strcpy(vetor[index]->autor, "AANULL");
}
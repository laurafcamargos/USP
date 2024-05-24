#include "arquivoPrimario.h"

//criar registro
RegistroPrim *criar_registroPrim(int id, int rrn){
    RegistroPrim *registro = (RegistroPrim*) calloc(1, sizeof(RegistroPrim));

    registro->id = id;
    registro->rrn = rrn;

    return registro;
}

//ordenação dos id's para a inserção
void selectionSort(RegistroPrim **vetor, int rrn){
    int i, j, menor;
    RegistroPrim *aux;
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

//busca binaria por id (devolve index)
int buscaBinariaRecursiva(RegistroPrim **vetor, int inicio, int fim, int id){
    if (fim >= inicio){
        int mid = inicio + (fim - inicio) / 2;
 
        //verificar elemento igual
        if (vetor[mid]->id == id)
            return mid;

        if (vetor[mid]->id > id)
            return buscaBinariaRecursiva(vetor, inicio, mid - 1, id);
 
        return buscaBinariaRecursiva(vetor, mid + 1, fim, id);
    }
    return -1;
}

//inserir no arquivo .txt de indice primário
void inserirNoArquivoPrimario(RegistroPrim **vetor, int rrn){
    FILE *arquivo;
    arquivo = fopen("arquivo_primario.txt", "w+");
    
    for(int x = 0; x < rrn; x++){
        if(vetor[x]->rrn > -1){
            fprintf(arquivo, "%d",vetor[x]->id);
            fprintf(arquivo, "|%d\n",vetor[x]->rrn);
        }

        //free na struct escrita
        free(vetor[x]);
    }
    fclose(arquivo);
}

//remover registro do arquivo primário(manipular no vetor)
void removerDoVetorPrimario(RegistroPrim **vetor, int tamVetor,int id){
    int index = buscaBinariaRecursiva(vetor, 0, tamVetor-1, id);
    if(index < 0){
        printf("Não encontrado!\n"); //caso nao encontre o id que se quer remover
        return;
    }
    vetor[index]->rrn = -1;
}
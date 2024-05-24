#include "arquivoDados.h"
#include "arquivoPrimario.h"
#include "arquivoSecundario.h"
#include <locale.h>
int insercao(RegistroPrim **vetorPrimario, RegistroSec **vetorSecundario, int id, char autor[], char titulo[], int rrn);
void buscaPorId(RegistroPrim **vetorPrimario, int tamanhoVetor, int id);
void buscarPorAutor(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores, char autor[]);
void removePorId(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores, int id);
void removerPorAutor(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores, char autor[]);
void sair(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores);
/*
Giovanna Pedrino Belasco 12543287
Laura Fernandes Camargos 13692334
Otavio Augusto Colucci de Oliveira 13692421
*/

int main(){
    setlocale(LC_ALL, "Portuguese"); //arrumando linguagem

    //criando vetores e declarando variaveis
    RegistroPrim **vetorPrimarios = (RegistroPrim **) malloc(sizeof(RegistroPrim *) * 120);
    RegistroSec **vetorSecundarios = (RegistroSec **) malloc(sizeof(RegistroSec *) * 120);
    char tag[10], titulo[100], autor[100];
    int id, tagInt;    

    int contador = 0; //conta quantidade de registros ja inseridos
    int medidor = 0; //variavel que aponta qual tipo de operação tem que ser feito

    while(medidor != -1){
        //lendo linha de codigo
        fflush(stdin);
        scanf("%s", tag);

        /*
        0 -> ADICIONAR
        1 -> PROCURAR(ID)
        2 -> PROCURAR(AUTOR)
        3 -> REMOVER(ID)
        4 -> REMOVER(AUTOR)
        -1 -> EXIT
        */

        //--- --- calculando operações e recebendo variaveis --- ---
        //ADICIONAR
        if(strcmp(tag, "ADD") == 0){
            scanf(" id='%d' titulo='%[^']' autor='%[^']'", &id, titulo, autor);
            medidor = 0;
        }

        //PROCURAR
        if(strcmp(tag, "SEARCH") == 0){
            //verificar id
            if(scanf(" id='%d'", &id) == 1){
                medidor = 1;

                //verificar autor
            }else if(scanf(" autor='%[^']'", autor) == 1){
                medidor = 2;
            }
        }

        //REMOVER
        if(strcmp(tag, "REMOVE") == 0){
            //verificar id
            if(scanf(" id='%d'", &id) == 1){
                medidor = 3;

                //verificar autor
            }else if(scanf(" autor='%[^']'", autor) == 1){
                medidor = 4;
            }
        }

        //EXIT
        if(strcmp(tag, "EXIT") == 0){
            sair(vetorSecundarios, vetorPrimarios, contador);
            return 0;
        }

        printf("----------------------------------------------------------\n");
        // --- --- --- EXECUTANDO AS OPERAÇÕES --- --- ---
        switch(medidor){
        //inserção
        case 0:
            contador += insercao(vetorPrimarios, vetorSecundarios, id, autor, titulo, contador);
            break;

        //busca por id
        case 1:
            buscaPorId(vetorPrimarios, contador, id);
            break;
        
        //busca por autor
        case 2:
            buscarPorAutor(vetorSecundarios, vetorPrimarios, contador, autor);
            break;

        //remoção por id
        case 3:
            removePorId(vetorSecundarios, vetorPrimarios, contador, id);
            break;

        //remoção por autor
        case 4:
            removerPorAutor(vetorSecundarios, vetorPrimarios, contador, autor);
            break;
        
        }
    }
    return 0;
}

//============================ FUNÇÃO DE INSERÇÃO =================================
int insercao(RegistroPrim **vetorPrimario, RegistroSec **vetorSecundario, int id, char autor[], char titulo[], int rrn){
    //verificar se já existe um registro com mesmo id
    if(buscaBinariaRecursiva(vetorPrimario, 0, rrn - 1, id) > -1){
        printf("Erro ao inserir registro, chave primária duplicada\n");
        return 0;
    }

    //inserindo no arquivo de dados
    RegistroDados *Rdado = criar_registroDado(titulo, autor, id);
    inserirNoArquivoDeDados(Rdado, rrn);
    free(Rdado);

    //inserindo no vetor de primarios
    RegistroPrim *Rprimario = criar_registroPrim(id, rrn);
    vetorPrimario[rrn] = Rprimario;

    //inserindo no vetor de secundarios
    RegistroSec *Rsecundario = criarRegistroSecundario(id, autor);
    vetorSecundario[rrn] = Rsecundario;

    //ordena ambos vetores primario/secundario
    selectionSort(vetorPrimario, rrn+1);
    //selectionSortSec(vetorSecundario, rrn+1);
    selectionSortSecId(vetorSecundario, rrn + 1);
    bubbleSort(vetorSecundario, rrn + 1);

    printf("Registro inserido\n");
    return 1;
}

//========================== FUNÇÃO DE BUSCA POR ID ===============================
void buscaPorId(RegistroPrim **vetorPrimario, int tamanhoVetor, int id){
    //recebendo rrn do vetor de registros primarios
    int index = buscaBinariaRecursiva(vetorPrimario, 0, tamanhoVetor - 1, id);
    if(index < 0){
        printf("Não encontrado\n");
        return;
    }

    lerDoArquivoDeDados(vetorPrimario[index]->rrn); //lendo e imprimindo registro
}

//======================== FUNÇÃO DE BUSCA POR AUTOR ==============================
void buscarPorAutor(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores, char autor[]){
    int id, index, contador = 0; //id retornado pela função buscar por autor

    //primeira leitura ates do while (testa se autor tem pelo menos um livro)
    contador = busca_sequencial(vetorSecundario, autor, tamanhoVetores, contador);
    if(contador < 0){
        printf("Não encontrado\n");
        return;
    }

    //loop q passa por todos os registros daquele autor
    while(1){
        contador = busca_sequencial(vetorSecundario, autor, tamanhoVetores, contador); //buscando index do registro relacionado ao autor
        if(contador < 0) break;
        id = vetorSecundario[contador]->id; // pegando id do registro de index "contador"

        index = buscaBinariaRecursiva(vetorPrimario, 0, tamanhoVetores -1, id); //buscando rrn relacionado ao id
        if(index < 0) break;

        lerDoArquivoDeDados(vetorPrimario[index]->rrn); //lendo e imprimindo registro
        contador++;
    }
}

//========================= FUNÇÃO DE REMOÇÃO POR ID ==============================
void removePorId(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores, int id){
    //verificar se um registro com tal id existe
    int indexPrimario = buscaBinariaRecursiva(vetorPrimario, 0, tamanhoVetores -1, id);
    if(indexPrimario < 0){
        printf("Erro ao remover\n");
        return;
    }
    int rrn = vetorPrimario[indexPrimario]->rrn;

    //achar registro secundario correspondente
    int indexSecundario = busca_sequencialID(vetorSecundario, tamanhoVetores, id);
    //remover registro secundario correspondente
    removerDoVetorSecundario(vetorSecundario, tamanhoVetores, indexSecundario);

    //remover indice primario
    removerDoVetorPrimario(vetorPrimario, tamanhoVetores, id);

    //remover registro de dados correspondente
    removerDoArquivoDeDados(rrn);

    printf("Registro removido\n");
}

//======================== FUNÇÃO DE REMOÇÃO POR AUTOR ============================
void removerPorAutor(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores, char autor[]){
    int contador = 0; //id retornado pela função buscar por autor

    //primeira leitura ates do while (testa se autor tem pelo menos um livro)
    contador = busca_sequencial(vetorSecundario, autor, tamanhoVetores, contador);
    if(contador < 0){
        printf("Erro ao remover\n");
        return;
    }

    //loop q passa por todos os registros daquele autor
    while(1){
        //Tratando Vetor secundario
        contador = busca_sequencial(vetorSecundario, autor, tamanhoVetores, contador); //buscando index do registro relacionado ao autor
        if(contador < 0) break;
        int id = vetorSecundario[contador]->id;
        removerDoVetorSecundario(vetorSecundario, tamanhoVetores, contador); //removendo do vetor secundario

        //Tratando vetor primario
        int index = buscaBinariaRecursiva(vetorPrimario, 0, tamanhoVetores -1, id); //buscando index relacionado ao id
        if(index < 0) break;
        int rrn = vetorPrimario[index]->rrn;
        removerDoVetorPrimario(vetorPrimario, tamanhoVetores, vetorPrimario[index]->id); //lendo rrn relacionado ao index

        //removendo do arquivo de dados
        removerDoArquivoDeDados(rrn);
        contador++;

        printf("Registro removido\n");
    }
}

//======================== FUNÇÃO DE SAIDA DO PROGRAMA ============================
void sair(RegistroSec **vetorSecundario, RegistroPrim **vetorPrimario, int tamanhoVetores){
    //escrever dados no arquivo primario
    inserirNoArquivoPrimario(vetorPrimario, tamanhoVetores);
    free(vetorPrimario); // free no vetor primario

    //escrever dados no arquivo secundario
    inserirNoArquivoSecundario(vetorSecundario, tamanhoVetores);
    free(vetorSecundario); //free no vetor secundario
}
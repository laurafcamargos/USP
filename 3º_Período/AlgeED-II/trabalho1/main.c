#include <stdio.h>
#include "T1.h"
#include <stdlib.h>
#include <string.h>

int main() {
    int n; //numero de registros 
    int m; //quais registros devem ser imprimidos
    registroLivro registros;
    scanf("%d",&n);
    long int byteOffSet[n]; //vetor que ajuda no cálculo dos bytes offset

    for (int i = 0; i < n; i++) {
        byteOffSet[i] = 0; //inicia com tudo = 0
    }

    long int soma = 0,calcPosicao = 0;

    FILE* ptrArq;
    ptrArq = fopen("registros.bin", "wb"); //abre o arquivo binário para escrita

    for (int i = 0; i < n; i++) {
        scanf("%d",&registros.id);
        scanf(" %[^(\r|\n)]", registros.titulo);        
        scanf(" %[^(\r|\n)]", registros.autor);
        escreveRegnoArq(registros, ptrArq);
        calcPosicao = sizeof(int) + (sizeof(char) * strlen(registros.titulo)) + sizeof(char) + sizeof(int) + (sizeof(char) * strlen(registros.autor)) + sizeof(char);
        byteOffSet[i] = soma;
        soma += calcPosicao;
    }
   
    fclose(ptrArq);
    scanf("%d",&m);
    registroLivro reg;
    ptrArq = fopen("registros.bin", "rb"); //abre o arquivo binário para leitura
    
    fseek(ptrArq, byteOffSet[n-m], SEEK_SET); //coloca a cabeça de leitura de "trás para frente"
    for (int i = n - m; i < n; i++) {
        reg = leRegdoArquivo(ptrArq);
        printArq(reg,byteOffSet[i],i - n + m);
    }  
    fclose(ptrArq);
}



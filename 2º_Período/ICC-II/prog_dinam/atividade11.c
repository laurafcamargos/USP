#include <stdio.h>
#include <stdlib.h>
//Júlio César Cabral - 13672922
//Laura Fernandes Camargos - 13692334
//Lucas Masaki Maeda - 13692272
//Matheus Henrique da Silva - 13696658

int amigos_max(int *cache,int linhas,int colunas,int **percurso,int quarteirao) {

    int maxDireita = 0;
    int maxBaixo = 0;
    int max;
    if(cache[quarteirao]==-1) {
        if(quarteirao == ((linhas * colunas) - 1)) {
            max = 0; //maior caminho q o último nó pode ter
        }
        else {
            if((quarteirao %colunas ) != (colunas - 1)) { //5%3 = 2, 2%3 = 2 coluna onde está o nó "beirada"
                maxDireita = percurso[quarteirao][quarteirao+1] + amigos_max(cache, linhas, colunas, percurso,quarteirao+1);
            } //esse nó beirada só percorre pra baixo
            if(quarteirao < ((linhas * colunas) - colunas)) {
                maxBaixo = percurso[quarteirao][quarteirao+colunas] + amigos_max(cache,linhas, colunas, percurso,quarteirao+colunas);
            } //demais nós 

            if(maxBaixo > maxDireita) 
                max = maxBaixo; 
            else 
                max = maxDireita;
        }
    }
    cache[quarteirao] = max;
    return cache[quarteirao];
}


int amigos(int linhas, int colunas, int **percurso,int quarteirao) {
    int *cache = (int*)malloc(sizeof(int)*((linhas*colunas)+1));
    //o cache só possui um parâmetro, pois o que muda a cada chamada rescursiva é o nó 
    int recebe;
    for(int i = 0; i <= (linhas*colunas);i++) {
        cache[i]=-1;
    }

    recebe = amigos_max(cache,linhas,colunas,percurso,quarteirao);
    free(cache);

    return recebe;
}

int main() {
    int linhas;//ruas na horizontal
    int colunas;//ruas na vertical
    int idi,idj;
    int **percurso;
    scanf("%d %d",&linhas,&colunas);

    percurso = (int**)malloc(sizeof(int*)*(linhas*colunas));
    for(int i = 0; i < (linhas*colunas); i++) {
        percurso[i] = (int*)malloc(sizeof(int)*(linhas*colunas));
    }

    for(int i = 0; i < (((linhas-1)*colunas)+((colunas-1)*linhas)); i++){
        scanf("%d %d", &idi, &idj);
        scanf("%d",&percurso[idi][idj]);
    }
    
    int recebe = amigos(linhas,colunas,percurso,0);
    printf("%d",recebe);
    
    for(int i = 0;i < linhas; i++) {
        free(percurso[i]); //desaloca memória
    }
    free(percurso);
}


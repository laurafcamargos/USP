//Júlio César Cabral - 13672922
//Laura Fernandes Camargos - 13692334
//Lucas Masaki Maeda - 13692272
//Matheus Henrique da Silva - 13696658
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int overlap(char *read1, char *read2); //retorna o numero de overlap entre as reads
void combinaReads(char *read1, char*read2, int overlap, char *readNova);//concatena as reads
void removeReads(char **reads, int max1, int max2, char *readNova, int N);//remove as reads[max1] e [max2] que foram concatenadas

int overlap(char *read1, char *read2) {
    int a,b;
    int overlap = 0;
    a = strlen(read1);
    b = strlen(read2);


    if(read1[a - 1] == read2[0] && b == 1) { //tratando o caso de (ABC,C) -> (ABC)
        overlap = 1;
        return overlap;
    }

    if (strstr(read1, read2) != NULL) { //verifica se a read2 está contida na read1
        overlap = b;
        return overlap;//retorna o próprio tamanho da read2
    }
    //se o overlap estiver na última letra da read1
    if (read1[a - 1] == read2[0] && read1[a - 2] != read2[1]) {
        overlap = 1;
        return overlap;
    }
    
    int j = 0; //o índíce da read2 só é incrementado quando há sobreposição
    for (int i = 0; i < a && j < b; i++) {
        if (read1[i] == read2[j]) {
            overlap++;
            j++;
        }
        else {  //a sobreposição é interrompida quando tem uma letra diferente
            i = i - overlap; //compara todas as letras da read1 com a primeira da read2
            overlap = 0;    //i = tem que ser o que percorreu - os overlaps encontrados
            j = 0;          //j volta a ser 0 na tentativa de achar um overlap maior
        }
    }
    return overlap;
}

void combinaReads(char *read1, char*read2, int overlap, char *readNova) {
    if (overlap == 0) { //significa que tem sopreposição, é so juntar as duas reads
        strcpy(readNova,read1); //copia a read1 pra novaRead
        strcat(readNova,read2); //coloca a read2 ao final da novaRead, concatenando 
    } 
    else if (overlap == strlen(read2)) { //significa que a read2 é subtring da read1 ou elas sao iguais
        strcpy(readNova, read1);
    }
    else { //combina cada char da read2 que não está sobreposto com a read1
        strcpy(readNova,read1);
        for (int i = overlap; i < strlen(read2); i++) {
            int t = strlen(readNova);
            readNova[t] = read2[i];
            readNova[t + 1] = '\0';
        }
    }
}
void removeReads(char **reads, int max1, int max2, char *readNova, int N) {

        for (int i = max1; i < N - 1; i++) {
            strcpy(reads[i], reads[i + 1]); //remove a read[max1]
        }
        int k;
        //verificar se a posição do max1 permanece a mesma após a remoção
        if (max1 < max2)
            k = 1;      
        else 
            k = 0;

        for (int i = max2 - k; i < N - 2; i++) { //remove a read[max2]
            strcpy(reads[i], reads[i + 1]);
        }
        //desloca a read que sobrou uma posição para direita para coloca a readNova na read[0]
        for (int i = N - 2; i >= 1; i--) {
            strcpy(reads[i], reads[i - 1]);
        }
        strcpy(reads[0], readNova); //põe a readNova na primeira posição(read[0])
}


int main() {

    char **reads;
    char *readNova;
    int N;
    int max1,max2,overlapmax = -1;
    int overlapcalc;

    readNova = (char *)malloc(200 * sizeof(char ));
    scanf("%d", &N);
    reads = (char **)malloc(N * sizeof(char *)); 
    for(int i = 0; i < N; i++) {

        reads[i] = malloc(200 * sizeof(char)); 
        scanf("%s", reads[i]);
    }
    while (N >= 2) {
         for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                if (i != j)
                {
                    overlapcalc = overlap(reads[i], reads[j]);
                    if (overlapcalc > overlapmax)
                    {
                        overlapmax = overlapcalc;
                        max1 = i;
                        max2 = j;
                    }
                }
            }
        }
    combinaReads(reads[max1],reads[max2],overlapmax,readNova);
    if (N > 2) {
        removeReads(reads,max1,max2,readNova,N);
    }
    N--;
    overlapmax = -1;
    }
    printf("%s", readNova); 
    for (int i = 0; i < N; i++) {
        free(reads[i]);
    }
    free(reads);
    return 0;
}
    

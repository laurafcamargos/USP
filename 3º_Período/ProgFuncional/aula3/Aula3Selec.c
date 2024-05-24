#include <stdio.h>
#include <stdlib.h>
void selec (int a[], int n);
void selecR1(int a[], int n, int i);
void selecR2(int a[], int n, int i, int m, int j);
void imprimir_vetor(int v[], int n);
void troca(int v[], int i, int j);
//Solução imperativa usando laço -> transformar em função recursiva
//selection com laço:

/*void selec(int a[], int n) {
    for (int i = 0; i < n - 1; i++) {
        int m = i;
        for (int j = i +1; j < n; j++) {
            if (a[j] < a[m]) {
                m = j;
            }
            troca(a, m, i);
        }
    }//base do for externo nao faz nada
}*/

//selection sem laço:

void selec (int a[], int n) {
    selecR1(a, n, 0);
}

/*void selecR1(int a[], int n, int i) {
    if (i < n -1) {
        int m = i;
        for (int j = i +1; j < n; j++) {
            if (a[j] < a[m]) {
                m = j;
            }
        }
    } 
    troca(a, m ,i); 
    selecR1(a, n, i+1); 
    else {
    }
} */
  
void selecR1(int a[], int n, int i) {
    if (i < n - 1) {
        selecR2(a,n,i,i,i+1);  
    }
}

void selecR2(int a[], int n, int i, int m, int j) {
    if (j < n) {
        if (a[j] < a[m]) {
            selecR2(a,n,i,j,j+1);
        }
      else {
            selecR2(a,n,i,m,j+1);   
        }
    } else{
        troca(a, m, i);
        selecR1(a, n ,i +1);
    }
}
void imprimir_vetor(int v[], int n) {
    for (int i = 0; i < n; i++)
        printf("%d ", v[i]);
    printf("\n");
}
void troca(int v[], int i, int j) {
    int trocado = v[i];
    v[i] = v[j];
    v[j] = trocado;
}
int main() {

    int v1[] = { 9, 2, 8, 7, 1, 6, 5, 0, 3, 4 };
    printf("Desordenado: ");
    imprimir_vetor(v1,10);
    selec(v1, 10);
    printf("Recursivo: "); imprimir_vetor(v1, 10);
    return 0;
}

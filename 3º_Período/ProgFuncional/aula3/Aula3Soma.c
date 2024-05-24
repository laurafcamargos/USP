#include <stdio.h>
//forma recursiva: inicialização(antes do laço começar), base(o que acontece quando o laço acabar)
//e a ação(dentro do laço)
int fr(int n, int soma, int i) {
    if(i <= n) {
        return fr(n, soma+i, i+1); //nao atualiza variavel nenhuma(ação)
    }else { //i > n
        return soma; //(base)
    }
}

int f(int n) {
    return fr(n, 0, 1); //(inicialização)
}


//com laço de repetição:
/*int f(int n) {
    int soma = 0;
    for(int i = 1; i<= n;i++) {
        soma += i;
    }
    return soma;
}*/

int main () {
    int n = f(10);
    printf("%d\n",n);
}


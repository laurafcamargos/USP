/*
Uso do crivo: o crivo contem os MAX primeiros primos...
Podemos verificar se um nro N é primo, somente divindo n 
por DIVISORES PRIMOS até raiz(N)

Isso se deve ao fato de que se um nro primo X nao pode dividir
N, entao nao tem sentido em testar se multiplos de X divide N !!

isso terá complexida O(#primes < raiz(N))

exemplo: temos 500 impares entre 0..raiz(10^6)... só que há somente
168 primos nesta faixa....

O teorema de nros primos diz que a qtd de primos <= M está limitado
a O(M/ln(M)-1). 

Portanto, se testarmos por meio de apenas divisores primos, teremos algo
na complexidade de O(raiz(N)/ln(raiz(N)))



COmplexidade para criar o crivo:

o loop externo itera para os M valores....
mas para cada valor, elimina os seus multiplos...
entao podemos dizer que ele faz

(N * (1/2 + 1/3 + 1/5 + 1/7 + .... 1/limite)) operacoes.
Essa operacao é o que chamamos de "progressao harmonica da soma
de primos" >> (1/2 + 1/3 + 1/5 + 1/7 + .... 1/limite) 
que é da ordem de log(log(n))

portanto, a complexidade final para se fazer o crivo eh: 
O(log(log(n)))


*/

#include <iostream>
#include <cstdio>
#include <bitset>
#include <vector>

using namespace std;

typedef long long ll;
typedef vector<int> vi;
typedef vector<ll> vll;
ll tamCrivo;   // capacidade de elementos no crivo


bitset<10000010> crivo; // vamos fazer um crivo até 10^7 !!!
vll primos;

void crivoErastotenes(ll M){
	tamCrivo = M+1; // para acrescentar o proprio M
	crivo.set();      // todo mundo é primo

	crivo[0] = crivo[1] = 0;  // 0 e 1 nao sao primos..

	for (ll i = 2; i <= tamCrivo; ++i){
		if (crivo[i]){           // se i for primo, descarta todos os seus multiplos
			for (ll j = i*i; j <= tamCrivo; j += i)
				crivo[j]=0;
			primos.push_back(i);  // guarda i no vetor de primos
		}
	}
}


bool primo(ll n){
	if (n <= tamCrivo)
		return crivo[n];   // retorna se eh ou nao primo em O(1)

	for (ll i = 0; i*i <= primos.size() ; i++){
		if (n%primos[i] == 0)
			return false;
	}
	return true;
}

int main(int argc, char const *argv[]){
	
	crivoErastotenes(10000000);
	ll n;
	cin >> n;

	if (primo(n))
		printf("O numero %lld eh primo\n", n);
	else printf("O numero %lld nao eh primo\n", n);
	
	return 0;
}
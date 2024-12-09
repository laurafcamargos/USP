/*
Calcula numero primo em O(n/2) = O(n)
*/

#include <iostream>
#include <cstdio>

using namespace std;

typedef long long ll;


bool primo(ll n){
	if (n <=1 ||  (n> 2 && n%2 == 0))
		return false;

	for (ll i = 3; i < n; i+=2){
		if (n%i == 0)
			return false;
	}
	return true;
}

int main(int argc, char const *argv[]){
	ll n;
	cin >> n;


	if (primo(n))
		printf("O numero %lld eh primo\n", n);
	else printf("O numero %lld nao eh primo\n", n);
	
	return 0;
}
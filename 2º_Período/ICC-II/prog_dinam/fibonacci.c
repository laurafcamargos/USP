#include<stdio.h>
#include<stdlib.h>

int fib_aux(int * cache, int n) {
	if (cache[n] == -1) {
		int res;
		if (n <= 1) {
			res = 1;
		} else {
			res = fib_aux(cache, n - 1) + fib_aux(cache, n - 2);
		}
		cache[n] = res;
	}
	return cache[n];
}

int fib(int n) {
	int *cache = (int *) malloc(sizeof(int) * (n + 1));
	for(int i = 0; i < n + 1; i++) {
		cache[i] = -1;
	}
	int res = fib_aux(cache, n);
	free(cache);
	return res;
}

int main(int argc, char *argv[]) {
	int n;
	scanf("%d", &n);

	int res = fib(n);

	printf("fib(%d) = %d\n", n, res);
}
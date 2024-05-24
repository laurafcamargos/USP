all: menorCaminho.o grafo.o
	@gcc menorCaminho.o grafo.o -o main

menorCaminho.o: menorCaminho.c
	@gcc menorCaminho.c -c

grafo.o: grafo.c
	@gcc grafo.c -c

run:
	@./main	
all: main.o arquivoDados.o arquivoPrimario.o arquivoSecundario.o
	@gcc main.o arquivoDados.o arquivoPrimario.o arquivoSecundario.o -o main

main.o: main.c
	@gcc main.c -c

arquivoDados.o: arquivoDados.c
	@gcc arquivoDados.c -c

arquivoPrimario.o: arquivoPrimario.c
	@gcc arquivoPrimario.c -c

arquivoSecundario.o: arquivoSecundario.c
	@gcc arquivoSecundario.c -c

run:
	@./main	
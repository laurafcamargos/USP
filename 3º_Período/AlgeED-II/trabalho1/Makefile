all: main.o T1.o
	@gcc main.o T1.o -o main

main.o: main.c
	@gcc main.c -c

T1.o: T1.c
	@gcc T1.c -c

run:
	@./main	
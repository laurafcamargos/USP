all: clean graph.o main.o
	@gcc graph.o main.o -o main -Wall

graph.o:
	@gcc -c graph.c

main.o:
	@gcc -c main.c

run:
	@./main

clean:
	@find -name '*.o' -o -name 'main' -o -name '*~' | xargs rm -rf {}

zip:
	zip -r main *.c *.h Makefile
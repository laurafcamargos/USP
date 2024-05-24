CC = gcc
CFLAGS = -Wall
	
all: edição.o 
	$(CC) -o main edição.o 
	
edição.o: edição.c 
	$(CC) -c edição.c
	
clean:
	rm main *.o

run: main
	./main
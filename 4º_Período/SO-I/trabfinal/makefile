CXX = g++
CXXFLAGS = -Wall -Wextra -std=c++11

all: main

main: forca.o main.cpp
	$(CXX) $(CXXFLAGS) -o main forca.o main.cpp

forca.o: forca.cpp forca.h
	$(CXX) $(CXXFLAGS) -c forca.cpp -o forca.o

clean:
	rm main *.o

run: main
	./main

#pragma once
//declaração das bibiliotecas
#include <iostream>
#include <vector>
#include <unistd.h>
#include <string.h>

using namespace std;

#include <algorithm>
#include <fstream>
#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <time.h>

#define QUANTIDADE_DE_JOGADORES 3

//declaração das funções utilizadas no jogo
void tela_vitoria();
void tela_vitoria_sec();
void imprimir_menu();
void tela_derrota();
void imprimirPalavra();
char gerarTentativaAleatoria();
void *jogadorThread(void *id);
void *jogadorUsuario(void *);
void iniciaJogo();


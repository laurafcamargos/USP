#include "Btree.h"
#include "registro.h"

void criarArquivos(FILE **, FILE **);
void fecharArquivos(FILE *, FILE *);
long escreveRegistroNoArqDados(RegistroDados *registro, FILE *dataFile, FILE *indexFile);
long procuraRegistroNoArqIndex(char *, FILE *);
void pegaRegistroDoArqDados(int offset, FILE *dataFile);
char *copyString(const char *origin);



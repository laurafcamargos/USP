#ifndef BTREE
#define BTREE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAXKEYS 205
#define CHILDSIZE 206
#define PAGESIZE 4096
#define TRUE 1
#define FALSE 0
#define LEFT 0
#define RIGHT 1

//estrutura que repesenta um registro do índice
typedef struct index
{
    int key;        //chave do registro
    long recordRRN; //RRN do registro
} INDEX;

//estrutura para representar o cabeçalho da árvore B
typedef struct header
{
    long rrn;        //RRN da raiz da árvore
    char *freeSpace; //espaço livre não utilizado
} BT_HEADER;

//estrutura para representar uma chave promovida durante a inserção na árvore B
typedef struct promotedKey
{
    INDEX *recordKey;  //chave promovida (registro)
    long childs[2];    //filhos da chave promovida
} BT_PROMOTED_KEY;

//estrutura para representar uma página da árvore B
typedef struct page
{
    INDEX **records;     //vetor de ponteiros para registros
    long *childs;        //vetor de ponteiros para os filhos
    short numberOfKeys;  //numero de chaves presentes na página
    bool isLeaf;         //flag que indica se a página é uma folha
} BT_PAGE;

long bTreeSelect(BT_PAGE *, int, FILE *);
void bTreeInsert(INDEX *, BT_PAGE *, FILE *);
BT_PAGE *getOrCreateRoot(FILE *);
bool writePageIntoFile(long rrn, BT_PAGE *, FILE *);
INDEX *createIndex(int, long);
long getTreeHeader(FILE *);
void writeTreeHeader(FILE *, long);
void freePage(BT_PAGE **page);
BT_PROMOTED_KEY *split(BT_PAGE *, BT_PROMOTED_KEY *, FILE *);
BT_PROMOTED_KEY *_insertBtree(BT_PROMOTED_KEY *, BT_PAGE *, FILE *);
BT_PROMOTED_KEY *insertInPage(BT_PROMOTED_KEY *, BT_PAGE *);
int checkIfGrowth(BT_PAGE * page);

#endif

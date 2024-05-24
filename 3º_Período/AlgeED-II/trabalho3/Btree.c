#include "Btree.h"
#include "dados.h"

//getters
BT_PAGE *getRoot(FILE);
BT_PAGE *getPage(long, FILE *);

//setters
void setChild(BT_PAGE **, long, int);
void setRecord(BT_PAGE **, INDEX *, int);
void setLeaf(BT_PAGE **, int);

BT_PAGE *createPage();
BT_PAGE *readPageFromFile(FILE *);

/* cria a chave de promoção */
BT_PROMOTED_KEY *createNewPromotedKey(INDEX *newRecord, long leftChild, long rightChild)
{
  BT_PROMOTED_KEY *newPromotedKey = (BT_PROMOTED_KEY *)calloc(1, sizeof(BT_PROMOTED_KEY));
  newPromotedKey->childs[LEFT] = leftChild;
  newPromotedKey->childs[RIGHT] = rightChild;
  newPromotedKey->recordKey = (INDEX *)calloc(1, sizeof(INDEX));
  newPromotedKey->recordKey->key = newRecord->key;
  newPromotedKey->recordKey->recordRRN = newRecord->recordRRN;

  return newPromotedKey;
}

/*cria uma página simples, alocando os records e childs com seus respectivos tamanhos máximos */
BT_PAGE *createPage()
{
  BT_PAGE *page = (BT_PAGE *)calloc(1, sizeof(BT_PAGE));

  page->records = (INDEX **)calloc(MAXKEYS, sizeof(INDEX *));
  page->childs = calloc(CHILDSIZE, sizeof(long));
  /* laço com o memset para limpar os records inicializados e alocados */
  for (int i = 0; i < MAXKEYS; i++)
  {
    page->records[i] = (INDEX *)calloc(1, sizeof(INDEX));
    memset(page->records[i], -1, 1);
  }
  memset(page->childs, -1, CHILDSIZE);
  page->numberOfKeys = 0;
  page->isLeaf = TRUE;

  return page;
}

//função recursiva que retorna o RRN adequado para a inserção de um novo registro
long _searchRRNToInsert(INDEX *newRecord, BT_PAGE *page, int counter, INDEX *pageRecord)
{
  if (counter >= page->numberOfKeys)
    return page->childs[counter];
  pageRecord = page->records[counter];
  if (newRecord->key < pageRecord->key)
    return page->childs[counter];
  return _searchRRNToInsert(newRecord, page, counter + 1, pageRecord);
}

/*retorna o RRN de uma página filha para inserir uma chave.
essa função é chamada por bTreeInsert até achar uma folha para então
retornar o rrn da página de inserção */
long getPageRRNToInsert(INDEX *newRecord, BT_PAGE *page)
{
  INDEX *pageRecord = NULL;
  long rrn = _searchRRNToInsert(newRecord, page, 0, pageRecord);
  free(pageRecord);
  return rrn;
}

static int findPosition(BT_PROMOTED_KEY *keyToInsert, BT_PAGE *page, int counter)
{
  if (counter >= page->numberOfKeys || keyToInsert->recordKey->key < page->records[counter]->key)
    return counter;
  return findPosition(keyToInsert, page, counter + 1);
}

/*retorna o index para inserir um registro */
int getPositionToInsertInSinglePage(BT_PROMOTED_KEY *keyToInsert, BT_PAGE *page)
{
  return findPosition(keyToInsert, page, 0);
}

//extrai a chave promovida a partir de uma nova página criada durante a operação de split
BT_PROMOTED_KEY *extractPromotedKey(BT_PAGE *newPage)
{
  INDEX *pointToFirstRecord = newPage->records[0];

  BT_PROMOTED_KEY *key = createNewPromotedKey(pointToFirstRecord, newPage->childs[LEFT], newPage->childs[RIGHT]);
  
  //ajusta os ponteiros dos registros e filhos da nova página
  int current = 1, leftPos = current - 1, rightPos = current + 1;
  for (current = 1; current < newPage->numberOfKeys; current++)
  {
    setChild(&newPage, newPage->childs[current], leftPos);
    setChild(&newPage, newPage->childs[rightPos], current);
    setRecord(&newPage, newPage->records[current], leftPos);
    leftPos++;
    rightPos++;
  }
  newPage->numberOfKeys--;
  return key;
}

// copiar do vetor pra pagina da arvore
void fromArrayToPage(BT_PROMOTED_KEY **copies, BT_PAGE **workingPage, int arrPos, int pagePos)
{
  setChild(workingPage, copies[arrPos]->childs[LEFT], LEFT);
  setChild(workingPage, copies[arrPos]->childs[RIGHT], RIGHT);
  setRecord(workingPage, copies[arrPos]->recordKey, pagePos);
}

BT_PROMOTED_KEY *separateKeysToEachPageAndPromote(BT_PROMOTED_KEY **copies, BT_PAGE *workingPage, BT_PAGE *newPage)
{
  int halfOfArray = (MAXKEYS + 1) / 2;
  int pagePos = 0;

  // copiar chaves e os ponteiros dos filho precedentes da promo_key oriunda da workingPage
  for (int i = 0; i < halfOfArray; i++)
    fromArrayToPage(copies, &workingPage, i, i);

  // copiar as chaves e os ponteiros dos filhos iterando a new_page com a promo_key

  for (int arrayPos = halfOfArray; arrayPos < (MAXKEYS + 1); arrayPos++)
  {
    fromArrayToPage(copies, &newPage, arrayPos, pagePos);
    newPage->numberOfKeys++;
    pagePos++;
  }

  // Setar a promo_key como o valor da new_key, pra ela ser promovida depois do split

  BT_PROMOTED_KEY *newKey = extractPromotedKey(newPage);
  return newKey;
}

/*função recursiva para copiar as chaves e os ponteiros da página para o array.
Se a chave inserida for menor que a da página, insere esta.
Se não, monta a promoted key com os dados da página e insere
a da página no array.
*/
BT_PROMOTED_KEY **recursiveCKAPTA(BT_PAGE *page, BT_PROMOTED_KEY *newRecord, BT_PROMOTED_KEY **copies, int arrayCounter, int pageCounter)
{
  if (arrayCounter >= CHILDSIZE)
    return copies;

  if (pageCounter < MAXKEYS)
  {
    if (page->records[pageCounter]->key < newRecord->recordKey->key)
    {
      copies[arrayCounter] = createNewPromotedKey(page->records[pageCounter], page->childs[pageCounter], page->childs[pageCounter + 1]);
      return recursiveCKAPTA(page, newRecord, copies, arrayCounter + 1, pageCounter + 1);
    }
  }
  copies[arrayCounter] = newRecord;
  return recursiveCKAPTA(page, newRecord, copies, arrayCounter + 1, pageCounter + 1);
}

//função para copiar as chaves e os ponteiros da página para o array.
BT_PROMOTED_KEY **copyKeysAndPointersToArray(BT_PAGE *page, BT_PROMOTED_KEY *newRecord)
{
  BT_PROMOTED_KEY **copies = calloc(CHILDSIZE, sizeof(BT_PROMOTED_KEY *));
  //                               contador página  |  contador array
  return recursiveCKAPTA(page, newRecord, copies, 0, 0);
}

// Faz de fato o split, quando é preciso dividir a página
BT_PROMOTED_KEY *split(BT_PAGE *page, BT_PROMOTED_KEY *newRecord, FILE *filePointer)
{
  // copy all keys and pointers from PAGE into a working page that can hold one extra key and child
  BT_PROMOTED_KEY **keyCopies = copyKeysAndPointersToArray(page, newRecord);

  // allocate and initialize a new page in the B-tree file to hold NEWPAGE
  BT_PAGE *newPage = createPage();
  newPage->isLeaf = page->isLeaf;

  fseek(filePointer, 0, SEEK_END);
  long rrnNewPage = ftell(filePointer);

  // copy keys and child pointers to PAGE and NEWPAGE
  // insert I_KEY and I_RRN into their proper places in the working page
  BT_PROMOTED_KEY *promoKey = separateKeysToEachPageAndPromote(keyCopies, page, newPage);

  promoKey->childs[RIGHT] = rrnNewPage;
  writePageIntoFile(rrnNewPage, newPage, filePointer);
  free(newPage->childs);
  free(newPage->records);
  free(newPage);
  free(keyCopies);
  return promoKey;
}

void setNewRoot(BT_PAGE *root, long rrnRoot, BT_PROMOTED_KEY *promotedKey, FILE *filePointer)
{
  BT_PAGE *newRoot = createPage();

  setLeaf(&newRoot, FALSE);
  promotedKey->childs[LEFT] = rrnRoot;

  if (checkIfGrowth(root))
    insertInPage(promotedKey, newRoot);
  else
    split(newRoot, promotedKey, filePointer);

  long rrn = ftell(filePointer);
  writePageIntoFile(rrn, newRoot, filePointer);
  writeTreeHeader(filePointer, rrn);
  free(newRoot);
}

void moveRecordsRight(BT_PAGE **page, int index)
{
  for (int i = (*page)->numberOfKeys - 1; i >= index; i--)
  {
    setRecord(page, (*page)->records[i], i + 1);
    setChild(page, (*page)->childs[i + 1], i + 2);
  }
}

// Insere o new record na página
BT_PROMOTED_KEY *insertInPage(BT_PROMOTED_KEY *newRecord, BT_PAGE *page)
{
  // sem split, insert
  int indexOfRecord = getPositionToInsertInSinglePage(newRecord, page);

  // abre espaço mandando os records das páginas pra direita
  moveRecordsRight(&page, indexOfRecord);

  // seta filhos da esquerda, direita e as chaves em indexOfRecord
  setChild(&page, newRecord->childs[LEFT], indexOfRecord);
  setChild(&page, newRecord->childs[RIGHT], indexOfRecord + 1);
  setRecord(&page, newRecord->recordKey, indexOfRecord);

  page->numberOfKeys++;
  return NULL;
}
int checkIfGrowth(BT_PAGE *page)
{
  return page->numberOfKeys < MAXKEYS;
}

BT_PROMOTED_KEY *_bTreeInsert(BT_PROMOTED_KEY *newRecord, BT_PAGE *page, FILE *filePointer)
{
  BT_PROMOTED_KEY *promotedKey = NULL;

  // se a pagina for folha, insere. se não, busca uma pagina do tipo folha recursivamente
  if (page->isLeaf)
  {
    if (checkIfGrowth(page))
      promotedKey = insertInPage(newRecord, page);
    else
      promotedKey = split(page, newRecord, filePointer);
  }
  else
  {
    // achar a pagina para inserir
    long rrnOfPage = getPageRRNToInsert(newRecord->recordKey, page);
    BT_PAGE *childPage = getPage(rrnOfPage, filePointer);

    // tenta inserir na filha da anterior baseado no rrnOfPage
    promotedKey = _bTreeInsert(newRecord, childPage, filePointer);
    // achei uma folha

    if (promotedKey != NULL)
    {
      promotedKey->childs[0] = rrnOfPage;

      if (checkIfGrowth(page))
        promotedKey = insertInPage(promotedKey, page);
      else
        promotedKey = split(page, promotedKey, filePointer);
    }

    writePageIntoFile(rrnOfPage, childPage, filePointer);

    for (int i = 0; i < MAXKEYS; i++)
    {
      free(childPage->records[i]);
    }
    free(childPage->records);
    free(childPage->childs);
    free(childPage);
  }
  return promotedKey;
}

void bTreeInsert(INDEX *newRecord, BT_PAGE *root, FILE *filePointer)
{
  long rootRRN = getTreeHeader(filePointer);

  // cria chave promovida com a chave e sem nenhum filho
  BT_PROMOTED_KEY *newRecordKey = createNewPromotedKey(newRecord, -1, -1);

  // tentar inserir promoted key na btree recursivamente
  BT_PROMOTED_KEY *promotedKey = _bTreeInsert(newRecordKey, root, filePointer);

  writePageIntoFile(rootRRN, root, filePointer);

  if (promotedKey != NULL)
  {
    setNewRoot(root, rootRRN, promotedKey, filePointer);
  }
}

// escreve rrn da raíz e atualiza espaco livre
void writeTreeHeader(FILE *filePointer, long rootRRN)
{
  BT_HEADER *header = (BT_HEADER *)calloc(1, sizeof(BT_HEADER));

  fseek(filePointer, 0, SEEK_SET);
  header->rrn = rootRRN;
  header->freeSpace = (char *)calloc(PAGESIZE, sizeof(char));
  memset(header->freeSpace, 1, PAGESIZE);
  fwrite(header, 1, sizeof(BT_HEADER), filePointer);
}

// Le página do arquivo

BT_PAGE *readPageFromFile(FILE *filePointer)
{
  BT_PAGE *page = createPage();

  for (int i = 0; i < MAXKEYS; i++)
    if (!fread(page->records[i], sizeof(INDEX), 1, filePointer))
      return NULL;

  if (!fread(page->childs, sizeof(long), CHILDSIZE, filePointer))
    return NULL;
  if (!fread(&page->numberOfKeys, sizeof(short), 1, filePointer))
    return NULL;
  if (!fread(&page->isLeaf, sizeof(bool), 1, filePointer))
    return NULL;
  return page;
}

// Escreve a página no arquivo
bool writePageIntoFile(long rrn, BT_PAGE *page, FILE *filePointer)
{
  if (page == NULL || PAGESIZE > rrn)
  {
    return 0;
  }
  if (filePointer == NULL)
  {
    return 0;
  }

  // escreve conforme RRN
  fseek(filePointer, rrn, SEEK_SET);
  for (int i = 0; i < MAXKEYS; i++)
    fwrite(page->records[i], sizeof(INDEX), 1, filePointer);

  fwrite(page->childs, sizeof(long), MAXKEYS + 1, filePointer);
  fwrite(&page->numberOfKeys, sizeof(short), 1, filePointer);
  fwrite(&page->isLeaf, sizeof(bool), 1, filePointer);

  return TRUE;
}

// Pega o cabeçalho da árvore
long getTreeHeader(FILE *filePointer)
{
  BT_HEADER *header = (BT_HEADER *)calloc(1, sizeof(BT_HEADER));

  fseek(filePointer, 0, SEEK_SET);
  if (!fread(header, sizeof(BT_HEADER), 1, filePointer))
  {
    free(header);
    return -1;
  }
  long rrnHeader = header->rrn;
  free(header);
  return rrnHeader;
}

// pegar page a partir do rrn
BT_PAGE *getPage(long rrn, FILE *filePointer)
{
  if (filePointer == NULL)
  {
    return 0;
  }
  fseek(filePointer, rrn, SEEK_SET);

  BT_PAGE *page = readPageFromFile(filePointer);
  return page;
}

// criar árvore e setar ela depois do header
BT_PAGE *createTree(FILE *filePointer)
{
  if (filePointer == NULL)
  {
    return 0;
  }
  BT_PAGE *root = createPage();

  writeTreeHeader(filePointer, PAGESIZE);
  writePageIntoFile(PAGESIZE, root, filePointer);
  return root;
}

// pega página existente ou cria caso não seja encontrada
BT_PAGE *getOrCreateRoot(FILE *filePointer)
{
  if (filePointer == NULL)
  {
    return 0;
  }
  long rrnRoot = getTreeHeader(filePointer);
  if (rrnRoot == -1)
  {
    return createTree(filePointer);
  }
  return getPage(rrnRoot, filePointer);
}

/*Retorna RRN ou NOT_FOUND_KEY */
long bTreeSelect(BT_PAGE *page, int key, FILE *filePointer)
{
  long foundRRN = 0, i = 0;

  if (page == NULL || page->numberOfKeys == 0)
  {
    return -1;
  }
  else
  {
    // Procura no nó atual se a chave existe
    // Se encontrar a chave, retorna RRN dela
    if (page->isLeaf)
    {
      for (i = 0; i < page->numberOfKeys; i++)
      {
        if (key == page->records[i]->key)
        {
          return page->records[i]->recordRRN;
        }
      }
    }
    else
    {
      // not found
      for (i = 0; i < page->numberOfKeys; i++)
      {
        // se a chave for menor que a da page, entra nos filhos
        if (key < page->records[i]->key)
        {
          BT_PAGE *childPage = getPage(page->childs[i], filePointer);
          foundRRN = bTreeSelect(childPage, key, filePointer);
          free(childPage);
          return foundRRN;
        }
      }
    }
    // se nao for menor que nenhuma chave , entra na ultima chave da page
    if (!page->isLeaf && key > page->records[i]->key)
    {
      BT_PAGE *childPage = getPage(page->childs[i], filePointer);
      foundRRN = bTreeSelect(childPage, key, filePointer);
      for (int i = 0; i < MAXKEYS; i++)
      {
        free(childPage->records[i]);
      }

      free(childPage->childs);
      free(childPage->records);
      free(childPage);
      return foundRRN;
    }
  }
  return -1;
}

// alocar record/index
INDEX *createIndex(int key, long recordRRN)
{
  INDEX *index = (INDEX *)calloc(1, sizeof(INDEX));
  index->key = key;
  index->recordRRN = recordRRN;
  return index;
}

void setChild(BT_PAGE **page, long child, int position)
{
  (*page)->childs[position] = child;
}

void setRecord(BT_PAGE **page, INDEX *index, int position)
{
  (*page)->records[position]->key = index->key;
  (*page)->records[position]->recordRRN = index->recordRRN;
}

void setLeaf(BT_PAGE **page, int isLeaf)
{
  (*page)->isLeaf = isLeaf;
}
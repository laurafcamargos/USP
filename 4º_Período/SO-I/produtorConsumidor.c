#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>

#define MAX 15 //Quantos recursos produzir 
sem_t empty, full; // Semáforos para controlar o estado do buffer
int buffer = 0; // Buffer usado entre produtor e consumidor (regiao critica)
pthread_mutex_t mutex; // Mutex para proteger o acesso ao buffer

void *producer(void *ptr)
{
    int i;
    for (i = 1; i <= MAX; i++) {
        sem_wait(&empty); // "Down" no semáforo empty
        pthread_mutex_lock(&mutex); // Bloqueia o acesso exclusivo ao buffer(regiao critica)
        buffer = i; /* Coloca item no buffer */
        printf("Produtor produziu: %d\n", i); /* Adiciona impressão */
        sem_post(&full); // "Up" no semáforo full
        pthread_mutex_unlock(&mutex); // Libera o acesso ao buffer
        
    }
    pthread_exit(0);
}

void *consumer(void *ptr) 
{
    int i;
    for (i = 1; i <= MAX; i++) {
        sem_wait(&full); // "Down" no semáforo full
        pthread_mutex_lock(&mutex); // Bloqueia o acesso exclusivo ao buffer(r.c.)
        printf("Consumidor consumiu: %d\n", buffer); /* Adiciona impressão */
        buffer = 0; /* Retira o item do buffer */
        pthread_mutex_unlock(&mutex); // Libera o acesso ao buffer
        sem_post(&empty); // "Up" no semáforo empty
    }
    pthread_exit(0);
}

int main(int argc, char **argv)
{
    pthread_t pro, con;
    sem_init(&empty, 0, 1); //Inicializa o semáforo empty com 1, garantindo que apenas um produtor possa adquirir o recurso buffer por vez
    sem_init(&full, 0, 0);  //Inicializa o semáforo full com 0, garantindo que o consumidor só consome quando o prod produzir um item
    pthread_mutex_init(&mutex, NULL); // Inicializa o mutex
    pthread_create(&con, NULL, consumer, NULL);
    pthread_create(&pro, NULL, producer, NULL);
    pthread_join(pro, NULL);
    pthread_join(con, NULL);
    sem_destroy(&empty);
    sem_destroy(&full);
    pthread_mutex_destroy(&mutex);

    return 0;
}

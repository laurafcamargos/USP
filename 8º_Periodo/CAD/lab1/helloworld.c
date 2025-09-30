#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>

#define NUM_THREADS 7

sem_t semaforos[NUM_THREADS];
int tkn = 0;

void *children(void *p_arg) {
    int p, next;

    p = *((int *)p_arg);
    next = (p + 1) % NUM_THREADS;
    
    // A thread espera pelo seu semáforo
    sem_wait(&semaforos[p]);
    
    // Seção crítica: atualiza a variável compartilhada
    // Seria melhor usar um mutex para o 'tkn'
    tkn++;
    printf("node %d with token %d \n", p, tkn);
    
    // Sinaliza a próxima thread
    sem_post(&semaforos[next]);

    pthread_exit(NULL);
}

int main() {
    pthread_t handle[NUM_THREADS];
    int i, p[NUM_THREADS];

    // Inicializa o primeiro semáforo com 1 para iniciar a sequência
    sem_init(&semaforos[0], 0, 1);

    // Inicializa os demais semáforos com 0
    for (i = 1; i < NUM_THREADS; i++) {
        sem_init(&semaforos[i], 0, 0);
    }

    // Cria as threads
    for (i = 0; i < NUM_THREADS; i++) {
        p[i] = i;
        if (pthread_create(&handle[i], NULL, children, &p[i]) != 0) {
            printf("Erro: falha ao criar a thread %d\n", i);
            exit(1);
        }
    }
    
    // Espera por todas as threads
    for (i = 0; i < NUM_THREADS; i++) {
        pthread_join(handle[i], NULL);
    }
    
    // Destrói os semáforos
    for (i = 0; i < NUM_THREADS; i++) {
        sem_destroy(&semaforos[i]);
    }

    return 0;
}
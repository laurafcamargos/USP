#include <stdio.h>
#include <pthread.h>
#include <semaphore.h>
#include <stdbool.h>

#define CHAIRS 5  // Número de cadeiras de corte de cabelo
#define MAX_CUSTOMERS 8 // Número máximo de clientes a serem atendidos

sem_t customers;       // Semáforo para clientes
sem_t barbers;         // Semáforo para barbeiros
sem_t mutex;           // Semáforo para exclusão mútua
sem_t barber_chairs;   // Semáforo para cadeiras de corte de cabelo

int waiting = 0;        // Quantidade de clientes esperando
int customers_served = 0; // Contador de clientes atendidos

void cut_hair() {
    printf("Barbeiro cortou o cabelo de um cliente.\n");
}

void get_haircut() {
    printf("Cliente teve o cabelo cortado.\n");
}

void* barber(void* arg) {
    while (customers_served < MAX_CUSTOMERS) {
        sem_wait(&customers);
        sem_wait(&mutex);
        waiting--;
        printf("\nBarbeiro cortou o cabelo de um cliente. Clientes na barbearia: %d, Cadeiras disponíveis: %d\n", waiting, CHAIRS - waiting);
        sem_post(&barbers);
        sem_post(&mutex);
        cut_hair();
        customers_served++;
    }
}

void* customer(void* arg) {
    sem_wait(&mutex);
    if (waiting < CHAIRS) {
        waiting++;
        printf("Cliente entrou na barbearia. Clientes na barbearia: %d, Cadeiras disponíveis: %d\n", waiting, CHAIRS - waiting);
        sem_post(&customers);
        sem_post(&mutex);
        sem_wait(&barber_chairs);  // Agora esperamos por uma cadeira de corte de cabelo
        get_haircut();
        sem_post(&barber_chairs);  // Libera a cadeira de corte de cabelo após o corte
    } else {
        sem_post(&mutex);
    }
}

int main() {
    // Inicialização dos semáforos
    sem_init(&customers, 0, 0);
    sem_init(&barbers, 0, 0);
    sem_init(&mutex, 0, 1);
    sem_init(&barber_chairs, 0, CHAIRS);  // Inicializa com o número total de cadeiras de corte de cabelo disponíveis

    // Inicialização das threads de barbeiro e clientes
    pthread_t barber_thread;
    pthread_t customer_threads[MAX_CUSTOMERS];

    pthread_create(&barber_thread, NULL, barber, NULL);

    for (int i = 0; i < MAX_CUSTOMERS; i++) {
        pthread_create(&customer_threads[i], NULL, customer, NULL);
    }

    // Aguarda as threads terminarem
    pthread_join(barber_thread, NULL);
    for (int i = 0; i < MAX_CUSTOMERS; i++) {
        pthread_join(customer_threads[i], NULL);
    }

    // Destroi os semáforos
    sem_destroy(&customers);
    sem_destroy(&barbers);
    sem_destroy(&mutex);
    sem_destroy(&barber_chairs);

    return 0;
}

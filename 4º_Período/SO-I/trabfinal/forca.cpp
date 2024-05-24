#include "forca.h"

vector<int> n_dos_jogadores;
std::size_t acertos;
sem_t mutex;
int QUANTIDADE_DE_RODADAS = 8;
int j;
string palavraChave;
string palavraOculta;

char tentativa;
sem_t sem_inicio_nova_rodada;  // Semáforo para controlar o início de uma nova rodada
bool ganhador;
// Mantenha um vetor para rastrear as letras já tentadas
vector<char> letrasTentadas;

void tela_vitoria() {
    printf("\n\n---------- PARABÉNS! ----------\n");
    printf("    Você adivinhou a palavra!!\n");
    cout << "    A palavra era: " << palavraChave << "\n";
    printf("\n--------------------------------\n");
}

void tela_vitoria_sec() {
    printf("\n\n---------- A palavra foi adivinhada! ----------\n");
    printf("    As threads venceram!!\n");
    cout << "    A palavra era:" << palavraChave << "\n";
    printf("\n--------------------------------\n");
}


void imprimir_menu() {
    char iniciar;

    printf("    ----------------------------------\n");
    printf("    Seja bem-vindo!\n");
    printf("    Esse é o jogo da forca!\n");
    printf("    Você e mais dois jogadores podem tentar adivinhar as letras.\n");
    printf("    Vocês tem 8 chances. A cada letra errada, o número de chances diminui\n");
    printf("    Os outros 2 jogadores são threads, quem acertar a ultima letra ganha!\n");
    printf("    Para iniciar, aperte ENTER.\n");
     printf("    ----------------------------------\n");
    scanf("%c", &iniciar);
   
}

void tela_derrota(){
    printf("\n\n---------- FIM DE JOGO ----------\n");
    printf("    Vocês não conseguiram adivinhar a palavra!\n");
    cout << "    A palavra era: " << palavraChave << "\n";
    printf("\n--------------------------------\n");
    exit(0);
}
void inicializarPalavra() {
    std::ifstream arquivo("arquivoPalavra.txt");

    if (arquivo.is_open()) {
        int numPalavras = 10; //numero de palavras no arquivo
        string palavra; //palavra selecionada

        // Gerar um índice aleatório para selecionar uma palavra
        int indiceAleatorio = rand() % numPalavras;

        // Voltar ao início do arquivo
        arquivo.clear();
        arquivo.seekg(0, ios::beg);

        // Achar a palavra do indice aleatório 
        for (int i = 0; i < indiceAleatorio; i++) {
            arquivo >> palavra;
        }

        // A palavra escolhida é armazenada em palavraChave
        arquivo >> palavraChave;

        // Inicialize palavraOculta com '_' para cada letra da palavraChave
        palavraOculta = string(palavraChave.length(), '_');

        // Feche o arquivo
        arquivo.close();
    } else {
        // Se não conseguir abrir o arquivo
        cout << "Não foi possível abrir o arquivo";
    }
}

void imprimirPalavra() {
    cout << "Palavra: ";
    for (char c : palavraOculta) {
        cout << c << ' ';
    }
    cout << "\n";
}

//Função responsável por gerar uma letra aleatória para os jogadores tentarem
char gerarTentativaAleatoria() {
    char letra;
    do {
        letra = 'a' + rand() % 26;  // Gerar uma letra aleatória
    } while (std::find(letrasTentadas.begin(), letrasTentadas.end(), letra) != letrasTentadas.end());  // Garantir que a letra não tenha sido tentada antes

    return letra;
}

//Função responsável por controlar as jogadas dos jogadores secundários (threads)
void *jogadorThread(void *id) {
    int *n_jogador = (int *)id; //id do jogador que está jogando

    //Randomiza o tempo em que cada jogador secundário tentará entrar na região crítica 
    int tmp = rand() % 20 + 8; // o tempo varia entre 7s e 20s
    sleep(tmp);

    //tenta entrar no semáforo responsável por garantir que apenas um jogador tente por vez
    sem_wait(&mutex);

    tentativa = gerarTentativaAleatoria(); //gera uma letra aleatória
    cout << "\nO jogador " << *n_jogador << " tentou a letra " << tentativa << "!\n";

    // Verifica se a tentativa está na palavra chave
    if (palavraChave.find(tentativa) != string::npos) { 
        cout << "Letra correta!\n";
        for (size_t i = 0; i < palavraChave.length(); ++i) { // Percorre cada letra de palavra chave
            if (palavraChave[i] == tentativa) { // Acha qual letra foi descoberta e atribui a mesma posição de letra oculta
                acertos++; //aumenta o numero de acertos
                palavraOculta[i] = tentativa;
            }
        }
    } else {
        cout << "Letra errada! \n";
        QUANTIDADE_DE_RODADAS--; //diminui a quantidade de rodadas 
    }
    // Adicione a letra tentada à lista de letras
    letrasTentadas.push_back(tentativa);
    cout << "Tentativas restantes: " << QUANTIDADE_DE_RODADAS << "\n\n";

    //define se o jogador principal foi o ultimo a tentar uma letra
    ganhador = false;

    // Libere o semáforo para indicar que o jogador terminou sua jogada
    sem_post(&sem_inicio_nova_rodada);
    sem_post(&mutex);

    return nullptr;
}

void *jogadorUsuario(void *) {
    cout << "\nSua tentativa (letra): ";
    cin >> tentativa;

    sem_wait(&mutex);
    
    // Verifica se a tentativa está na palavra chave
    if (palavraChave.find(tentativa) != string::npos) { 
        cout << "Letra correta!\n";
        for (size_t i = 0; i < palavraChave.length(); ++i) { // Percorre cada letra de palavra chave
            if (palavraChave[i] == tentativa) { // Acha qual letra foi descoberta e atribui a mesma posição de letra oculta
                acertos++; //aumenta o numero de acertos
                palavraOculta[i] = tentativa;
            }
        }
    } else {
        cout << "    Letra errada! \n";
        QUANTIDADE_DE_RODADAS--;
    }

    // Adicione a letra tentada à lista de letras
    letrasTentadas.push_back(tentativa);
    cout << "Tentativas restantes: " << QUANTIDADE_DE_RODADAS <<"\n\n";

    //define se o jogador principal foi o ultimo a tentar uma letra
    ganhador = true;

    // Libere o semáforo para indicar que o jogador terminou sua jogada
    sem_post(&sem_inicio_nova_rodada);
    sem_post(&mutex);

    return nullptr;
}


void iniciaJogo() {
    pthread_t jogadores[QUANTIDADE_DE_JOGADORES];

    // Inicializando id dos jogadores
    for (int i = 0; i < QUANTIDADE_DE_JOGADORES; i++)
        n_dos_jogadores.push_back(i + 1);

    sem_init(&mutex, 0, 1);
    sem_init(&sem_inicio_nova_rodada, 0, 0);

    imprimir_menu();
    inicializarPalavra();

    while (QUANTIDADE_DE_RODADAS > 0) {
        imprimirPalavra();

        pthread_create(&jogadores[0], NULL, jogadorUsuario, NULL);

        for (int i = 1; i < QUANTIDADE_DE_JOGADORES; i++)
            pthread_create(&jogadores[i], NULL, jogadorThread, &n_dos_jogadores[i]);

        // Aguarde até que todas as threads tenham iniciado a nova rodada
        sem_wait(&sem_inicio_nova_rodada);

        // Se todas as letras da palavra foram acertadas
        if (palavraChave.length() == acertos) {
            // Se o jogador principal foi o último a tentar a letra certa
            if (ganhador) {
                tela_vitoria();
            }

            // Se o jogador principal não foi o último a tentar a letra certa
            else {
                tela_vitoria_sec();
            }

            break; // Encerra o jogo se a palavra estiver completa
        }
    }

    // Se ninguém conseguiu adivinhar
    if (QUANTIDADE_DE_RODADAS == 0) {
        tela_derrota();
    }

    return;
}

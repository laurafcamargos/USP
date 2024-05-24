import random

# Define as combinações e seus respectivos prêmios
combos = {
    "Dois pares": 1,
    "Trinca": 2,
    "Straight": 5,
    "Flush": 10,
    "Full hand": 20,
    "Quadra": 50,
    "Straight Flush": 100,
    "Royal Straight Flush": 200
}

def imprimir_cartas(cartas):
    linhas = ["", "", "", "", ""]
    for carta in cartas:
        numero = carta[0]
        naipe = carta[1]
        linhas[0] += "+-----+  "
        linhas[1] += f"|{numero:<2}   |  "
        linhas[2] += f"|  {naipe}  |  "
        linhas[3] += f"|   {numero:>2}|  "
        linhas[4] += "+-----+  "
        
    for linha in linhas:
        print(linha)
    print()

# Função para gerar o baralho
def gerar_baralho():
    baralho = []
    naipes = ["♥", "♦", "♣", "♠"]
    for naipe in naipes:
        for valor in range(2, 15):
            if valor == 14:
                valor_str = "A"
            elif valor == 13:
                valor_str = "K"
            elif valor == 12:
                valor_str = "Q"
            elif valor == 11:
                valor_str = "J"
            else:
                valor_str = str(valor)
            carta = valor_str + naipe
            baralho.append(carta)
    return baralho

# Função para embaralhar o baralho
def embaralhar_baralho(baralho):
    random.shuffle(baralho)

# Função para pegar as 5 cartas iniciais
def pegar_cartas_iniciais(baralho):
    return baralho[:5]

# Função para pegar as cartas a serem trocadas
def pegar_cartas_a_trocar():
    trocar = input("Digite o número das cartas que deseja trocar (separados por espaço): ")
    trocar = trocar.split()
    return trocar

# Função para trocar as cartas
def trocar_cartas(baralho,cartas,cartas_a_trocar):
    novas_cartas = []
    cartas_a_trocar = [int(carta) - 1 for carta in cartas_a_trocar]  # Converter para índices base 0
    for i in range(5):
        if i in cartas_a_trocar:
            novas_cartas.append(baralho.pop(0))
        else:
            novas_cartas.append(baralho[i])
    return novas_cartas



# Função para verificar as combinações
def verificar_combinacoes(cartas):
    valores = []
    naipes = []
    for carta in cartas:
        valor = carta[:-1]
        naipe = carta[-1]
        if valor == "A":
            valor = 14
        elif valor == "K":
            valor = 13
        elif valor == "Q":
            valor = 12
        elif valor == "J":
            valor = 11
        else:
            valor = int(valor)
        valores.append(valor)
        naipes.append(naipe)
    valores.sort()
    naipes.sort()
    # Verifica se é Royal Straight Flush
    if valores == [10, 11, 12, 13, 14] and len(set(naipes)) == 1:
        return "Royal Straight Flush"
    # Verifica se é Straight Flush
    elif len(set(naipes)) == 1 and valores[-1] - valores[0] == 4:
        return "Straight Flush"
    # Verifica se é Quadra
    elif len(set(valores)) == 2:
        for valor in valores:
            if valores.count(valor) == 4:
                return "Quadra"
    # Verifica se é Full hand
    elif len(set(valores)) == 2:
        for valor in valores:
            if valores.count(valor) == 3:
                return "Full hand"
    # Verifica se é Flush
    elif len(set(naipes)) == 1:
        return "Flush"
    # Verifica se é Straight
    elif valores[-1] - valores[0] == 4 and len(set(valores)) == 5:
        return "Straight"
    # Verifica se é Trinca
    elif len(set(valores)) == 3:
        for valor in valores:
            if valores.count(valor) == 3:
                return "Trinca"
    # Verifica se é Dois pares
    elif len(set(valores)) == 3:
        pares = 0
        for valor in valores:
            if valores.count(valor) == 2:
                pares += 1
        if pares == 2:
            return "Dois pares"
    return None

# Função para iniciar o jogo
def jogar_video_poker():
    baralho = gerar_baralho()
    creditos = 200
    while creditos > 0:
        print("Saldo atual: ${}".format(creditos))
        aposta = input("Digite o valor da aposta ou 'F' para terminar ==> ")
        if aposta == 'F':
            print("Obrigado por jogar!")
            break
        aposta = int(aposta)
        if aposta > creditos:
            print("Créditos insuficientes. Digite uma aposta válida.")
            continue
        embaralhar_baralho(baralho)
        cartas = pegar_cartas_iniciais(baralho)
        for i in range(2):  # Duas rodadas de trocas
            print("Cartas atuais:")
            imprimir_cartas(cartas)
            # Jogador escolhe as cartas a serem trocadas
            cartas_a_trocar = pegar_cartas_a_trocar()
            cartas = trocar_cartas(baralho, cartas, cartas_a_trocar)
        print("Cartas finais:")
        imprimir_cartas(cartas)
        combinacao = verificar_combinacoes(cartas)
        if combinacao:
            premio = combos[combinacao] * aposta
            print(f"{combinacao}! Você ganhou ${premio}!")
            creditos += premio
        else:
            print("Peninha... não ganhou nada nessa rodada")
            creditos -= aposta
        print("Tecle enter para continuar")

# Executa o jogo
jogar_video_poker()
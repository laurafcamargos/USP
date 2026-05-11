# -*- coding: utf-8 -*-
"""Trabalho 01 .ipynb

Nome: Laura Fernandes Camargos

NUSP: 13692334

SCC0251 - Prof. Leo Sampaio Ferraz Ribeiro

Ano/Semestre: 2026/1

Trabalho 01: meu primeiro photoshop
"""

import numpy as np
import imageio.v3 as iio
import matplotlib.pyplot as plt
import os 

# =========================
# AUXILIARES
# =========================

def carregar_imagem(caminho):
    """
    Lê um arquivo de imagem do disco.

    Parâmetros:
        caminho (str): Caminho do arquivo (ex.: PNG, JPG).

    Retorno:
        numpy.ndarray: Imagem em float32 (valores típicos 0–255; RGB ou escala de cinza).
    """
    img = iio.imread(caminho)
    return img.astype(np.float32)


def salvar_imagem(img, caminho):
    """
    Grava a imagem em arquivo, cortando intensidades para [0, 255] e usando uint8.

    Parâmetros:
        img (numpy.ndarray): Imagem (float ou int).
        caminho (str): Destino do arquivo a ser escrito.

    Retorno:
        None (efeito colateral: arquivo criado e mensagem no console).
    """
    img_salvar = np.clip(img, 0, 255).astype(np.uint8)
    iio.imwrite(caminho, img_salvar)
    print(f"Imagem salva em: {caminho}")


def mostrar(img, titulo="Imagem"):
    """
    Exibe a imagem em uma janela interativa (matplotlib), em tons de cinza.

    Parâmetros:
        img (numpy.ndarray): Imagem a exibir.
        titulo (str, opcional): Título da figura. Padrão: "Imagem".

    Retorno:
        None.
    """
    img = np.clip(img, 0, 255).astype(np.uint8)
    plt.imshow(img, cmap='gray')
    plt.title(titulo)
    plt.axis('off')
    plt.show()


# =========================
# FUNÇÕES AUXILIARES - MATRIZES 
# =========================

def calcular_escala(og_w, og_h, theta, old_scale=1.0):
    """
    Estima o zoom mínimo para que o retângulo rotacionado caiba na mesma altura/largura,
    reduzindo áreas vazias (pretas) após rotação.

    Parâmetros:
        og_w (int): Largura original da imagem.
        og_h (int): Altura original da imagem.
        theta (float): Ângulo de rotação em graus.
        old_scale (float, opcional): Escala já aplicada em encadeamentos. Padrão: 1.0.

    Retorno:
        float: Fator adicional de escala a compor (1.0 se não precisar ampliar).
    """
    angle = np.radians(theta)
    new_w = abs(og_h * np.sin(angle)) + abs(og_w * np.cos(angle))
    new_h = abs(og_h * np.cos(angle)) + abs(og_w * np.sin(angle))
    fator_escala = max(new_h / og_h, new_w / og_w)

    if old_scale >= fator_escala:
        return 1.0

    return fator_escala / old_scale

def inv_translation_matrix(ti, tj):
    """Retorna matriz de translação inversa por (-ti, -tj)"""
    return np.array([[1, 0, -ti],
                     [0, 1, -tj],
                     [0, 0, 1]])

def inv_rot_matrix(theta):
    """Retorna matriz de rotação inversa por -theta (em radianos)"""
    return np.array([[np.cos(theta), np.sin(theta), 0],
                     [-np.sin(theta), np.cos(theta), 0],
                     [0, 0, 1]])

def inv_scale_matrix(si, sj):
    """Retorna matriz de escala inversa por (1/si, 1/sj)"""
    return np.array([[1.0 / si, 0, 0],
                     [0, 1.0 / sj, 0],
                     [0, 0, 1]])

# =========================
# 1. TRANSFORMAÇÕES GEOMÉTRICAS
# =========================

def translacao(img, tx, ty):
    """
    Translação com backward mapping; bordas entram pelo lado oposto (toroidal).

    Parâmetros:
        img (numpy.ndarray): Imagem de entrada.
        tx (int): Deslocamento em x.
        ty (int): Deslocamento em y.

    Retorno:
        numpy.ndarray: Imagem transladada, mesmo shape que a entrada.
    """
    # dimensões da imagem
    h, w = img.shape[:2]
    
    # Matriz de transformação completa  
    M = inv_translation_matrix(tx, ty)

    # cria vetores para índices destino 
    y = np.arange(h)[:, None] # (h, 1)
    x = np.arange(w)[None, :] # (1, w)
    ones = np.ones((h, w)) # (h, w)

    # aplica transformação usando broadcasting
    x_orig = (M[0, 0] * x + M[0, 1] * y + M[0, 2] * ones).astype(int) % w
    y_orig = (M[1, 0] * x + M[1, 1] * y + M[1, 2] * ones).astype(int) % h
    return img[y_orig, x_orig]


def rotacao(img, angulo):
    """
    Rotaciona em torno do centro com matrizes afins homogêneas e backward mapping;
    aplica zoom após a rotação para reduzir bordas pretas no canvas fixo H×W.

    Parâmetros:
        img (numpy.ndarray): Imagem de entrada (H x W ou H x W x C).
        angulo (float): Ângulo em graus.

    Retorno:
        numpy.ndarray: Imagem resultante, mesmas dimensões H e W que a entrada.
    """
    # dimensões da imagem
    h, w = img.shape[:2]
    theta = np.radians(angulo) # ângulo em radianos 
    scale = calcular_escala(w, h, angulo, old_scale=1.0) # fator de escala
    
    # Composição de matrizes
    T1 = inv_translation_matrix(-w / 2.0, -h / 2.0) # matriz de translação inversa
    S = inv_scale_matrix(scale, scale) # matriz de escala inversa
    R = inv_rot_matrix(theta) # matriz de rotação inversa
    T2 = inv_translation_matrix(w / 2.0, h / 2.0) # matriz de translação inversa

    # matriz de transformação completa
    M = T1 @ S @ R @ T2
    
    y = np.arange(h)[:, None] # (h, 1)
    x = np.arange(w)[None, :] # (1, w)
    ones = np.ones((h, w)) # (h, w)
    
    # M @ [x, y, 1] para todos os pixels de uma vez
    x_orig = M[0,0] * x + M[0,1] * y + M[0,2] * ones
    y_orig = M[1,0] * x + M[1,1] * y + M[1,2] * ones
    
    # Arredonda e converte para int
    x_orig = np.round(x_orig).astype(int)
    y_orig = np.round(y_orig).astype(int)
    
    # cria máscara de pixels válidos
    valid = (x_orig >= 0) & (x_orig < w) & (y_orig >= 0) & (y_orig < h)
    
    # preenche imagem
    nova = np.zeros_like(img)
    nova[valid] = img[y_orig[valid], x_orig[valid]]
    
    return nova

def escala(img, fator):
    """
    Escala geométrica centrada com backward mapping e vizinho mais próximo;
    composição de translações ao centro, escala inversa e translação de volta.
    Para fator < 1, faz crop central para remover bordas pretas (a saída fica menor que H×W).

    Parâmetros:
        img (numpy.ndarray): Imagem de entrada
        fator (float): Fator de escala; > 1 aproxima (zoom no centro), < 1 afasta e recorta o retângulo útil.

    Retorno:
        numpy.ndarray: Imagem resultante; mesmo H×W que a entrada se fator ≥ 1; se fator < 1,
        dimensões reduzidas proporcionalmente ao crop central.
    """
    h, w = img.shape[:2]
    cx, cy = w / 2.0, h / 2.0
    
    # Composição de matrizes de transformação inversa
    T1_inv = inv_translation_matrix(cx, cy)
    S_inv = inv_scale_matrix(fator, fator)
    T2_inv = inv_translation_matrix(-cx, -cy)
    
    # M = T(cx, cy) × S(1/fator) × T(-cx, -cy)
    M = T2_inv @ S_inv @ T1_inv
    
    # broadcasting para eficiência
    y_dest = np.arange(h)[:, None]
    x_dest = np.arange(w)[None, :]
    
    # backward mapping
    x_orig = M[0, 0] * x_dest + M[0, 1] * y_dest + M[0, 2]
    y_orig = M[1, 0] * x_dest + M[1, 1] * y_dest + M[1, 2]
    
    # vizinho mais próximo
    x_orig = np.round(x_orig).astype(int)
    y_orig = np.round(y_orig).astype(int)
    
    # coordenadas válidas
    valid = (x_orig >= 0) & (x_orig < w) & (y_orig >= 0) & (y_orig < h)
    
    # preenche imagem
    nova = np.zeros((h, w, img.shape[2]), dtype=img.dtype)
    nova[valid] = img[y_orig[valid], x_orig[valid], :]
    
    # crop automático para fatores < 1 (remove bordas pretas)
    if fator < 1:
        nh, nw = int(h * fator), int(w * fator)
        start_y = (h - nh) // 2
        start_x = (w - nw) // 2
        nova = nova[start_y:start_y+nh, start_x:start_x+nw, :]
    
    return nova


# =========================
# 2. TRANSFORMAÇÕES DE INTENSIDADE
# =========================

def inversa(img):
    """
    Inverte intensidades (negativo fotográfico): claro vira escuro e vice-versa.

    Parâmetros:
        img (numpy.ndarray): Imagem cujos valores são interpretados em [0, 255].

    Retorno:
        numpy.ndarray: Mesmo shape; pixel s = 255 - r.
    """
    # inverte intensidades
    return 255 - img


def log_transform(img):
    """
    Compressão dinâmica logarítmica: expande detalhes nas sombras.

    Parâmetros:
        img (numpy.ndarray): Intensidades não negativas (tipicamente 0–255).

    Retorno:
        numpy.ndarray: Intensidades transformadas; fórmula s = c * log(1 + r) com c normalizado.
    """
    c = 255 / np.log(1 + 255) # constante de normalização
    return c * np.log(1 + img)


def gamma_transform(img, gamma):
    """
    Correção gamma: ajusta não linearmente o brilho (curva de potência).

    Parâmetros:
        img (numpy.ndarray): Imagem em [0, 255] (float ou convertível).
        gamma (float): Expoente; < 1 clareia médios, > 1 escurece.

    Retorno:
        numpy.ndarray: s = 255 * (r/255)^gamma.
    """
    return 255 * ((img / 255) ** gamma)


def contraste_intervalo(img, r1, r2):
    """
    Esticamento de contraste por fatia: fora do intervalo satura em preto/branco; dentro, linear.

    Parâmetros:
        img (numpy.ndarray): Imagem em intensidade.
        r1 (int): Limite inferior do intervalo de interesse.
        r2 (int): Limite superior (deve ser > r1).

    Retorno:
        numpy.ndarray: Valores < r1 → 0; > r2 → 255; entre r1 e r2 mapeados linearmente em [0, 255].
    """
    # cria imagem vazia
    nova = np.zeros_like(img)

    # preenche imagem
    nova[img < r1] = 0 # pixels menores que r1 são preto
    nova[img > r2] = 255 # pixels maiores que r2 são branco

    # cria máscara de pixels válidos
    mask = (img >= r1) & (img <= r2) # pixels entre r1 e r2

    # preenche imagem   
    nova[mask] = (img[mask] - r1) * (255.0 / (r2 - r1)) # pixels entre r1 e r2 são mapeados linearmente em [0, 255]

    return nova


# =========================
# 3. FUNÇÃO PERSONALIZADA DE INTENSIDADE
# =========================

def funcao_criativa(img, intensidade=10):
    """
    Aplica uma sigmoide (logística) sobre intensidades normalizadas e reescala para [0, 255].

    Parâmetros:
        img (numpy.ndarray): Imagem de entrada.
        intensidade (float, opcional): Inclinação da curva (maior → transição mais forte). Padrão: 10.

    Retorno:
        numpy.ndarray: Imagem realçada (contraste percebido mais “vivo” após renormalização).
    """
    # normaliza intensidades
    img_norm = img / 255.0
    nova_img = 1 / (1 + np.exp(-intensidade * (img_norm - 0.5))) # aplica curva sigmoide
    nova_img = (nova_img - nova_img.min()) / (nova_img.max() - nova_img.min()) # normaliza
    
    return nova_img * 255


def menu():
    """
    Imprime no console as opções do editor interativo (transformações disponíveis).

    Parâmetros:
        Nenhum.

    Retorno:
        None.
    """
    print("\n===== EDITOR DE IMAGENS =====")
    print("1 - Translação")
    print("2 - Rotação")
    print("3 - Escala(crop)")
    print("4 - Inversa")
    print("5 - Log")
    print("6 - Gamma")
    print("7 - Modulação de Contraste")
    print("8 - Função criativa")
    print("0 - Sair")


# =========================
# PROGRAMA PRINCIPAL
# =========================

if __name__ == "__main__":
    caminho_imagem = "llxvisuals-eSLJG0y5S4U-unsplash.jpg"
    img = carregar_imagem(caminho_imagem)
    nome_base = "llxvisuals-eSLJG0y5S4U-unsplash"
    pasta_saida = "saida"
    
    if not os.path.exists(pasta_saida):
        os.makedirs(pasta_saida)
    contador = 1  
    
    while True:
        menu()
        op = input("\nEscolha uma opção: ").strip()

        if op == "1":
            tx = int(input("Translação em x: "))
            ty = int(input("Translação em y: "))
            img = translacao(img, tx, ty)
            caminho_saida = f"{pasta_saida}/{nome_base}_translacao_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "2":
            ang = float(input("Ângulo (graus): "))
            img = rotacao(img, ang)
            caminho_saida = f"{pasta_saida}/{nome_base}_rotacao_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "3":
            fator = float(input("Fator de escala (>1 aproxima, <1 afasta): "))
            img = escala(img, fator)
            caminho_saida = f"{pasta_saida}/{nome_base}_escaka_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "4":
            img = inversa(img)
            caminho_saida = f"{pasta_saida}/{nome_base}_inversa_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "5":
            img = log_transform(img)
            caminho_saida = f"{pasta_saida}/{nome_base}_log_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "6":
            gamma = float(input("Gamma: "))
            img = gamma_transform(img, gamma)
            caminho_saida = f"{pasta_saida}/{nome_base}_gamma_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "7":
            r1 = int(input("r1 (limite inferior): "))
            r2 = int(input("r2 (limite superior): "))
            img = contraste_intervalo(img, r1, r2)
            caminho_saida = f"{pasta_saida}/{nome_base}_contraste_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "8":
            intensidade = float(input("Intensidade (1-20, recomendado 10): "))
            img = funcao_criativa(img, intensidade)
            caminho_saida = f"{pasta_saida}/{nome_base}_saturada_{contador}.png"
            salvar_imagem(img, caminho_saida)
            contador += 1

        elif op == "0":
            break

        else:
            print("Opção inválida!")
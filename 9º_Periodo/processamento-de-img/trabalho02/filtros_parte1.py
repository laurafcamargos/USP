from __future__ import annotations

import numpy as np
from typing import Tuple, Literal

from convolucao import convolucao2d, convolucao2d_separavel

ModoPadding = Literal["constant", "edge", "reflect", "symmetric", "wrap"]


def normalizar_visualizacao(imagem: np.ndarray, min_val: float | None = None, max_val: float | None = None) -> np.ndarray:
    """Escala linear para [0, 255] uint8 (útil após Laplace/Sobel com valores negativos)."""
    x = np.asarray(imagem, dtype=np.float64)
    if min_val is None:
        min_val = float(np.min(x))
    if max_val is None:
        max_val = float(np.max(x))
    if max_val <= min_val:
        return np.zeros_like(x, dtype=np.uint8)
    y = (x - min_val) / (max_val - min_val) * 255.0
    return np.clip(y, 0, 255).astype(np.uint8)


def filtro_shift(
    imagem: np.ndarray,
    delta_linhas: int = 0,
    delta_colunas: int = 1,
    modo_padding: ModoPadding = "constant",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Deslocamento espacial: move toda a imagem por convolução.

    Usa kernel tipo "impulso de Dirac deslocado": matriz zeros com um 1 em posição deslocada.
    Quando convolvido, copia o pixel para a nova posição.

    Parâmetros:
    - delta_linhas: deslocamento vertical (>0 = para baixo, <0 = para cima)
    - delta_colunas: deslocamento horizontal (>0 = para direita, <0 = para esquerda)

    Exemplo: delta_linhas=2, delta_colunas=3 move imagem 2 pixels abaixo e 3 para direita.

    Padding:
    - 'constant': zeros aparecem onde não há imagem (preto)
    - 'reflect': reflexão nas bordas (sem artefato preto/branco)
    """
    # Tamanho do kernel: maior deslocamento + 1 pixel de cada lado
    k = max(abs(delta_linhas), abs(delta_colunas), 1)
    tamanho = 2 * k + 1
    kernel = np.zeros((tamanho, tamanho), dtype=np.float64)

    # Posição do impulso: centro + deslocamento
    # Centro é (k,k), impulso vai em (k+delta_linhas, k+delta_colunas)
    ci, cj = k + delta_linhas, k + delta_colunas

    if 0 <= ci < tamanho and 0 <= cj < tamanho:
        kernel[ci, cj] = 1.0  # Impulso na posição deslocada
    else:
        raise ValueError("Deslocamento maior que o suporte do kernel; aumente o padrão ou reduza o shift.")

    return convolucao2d(imagem, kernel, modo_padding=modo_padding, constante_padding=constante_padding)


def filtro_caixa_media(
    imagem: np.ndarray,
    tamanho_kernel: int = 5,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Suavização por média (box blur): substitui cada pixel pela média dos vizinhos.

    Kernel uniforme: todos os vizinhos em janela k×k têm peso igual.
    Normalizado por 1/(k²) para preservar brilho médio.

    Efeito: desfoca imagem, reduz ruído, mas também perda de detalhes.

    Características:
    - Simples e rápido
    - Resultado menos natural que Gaussiano (artefatos em forma de cruz)
    - Bom para pré-processamento antes de compressão
    """
    if tamanho_kernel < 1:
        raise ValueError("tamanho_kernel deve ser >= 1")

    # Kernel: matriz de 1s normalizada
    k = np.ones((tamanho_kernel, tamanho_kernel), dtype=np.float64)
    k /= float(tamanho_kernel * tamanho_kernel)  # Divide por número de elementos

    return convolucao2d(imagem, k, modo_padding=modo_padding, constante_padding=constante_padding)


def kernel_gaussiano_1d(sigma: float, tamanho: int | None = None) -> np.ndarray:
    """
    Cria kernel Gaussiano 1D: curva de sino com desvio padrão sigma.

    O kernel representa pesos para suavização: pixels próximos ao centro
    têm peso alto, pixels distantes têm peso baixo (exponencial negativo).

    Parâmetros:
    - sigma: largura da curva Gaussiana (maioria da energia em ±3*sigma)
    - tamanho: comprimento do kernel (deve ser ímpar para centragem)

    Se tamanho não for dado, calcula automaticamente como 2*ceil(3*sigma)+1.
    O kernel é normalizado para soma 1 (preserva brilho médio da imagem).
    """
    if sigma <= 0:
        raise ValueError("sigma deve ser positivo")

    # Se tamanho não foi dado, calcula automaticamente
    if tamanho is None:
        raio = int(np.ceil(3.0 * sigma))  # 3*sigma cobre ~99.7% da curva
        tamanho = 2 * raio + 1

    # Garante que o tamanho é ímpar (para centragem simétrica)
    if tamanho % 2 == 0:
        tamanho += 1

    # Cria array simétrico: [-raio, -raio+1, ..., 0, ..., raio-1, raio]
    r = tamanho // 2
    x = np.arange(-r, r + 1, dtype=np.float64)

    # Calcula Gaussiana: exp(-(x²)/(2*sigma²))
    g = np.exp(-(x**2) / (2.0 * sigma**2))

    # Normaliza para que soma = 1 (peso total = 1)
    g /= np.sum(g)

    return g


def filtro_gaussiano(
    imagem: np.ndarray,
    sigma: float = 1.0,
    tamanho_kernel: int | None = None,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Suavização gaussiana: borrão natural e isótropo (mesmo em todas as direções).

    Pesa vizinhos com curva Gaussiana: distância próxima = peso alto, longe = peso baixo.
    Resultado: borrão mais natural que caixa, sem artefatos visuais.

    Parâmetro sigma:
    - Pequeno (0.5): leve suavização
    - Médio (1-2): desfoque natural
    - Grande (4+): borrão forte

    Implementação separável: 2 convoluções 1D ao invés de 1 convolução 2D.
    Benefício: muito mais rápido (O(k*n²) vs O(k²*n²)) mantendo resultado idêntico.

    Aplicação: redução de ruído, pré-processamento, efeito de profundidade, base do unsharp mask.
    """
    # Cria kernel 1D Gaussiano
    k1 = kernel_gaussiano_1d(sigma, tamanho_kernel)

    # Convolução separável: primeiro em linhas, depois em colunas
    return convolucao2d_separavel(imagem, k1, modo_padding=modo_padding, constante_padding=constante_padding)


def filtro_laplace(
    imagem: np.ndarray,
    variante: Literal["4vizinhos", "8vizinhos"] = "4vizinhos",
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Laplaciano discreto: detecta bordas e transições abruptas na imagem.

    Calcula a segunda derivada (∇²I) da imagem. Resultado:
    - Bordas aparecem como valores altos (brilhantes)
    - Regiões uniformes ficam próximas de zero (escuras)

    Variantes:
    - '4vizinhos': considera apenas vizinhos acima/abaixo/esquerda/direita
    - '8vizinhos': inclui vizinhos diagonais (mais sensível, maior realce)
    """
    if variante == "4vizinhos":
        # Kernel clássico: -4 no centro, +1 nos 4 vizinhos
        k = np.array([[0.0, 1.0, 0.0], [1.0, -4.0, 1.0], [0.0, 1.0, 0.0]], dtype=np.float64)
    else:
        # Kernel 8-vizinhos: -8 no centro, +1 em todos os 8 vizinhos
        k = np.array([[1.0, 1.0, 1.0], [1.0, -8.0, 1.0], [1.0, 1.0, 1.0]], dtype=np.float64)
    return convolucao2d(imagem, k, modo_padding=modo_padding, constante_padding=constante_padding)


def filtro_sobel_gradientes(
    imagem: np.ndarray,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> Tuple[np.ndarray, np.ndarray]:
    """
    Gradiente de Sobel: calcula bordas em duas direções (horizontal e vertical).

    Retorna componentes (Gx, Gy):
    - Gx: detecta bordas verticais (transições esquerda↔direita)
    - Gy: detecta bordas horizontais (transições cima↔baixo)

    Kernels Sobel usam pesos: -2 e +2 nas laterais, -1 e +1 nos cantos.
    Isso dá mais importância aos vizinhos diretos (menos ruído).

    Magnitude |∇I| = sqrt(Gx² + Gy²) mostra força das bordas.
    Ângulo arctan(Gy/Gx) mostra direção.

    Vantagens:
    - Mais suave que Laplace (primeira derivada vs segunda)
    - Menos sensível a ruído
    - Orientação das bordas está preservada
    """
    # Kernel horizontal: detecta mudanças horizontais
    kx = np.array([[-1.0, 0.0, 1.0], [-2.0, 0.0, 2.0], [-1.0, 0.0, 1.0]], dtype=np.float64)

    # Kernel vertical: detecta mudanças verticais (transposto de kx)
    ky = np.array([[-1.0, -2.0, -1.0], [0.0, 0.0, 0.0], [1.0, 2.0, 1.0]], dtype=np.float64)

    # Aplica ambos os kernels
    gx = convolucao2d(imagem, kx, modo_padding=modo_padding, constante_padding=constante_padding)
    gy = convolucao2d(imagem, ky, modo_padding=modo_padding, constante_padding=constante_padding)

    return gx, gy


def filtro_sobel_magnitude(
    imagem: np.ndarray,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Magnitude do gradiente Sobel: força das bordas em cada pixel.

    Calcula a magnitude combinada dos gradientes horizontal (Gx) e vertical (Gy):
    |∇I| = sqrt(Gx² + Gy²)

    Resultado: bordas mais intensas = valores maiores (brilho alto).
    Útil para detectar objetos e contornos independente da orientação.
    """
    gx, gy = filtro_sobel_gradientes(imagem, modo_padding, constante_padding)
    return np.sqrt(gx * gx + gy * gy)


def nitidez_laplace(
    imagem: np.ndarray,
    lambda_laplace: float = 0.5,
    variante_laplace: Literal["4vizinhos", "8vizinhos"] = "4vizinhos",
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Realce de nitidez subtraindo o Laplaciano da imagem.

    Fórmula: I_sharp = I - λ * ∇²I

    Lógica:
    - Laplace detecta bordas (valores altos nas transições)
    - Subtraindo: acentua bordas (bordas → mais brilhantes)
    - λ controla força do efeito (0 = sem efeito, 1 = muito efeito)

    Parâmetros:
    - lambda_laplace: intensidade do realce (típico 0.2-1.0)
    - Maior λ = mais nitidez (pode amplificar ruído)

    Resultado: imagem com contornos mais definidos e "crisp".
    """
    img = np.asarray(imagem, dtype=np.float64)
    # Calcula Laplaciano (bordas)
    lap = filtro_laplace(img, variante_laplace, modo_padding, constante_padding)
    # Subtrai Laplaciano para realçar bordas
    return img - lambda_laplace * lap


def nitidez_mascara_desnitidez(
    imagem: np.ndarray,
    sigma_desfoque: float = 2.0,
    quantidade: float = 1.0,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Unsharp masking: realce de nitidez clássico (usado em câmeras e Photoshop).

    Fórmula: I_sharp = I + quantidade * (I - G_σ(I))

    Processo:
    1. Suaviza imagem com Gaussiano: G_σ(I) (versão desfocada)
    2. Calcula diferença: I - G_σ(I) (os detalhes finos)
    3. Adiciona volta os detalhes com força: I + quantidade * (detalhes)

    Lógica: quanto mais destaque dado aos detalhes finos, mais nítida a imagem.

    Parâmetros:
    - sigma_desfoque: largura do Gaussiano (σ grande = realça detalhes maiores)
    - quantidade: força do realce (0.5-2.0 comum, >1 = muito realce)

    Vantagens vs Laplace:
    - Mais controlável (σ define escala de detalhe)
    - Menos sensível a ruído
    - Resultados mais naturais
    """
    img = np.asarray(imagem, dtype=np.float64)

    # Cria versão desfocada (Gaussiano)
    suave = filtro_gaussiano(img, sigma=sigma_desfoque, modo_padding=modo_padding, constante_padding=constante_padding)

    # Extrai detalhes: diferença entre original e desfocada
    mascara = img - suave

    # Adiciona detalhes de volta multiplicados pela quantidade
    return img + quantidade * mascara


def filtro_emboss_criativo(
    imagem: np.ndarray,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Filtro criativo: emboss (relevo / iluminação 3D).

    Simula luz vindo de uma direção (canto superior esquerdo), criando efeito tátil.
    Pixels claros parecem "elevados", escuros parecem "suncos".

    Kernel assimétrico:
    [[-2  -1   0]
     [-1   1   1]
     [ 0   1   2]]

    Processo:
    - Centro em 1: referência
    - Negativos (-2, -1): lado oposto à luz (sombra)
    - Positivos (1, 2): lado iluminado (brilho)

    Resultado: efeito pictórico/artístico (usado em logos, capas de livros, etc).

    Diferente de detecção de borda pura: mantém gradação (não é binário puro/escuro).
    """
    k = np.array([[-2.0, -1.0, 0.0], [-1.0, 1.0, 1.0], [0.0, 1.0, 2.0]], dtype=np.float64)
    return convolucao2d(imagem, k, modo_padding=modo_padding, constante_padding=constante_padding)



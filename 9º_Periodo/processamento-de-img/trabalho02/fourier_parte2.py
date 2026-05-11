from __future__ import annotations

import numpy as np
from typing import Tuple, List


def proxima_potencia_de_2(n: int) -> int:
    """Menor potência de 2 >= n (para padding eficiente da transformada)."""
    if n <= 1:
        return 1
    p = 1
    while p < n:
        p <<= 1
    return p


def fft_1d(x: np.ndarray) -> np.ndarray:
    """
    fft_1d — transformada de Fourier rápida 1D .

    Converte sinal do domínio do tempo/espaço para o domínio das frequências.

    Divide o sinal em partes pares e ímpares, resolve recursivamente, depois combina.

    Implementação simplificada baseada na Professora Leo Sampaio.
    Requer comprimento n = 2^k. Use proxima_potencia_de_2() para preparar entrada.

    Passo 1: Base (n=1) → retorna a amostra
    Passo 2: Separa em índices pares e ímpares
    Passo 3: Aplica fft_1d recursivamente em ambas as metades
    Passo 4: Combina com pesos rotatórios (operação borboleta)
    """
    n = len(x)

    # Caso base: sinal de 1 amostra
    if n == 1:
        return x

    # Separa em índices pares (0,2,4...) e ímpares (1,3,5...)
    # Aqui assume n é sempre potência de 2 (ou é preenchido com zeros)
    even = fft_1d(x[0::2])  # metade dos índices pares
    odd = fft_1d(x[1::2])   # metade dos índices ímpares

    # W_k = e^(-2πi*k/n): rotação no plano complexo
    freqs = np.arange(n // 2)
    W = np.exp(-1j * 2 * np.pi * freqs / n)

    # Passo 3: combina resultados 
    # Primeira metade: even + W*odd
    # Segunda metade: even - W*odd
    return np.concatenate([even + W * odd, even - W * odd])


def ifft_1d(X: np.ndarray) -> np.ndarray:
    """
    ifft_1d — transformada de Fourier inversa 1D: converte frequências de volta para sinal.

    Processo:
    1. Toma conjugado complexo de X
    2. Aplica fft_1d
    3. Toma conjugado complexo do resultado
    4. Divide por n (normalização)

    Resultado: recupera o sinal original do domínio de frequências.
    """
    X = np.asarray(X, dtype=np.complex128)
    n = X.shape[0]
    return np.conj(fft_1d(np.conj(X))) / n


def fft_2d(imagem: np.ndarray) -> np.ndarray:
    """
    fft_2d — transformada de Fourier 2D: converte imagem do domínio espacial para frequências.

    Implementação separável: aplica fft_1d em cada linha, depois em cada coluna.
    Resultado: matriz complexa com componentes de fase e magnitude das frequências.

    Processo:
    1. Aplica fft_1d em cada linha (eixo horizontal)
    2. Aplica fft_1d em cada coluna (eixo vertical)

    Resultado representa a imagem em termos de senos e cossenos de diferentes frequências.
    """
    a = np.asarray(imagem, dtype=np.complex128)
    h, w = a.shape

    # Passo 1: fft_1d em cada linha (processamento horizontal)
    for i in range(h):
        a[i, :] = fft_1d(a[i, :])

    # Passo 2: fft_1d em cada coluna (processamento vertical)
    for j in range(w):
        a[:, j] = fft_1d(a[:, j])

    return a


def ifft_2d(F: np.ndarray) -> np.ndarray:
    """
    ifft_2d — transformada de Fourier inversa 2D: converte espectro de volta para imagem.

    Implementação separável, aplicando ifft_1d em cada dimensão.

    Ordem inversa à fft_2d:
    1. Aplica ifft_1d em cada coluna (eixo vertical) — inverso da segunda etapa
    2. Aplica ifft_1d em cada linha (eixo horizontal) — inverso da primeira etapa

    Resultado: recupera imagem original do domínio de frequências.
    O resultado real deve ser próximo à imagem original (com erro de máquina ~1e-14).
    """
    a = np.asarray(F, dtype=np.complex128).copy()
    h, w = a.shape

    # Passo 1: ifft_1d em cada coluna (primeiro, inverso do segundo passo da fft_2d)
    for j in range(w):
        a[:, j] = ifft_1d(a[:, j])

    # Passo 2: ifft_1d em cada linha (segundo, inverso do primeiro passo da fft_2d)
    for i in range(h):
        a[i, :] = ifft_1d(a[i, :])

    return a


def fftshift2(F: np.ndarray) -> np.ndarray:
    """Centraliza a componente DC no meio da imagem (equivalente a np.fft.fftshift, sem usar numpy.fft)."""
    a = np.asarray(F)
    h, w = a.shape[:2]
    return np.roll(np.roll(a, h // 2, axis=0), w // 2, axis=1)


def ifftshift2(Fs: np.ndarray) -> np.ndarray:
    """Operação inversa de fftshift2."""
    a = np.asarray(Fs)
    h, w = a.shape[:2]
    return np.roll(np.roll(a, -(h // 2), axis=0), -(w // 2), axis=1)


def pad_imagem_para_tamanho(imagem: np.ndarray, h: int, w: int) -> np.ndarray:
    """Preenche com zeros abaixo/direita até (h, w)."""
    img = np.asarray(imagem, dtype=np.float64)
    out = np.zeros((h, w), dtype=np.float64)
    hh, ww = img.shape[:2]
    out[: min(hh, h), : min(ww, w)] = img[: min(hh, h), : min(ww, w)]
    return out


def reconstrucao_parcial_por_raio(
    coeficientes_fft: np.ndarray,
    raio_maximo: float,
) -> np.ndarray:
    """
    Reconstrução parcial: mostra como a imagem aparece usando apenas frequências até um raio.

    Processo:
    1. Centraliza o espectro (fftshift): componentes DC no meio
    2. Cria máscara circular: mantém frequências dentro do raio, zera fora
    3. Aplica máscara: elimina altas frequências além do raio
    4. Descentra (ifftshift): volta para ordem original
    5. Aplica ifft_2d: reconstrói imagem apenas com baixas frequências

    Resultado: quanto menor o raio, mais borrada a imagem (só baixas frequências).
    Quanto maior, mais detalhes finos aparecem (altas frequências).

    Parâmetros:
    - raio_maximo: distância em pixels do centro até a frequência máxima mantida
    """
    # Centraliza DC no meio para cálculo de frequências
    Fs = fftshift2(coeficientes_fft)
    h, w = Fs.shape
    cy, cx = (h - 1) / 2.0, (w - 1) / 2.0

    # Calcula distância euclidiana de cada ponto ao centro (DC)
    yy, xx = np.ogrid[0:h, 0:w]
    dist = np.sqrt((yy - cy) ** 2 + (xx - cx) ** 2)

    # Cria máscara circular: 1 dentro do raio, 0 fora
    masc = (dist <= raio_maximo).astype(np.float64)

    # Aplica máscara: zera todas as frequências além do raio
    Fs_m = Fs * masc

    # Descentra o espectro (volta para ordem original)
    F_back = ifftshift2(Fs_m)

    # Reconstrói a imagem usando a inversa 2D
    recon = np.real(ifft_2d(F_back))
    return recon


def serie_reconstrucoes_baixas_para_altas(
    imagem_padded: np.ndarray,
    num_passos: int = 12,
) -> List[Tuple[float, np.ndarray]]:
    """
    Série de reconstruções: mostra a imagem gradualmente adicionando frequências mais altas.

    Processo:
    1. Calcula fft_2d da imagem
    2. Gera num_passos reconstruções com raios crescentes:
       - Passo 1: apenas as frequências mais baixas (muito borrada)
       - Passo 2-11: vai adicionando mais altas frequências
       - Passo 12: reconstrução completa (todas as frequências)

    Resultado: uma lista de (raio, imagem_reconstruida) que mostra a evolução.

    Útil para:
    - Entender como a imagem é "feita" de frequências
    - Visualizar em 2 frames (parcial 1 e parcial 2) para o relatório
    - Criar animações mostrando a construção progressiva
    """
    # Transforma para domínio de frequências
    F = fft_2d(np.asarray(imagem_padded, dtype=np.complex128))
    h, w = F.shape

    # Raio máximo: distância da origem até o canto (metade da diagonal)
    raio_max = float(np.hypot(h, w) / 2.0)

    saida: List[Tuple[float, np.ndarray]] = []

    # Gera reconstruções com raios crescentes: 1/12, 2/12, ..., 12/12 do raio máximo
    for t in range(num_passos):
        r = raio_max * (t + 1) / num_passos
        saida.append((r, reconstrucao_parcial_por_raio(F, r)))

    return saida


def energia_por_faixa_frequencia(
    coeficientes_fft: np.ndarray,
) -> Tuple[float, float]:
    """
    Retorna (energia_baixa, energia_alta) em torno do DC após fftshift,
    dividindo por mediana do raio (heurística simples para classificar a imagem).
    """
    Fs = fftshift2(coeficientes_fft)
    h, w = Fs.shape
    cy, cx = (h - 1) / 2.0, (w - 1) / 2.0
    yy, xx = np.ogrid[0:h, 0:w]
    dist = np.sqrt((yy - cy) ** 2 + (xx - cx) ** 2)
    raio_med = float(np.median(dist))
    mag = np.abs(Fs) ** 2
    baixa = float(np.sum(mag[dist <= raio_med]))
    alta = float(np.sum(mag[dist > raio_med]))
    return baixa, alta

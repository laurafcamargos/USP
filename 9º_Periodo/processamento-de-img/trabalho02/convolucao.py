"""
Operações de convolução 2D e preenchimento (padding) para a Parte I.

A convolução discreta 2D é implementada explicitamente para fins didáticos:
(I * K)[i,j] = soma_{m,n} I[i+m, j+n] * K[m,n]
com índices válidos após o padding da imagem.
"""

from __future__ import annotations

import numpy as np
from numpy.lib.stride_tricks import sliding_window_view
from typing import Tuple, Literal

try:
    from scipy.ndimage import correlate as _ndimage_correlate
except ImportError:  # pragma: no cover
    _ndimage_correlate = None

ModoPadding = Literal["constant", "edge", "reflect", "symmetric", "wrap"]


def _padding_numpy_para_scipy(modo: ModoPadding) -> str:
    """Mapeia modos do numpy.pad para scipy.ndimage.correlate (mesmo ‘same’ espiritual)."""
    return {
        "constant": "constant",
        "edge": "nearest",
        "reflect": "reflect",
        "symmetric": "mirror",
        "wrap": "wrap",
    }[modo]


def _elementos_janela_convolucao(h: int, w: int, kh: int, kw: int) -> int:
    return int(h * w * kh * kw)


def aplicar_padding(
    imagem: np.ndarray,
    altura_kernel: int,
    largura_kernel: int,
    modo: ModoPadding = "reflect",
    constante: float = 0.0,
) -> Tuple[np.ndarray, Tuple[int, int]]:
    """
    Adiciona borda à imagem para que a convolução 'same' mantenha dimensões.

    Parameters
    ----------
    imagem : array 2D (float ou uint8; será tratada como float na convolução)
    altura_kernel, largura_kernel : dimensões ímpares recomendadas para centragem simétrica
    modo : estilo de preenchimento (numpy.pad)
    constante : valor usado se modo == 'constant'

    Returns
    -------
    imagem_padded, (pad_top, pad_left) — offsets para mapear coordenadas 'same'
    """
    ha, la = imagem.shape[:2]
    # Padding para obter saída do mesmo tamanho da entrada (convolução 'same')
    ph = (altura_kernel - 1) // 2
    pw = (largura_kernel - 1) // 2
    pad_width = ((ph, ph), (pw, pw))

    if modo == "constant":
        padded = np.pad(imagem, pad_width, mode="constant", constant_values=constante)
    else:
        padded = np.pad(imagem, pad_width, mode=modo)

    return padded, (ph, pw)


def convolucao2d(
    imagem: np.ndarray,
    kernel: np.ndarray,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Convolução 2D: aplicar um filtro (kernel) em toda a imagem.

    A convolução desliza o kernel pela imagem e calcula a soma ponderada
    em cada posição. Resultado tem o mesmo tamanho da imagem original (modo 'same').

    Parameters
    ----------
    imagem : 2D ndarray (altura, largura)
    kernel : 2D ndarray (filtro/máscara a aplicar)
    modo_padding : como preencher as bordas:
        - 'constant': preenche com zero (ou constante)
        - 'reflect': espelha a borda
        - 'edge': repete o último pixel
        - 'wrap': enrola (tórico)
    constante_padding : valor preenchimento se modo_padding == 'constant'

    Returns
    -------
    ndarray: imagem filtrada com mesmo shape que entrada
    """
    img = np.asarray(imagem, dtype=np.float64)
    k = np.asarray(kernel, dtype=np.float64)
    kh, kw = k.shape
    h, w = img.shape[:2]

    # Para imagens muito grandes (6000×4000 pixels), alocar tensor de janelas estoura RAM.
    # SciPy é mais eficiente nesses casos. Se houver pouca memória, usa SciPy.
    precisa_scipy = _elementos_janela_convolucao(h, w, kh, kw) > 32_000_000
    if precisa_scipy and _ndimage_correlate is None:
        raise ImportError(
            "Imagem ou kernel grandes demais para o caminho só-NumPy. "
            "Instale scipy (pip install scipy) para convolução 2D sem alocar um tensor gigante."
        )
    usar_scipy = _ndimage_correlate is not None and precisa_scipy

    if usar_scipy:
        # Usa SciPy para imagens grandes (mais eficiente em RAM)
        modo = _padding_numpy_para_scipy(modo_padding)
        return _ndimage_correlate(img, k, mode=modo, cval=float(constante_padding))

    # Caminho NumPy puro: padding + janelas deslizantes + produto escalar
    padded, _ = aplicar_padding(img, kh, kw, modo_padding, constante_padding)
    janelas = sliding_window_view(padded, (kh, kw))
    # einsum: multiplicação elemento-a-elemento eficiente de janelas com kernel
    return np.einsum("ijkl,kl->ij", janelas, k, optimize=True)


def convolucao2d_separavel(
    imagem: np.ndarray,
    kernel_1d: np.ndarray,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """
    Convolução separável com o mesmo kernel 1D nas duas direções (ex.: Gaussiano).
    Ordem: primeiro linhas (eixo 1), depois colunas (eixo 0).
    """
    tmp = convolucao1d_em_eixo(
        imagem, kernel_1d, eixo=1, modo_padding=modo_padding, constante_padding=constante_padding
    )
    return convolucao1d_em_eixo(
        tmp, kernel_1d, eixo=0, modo_padding=modo_padding, constante_padding=constante_padding
    )


def convolucao1d_em_eixo(
    imagem: np.ndarray,
    kernel_1d: np.ndarray,
    eixo: int,
    modo_padding: ModoPadding = "reflect",
    constante_padding: float = 0.0,
) -> np.ndarray:
    """Convolução 1D aplicada a cada linha (eixo=1) ou coluna (eixo=0), vetorizada."""
    k = np.asarray(kernel_1d, dtype=np.float64).ravel()
    kk = k.size
    img = np.asarray(imagem, dtype=np.float64)
    meio = kk // 2

    if eixo == 1:
        pad_width = ((0, 0), (meio, meio))
        if modo_padding == "constant":
            padded = np.pad(img, pad_width, mode="constant", constant_values=constante_padding)
        else:
            padded = np.pad(img, pad_width, mode=modo_padding)
        janelas = sliding_window_view(padded, (1, kk))
        return np.sum(janelas * k.reshape(1, 1, 1, kk), axis=(2, 3))

    pad_width = ((meio, meio), (0, 0))
    if modo_padding == "constant":
        padded = np.pad(img, pad_width, mode="constant", constant_values=constante_padding)
    else:
        padded = np.pad(img, pad_width, mode=modo_padding)
    janelas = sliding_window_view(padded, (kk, 1))
    return np.sum(janelas * k.reshape(1, 1, kk, 1), axis=(2, 3))

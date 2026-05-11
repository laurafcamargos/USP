#!/usr/bin/env python3
"""
Filtros Parte II: Transformada de Fourier Manual e Reconstrução Progressiva

Demonstra:
1. Implementação manual da Transformada de Fourier (sem numpy.fft / scipy.fft)
2. Transformada Inversa de Fourier
3. Visualização progressiva: começando com baixas frequências → altas frequências
4. Comparação entre dois tipos de imagens:
   - Altas frequências: detalhes finos, texturas, mudanças rápidas
   - Baixas frequências: suavidade, variações lentas (céu, paisagem)

  Qualquer imagem pode ser descrita como soma de senos e cossenos de diferentes
  frequências. A Transformada de Fourier nos mostra quanto de cada frequência
  está presente. Reconstruindo com apenas as baixas frequências obtemos uma
  versão muito borrada; adicionando mais frequências, os detalhes aparecem.
"""

from __future__ import annotations

import os
import numpy as np
import matplotlib.pyplot as plt

from fourier_parte2 import (
    fft_2d,
    ifft_2d,
    fftshift2,
    proxima_potencia_de_2,
    pad_imagem_para_tamanho,
    serie_reconstrucoes_baixas_para_altas,
    energia_por_faixa_frequencia,
)
from imagens_io import (
    carregar_imagem_caminho,
    para_cinza,
    redimensionar_max_lado,
)


# ============================================================================
# PARÂMETROS
# ============================================================================

_IMAGEM_ALTA_FREQ = "kristian-lovstad-xplrF8WMitE-unsplash.jpg"
_IMAGEM_BAIXA_FREQ = "jenna-duffy-eG8EXvfTBU8-unsplash.jpg"
_MAX_LADO_FOURIER = 512


# ============================================================================
# 1. ANÁLISE ESPECTRAL
# ============================================================================

def analisar_espectro(
    imagem_cinza: np.ndarray,
    titulo: str,
) -> tuple:
    """
    Transforma para domínio de frequências e analisa.

    Retorna:
      (F, F_shifted, energia_baixa, energia_alta, h2, w2)
    """
    h_orig, w_orig = imagem_cinza.shape[:2]
    h2, w2 = proxima_potencia_de_2(h_orig), proxima_potencia_de_2(w_orig)
    padded = pad_imagem_para_tamanho(imagem_cinza, h2, w2)

    F = fft_2d(padded.astype(np.complex128))
    F_shifted = fftshift2(F)
    energia_baixa, energia_alta = energia_por_faixa_frequencia(F)

    return F, F_shifted, energia_baixa, energia_alta, h2, w2


# ============================================================================
# 2. RECONSTRUÇÃO PROGRESSIVA
# ============================================================================

def criar_figura_reconstrucao(
    imagem_cinza: np.ndarray,
    F: np.ndarray,
    titulo: str,
    prefixo: str,
    saida_dir: str,
    idx1: int = 2,
    idx2: int = 8,
) -> None:
    """
    Figura com espectro + 2 reconstruções parciais + original + completa.

    Mostra a imagem sendo formada progressivamente adicionando frequências.
    """
    h_orig, w_orig = imagem_cinza.shape[:2]
    h2, w2 = F.shape[:2]

    # Série de reconstruções
    img_padded = pad_imagem_para_tamanho(imagem_cinza, h2, w2)
    serie = serie_reconstrucoes_baixas_para_altas(img_padded, num_passos=15)
    raio_max = float(np.hypot(h2, w2) / 2.0)

    idx1 = max(0, min(len(serie) - 1, idx1))
    idx2 = max(0, min(len(serie) - 1, idx2))

    r1, partial1 = serie[idx1]
    r2, partial2 = serie[idx2]
    _, completa = serie[-1]

    def crop(img):
        return img[:h_orig, :w_orig]

    # Figura 2x3
    fig, axes = plt.subplots(2, 3, figsize=(14, 9))

    # 0,0: Espectro
    F_shifted = fftshift2(F)
    ax = axes[0, 0]
    spec = np.log1p(np.abs(F_shifted))
    ax.imshow(spec, cmap="hot")
    ax.set_title("Espectro de Fourier\nlog(1 + |coef.|)", fontsize=10, fontweight='bold')
    ax.axis("off")

    # 0,1: Parcial 1 (baixas freq)
    ax = axes[0, 1]
    ax.imshow(crop(partial1), cmap="gray")
    pct = 100 * r1 / raio_max
    ax.set_title(f"Parcial 1: Baixas Freq\n({pct:.0f}% do raio máx.)", fontsize=10, fontweight='bold')
    ax.axis("off")

    # 0,2: Parcial 2 (freq intermediárias)
    ax = axes[0, 2]
    ax.imshow(crop(partial2), cmap="gray")
    pct = 100 * r2 / raio_max
    ax.set_title(f"Parcial 2: Intermediárias\n({pct:.0f}% do raio máx.)", fontsize=10, fontweight='bold')
    ax.axis("off")

    # 1,0: Original
    ax = axes[1, 0]
    ax.imshow(imagem_cinza, cmap="gray")
    ax.set_title("Original", fontsize=10, fontweight='bold')
    ax.axis("off")

    # 1,1: Completa
    ax = axes[1, 1]
    ax.imshow(crop(completa), cmap="gray")
    ax.set_title("Reconstrução Completa", fontsize=10, fontweight='bold')
    ax.axis("off")

    # 1,2: Info
    ax = axes[1, 2]
    ax.axis("off")
    info = (
        "Transformada de Fourier\n\n"
        "• Imagem = soma de senos/cossenos\n"
        "• Baixas freq: padrões suaves\n"
        "• Altas freq: detalhes/texturas\n"
        "• Começamos borrado, vamos\n"
        "  adicionando freq até original"
    )
    ax.text(0.05, 0.95, info, transform=ax.transAxes,
            fontsize=9, verticalalignment='top', family='monospace',
            bbox=dict(boxstyle='round', facecolor='wheat', alpha=0.7))

    fig.suptitle(f"{titulo}\nFormação da Imagem: Adicionando Frequências", fontsize=12, fontweight='bold')
    path = os.path.join(saida_dir, f"{prefixo}_reconstrucao.png")
    fig.savefig(path, dpi=150, bbox_inches="tight")
    plt.close(fig)
    print(f"  ✓ {path}")


# ============================================================================
# MAIN
# ============================================================================

def main() -> None:
    base = os.path.dirname(__file__)
    saida = os.path.join(base, "saida", "parte2")
    os.makedirs(saida, exist_ok=True)

    # Imagem 1: Altas frequências
    img_alta = redimensionar_max_lado(
        para_cinza(carregar_imagem_caminho(os.path.join(base, _IMAGEM_ALTA_FREQ))),
        _MAX_LADO_FOURIER
    )
    F_alta, _, _, _, _, _ = analisar_espectro(img_alta, "")
    criar_figura_reconstrucao(img_alta, F_alta, "Altas Frequências", "01_altas", saida, idx1=3, idx2=10)

    # Imagem 2: Baixas frequências
    img_baixa = redimensionar_max_lado(
        para_cinza(carregar_imagem_caminho(os.path.join(base, _IMAGEM_BAIXA_FREQ))),
        _MAX_LADO_FOURIER
    )
    F_baixa, _, _, _, _, _ = analisar_espectro(img_baixa, "")
    criar_figura_reconstrucao(img_baixa, F_baixa, "Baixas Frequências", "02_baixas", saida, idx1=1, idx2=5)

    print("✓ Figuras geradas em saida/parte2/")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
Script da Parte I: gera figuras dos filtros convolucionais em `saida/parte1/`.
"""

from __future__ import annotations

import os

import matplotlib.pyplot as plt
import numpy as np

from filtros_parte1 import (
    ModoPadding,
    filtro_caixa_media,
    filtro_emboss_criativo,
    filtro_gaussiano,
    filtro_laplace,
    filtro_shift,
    filtro_sobel_gradientes,
    filtro_sobel_magnitude,
    nitidez_laplace,
    nitidez_mascara_desnitidez,
    normalizar_visualizacao,
)
from imagens_io import carregar_imagem_caminho, para_cinza, redimensionar_max_lado, salvar_cinza

_MAX_LADO = 2048
_IMAGEM_CAMPO = "izuddin-helmi-adnan-K5ChxJaheKI-unsplash.jpg"


def _carregar_imagem() -> np.ndarray:
    """Carrega a imagem do campo de futebol."""
    caminho = os.path.join(os.path.dirname(__file__), _IMAGEM_CAMPO)
    img = para_cinza(carregar_imagem_caminho(caminho))
    return redimensionar_max_lado(img, _MAX_LADO)


def _dir_saida() -> str:
    """Cria diretório de saída se necessário."""
    d = os.path.join(os.path.dirname(__file__), "saida", "parte1")
    os.makedirs(d, exist_ok=True)
    return d


def demonstrar_padding(imagem: np.ndarray, saida: str) -> None:
    """Compara modos de padding no filtro Gaussiano (bom para bordas)."""
    modos: list[ModoPadding] = ["constant", "edge", "reflect", "wrap"]
    fig, axes = plt.subplots(1, len(modos), figsize=(16, 5))
    img_f = imagem.astype(np.float64)
    for ax, modo in zip(axes, modos):
        r = filtro_gaussiano(img_f, sigma=4.0, modo_padding=modo, constante_padding=0.0)
        ax.imshow(np.clip(r, 0, 255), cmap="gray")
        ax.set_title(f"padding={modo}", fontsize=11)
        ax.axis("off")
    fig.suptitle("PD: impacto do padding", fontsize=12)
    fig.tight_layout()
    path = os.path.join(saida, "padding_gaussiano.png")
    fig.savefig(path, dpi=150, bbox_inches="tight")
    plt.close(fig)
    print(f"Salvo: {path}")


def rodar_todos_os_filtros(imagem: np.ndarray, saida: str) -> None:
    img = imagem.astype(np.float64)

    resultados = [
        ("01_original", imagem),
        ("02_shift", np.clip(filtro_shift(img, 0, 8), 0, 255).astype(np.uint8)),
        ("03_caixa", np.clip(filtro_caixa_media(img, 9), 0, 255).astype(np.uint8)),
        ("04_gaussiano", np.clip(filtro_gaussiano(img, sigma=2.0), 0, 255).astype(np.uint8)),
        ("05_laplace", normalizar_visualizacao(filtro_laplace(img))),
        ("06_sobel_mag", normalizar_visualizacao(filtro_sobel_magnitude(img))),
    ]
    for nome, im in resultados:
        salvar_cinza(os.path.join(saida, f"{nome}.png"), im)

    gx, gy = filtro_sobel_gradientes(img)
    salvar_cinza(os.path.join(saida, "06b_sobel_gx.png"), normalizar_visualizacao(gx))
    salvar_cinza(os.path.join(saida, "06c_sobel_gy.png"), normalizar_visualizacao(gy))

    sharp_l = nitidez_laplace(img, lambda_laplace=0.7)
    salvar_cinza(os.path.join(saida, "07_nitidez_laplace.png"), np.clip(sharp_l, 0, 255).astype(np.uint8))

    sharp_u = nitidez_mascara_desnitidez(img, sigma_desfoque=2.5, quantidade=1.2)
    salvar_cinza(os.path.join(saida, "08_nitidez_unsharp.png"), np.clip(sharp_u, 0, 255).astype(np.uint8))

    emb = filtro_emboss_criativo(img)
    salvar_cinza(os.path.join(saida, "09_emboss_criativo.png"), normalizar_visualizacao(emb))

    print("Imagens da Parte I salvas em:", saida)


def main() -> None:
    img = _carregar_imagem()
    print(f"Imagem carregada: {img.shape[1]}×{img.shape[0]} px")
    saida = _dir_saida()
    rodar_todos_os_filtros(img, saida)
    demonstrar_padding(img, saida)


if __name__ == "__main__":
    main()

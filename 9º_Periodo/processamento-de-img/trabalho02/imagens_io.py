"""Leitura de imagens em escala de cinza ou RGB — uma função por finalidade."""

from __future__ import annotations

import numpy as np
from PIL import Image


def carregar_imagem_caminho(caminho: str) -> np.ndarray:
    """Carrega imagem (RGB ou L) como ndarray uint8."""
    with Image.open(caminho) as im:
        return np.array(im.convert("RGB") if im.mode not in ("L", "1") else im.convert("L"))


def para_cinza(imagem: np.ndarray) -> np.ndarray:
    """Converte RGB para cinza (ponderação BT.601)."""
    x = np.asarray(imagem)
    if x.ndim == 2:
        return x
    r, g, b = x[..., 0].astype(np.float64), x[..., 1].astype(np.float64), x[..., 2].astype(np.float64)
    return np.clip(0.299 * r + 0.587 * g + 0.114 * b, 0, 255).astype(np.uint8)


def redimensionar_max_lado(imagem_cinza: np.ndarray, max_lado: int) -> np.ndarray:
    """
    Reduz a maior dimensão para no máximo `max_lado`, mantendo proporção (LANCZOS).
    Útil para fotos em resolução cheia (ex. Unsplash), para processar mais rápido e caber na RAM.
    """
    x = np.asarray(imagem_cinza)
    if x.ndim != 2:
        raise ValueError("Esperada imagem 2D em escala de cinza.")
    h, w = x.shape
    m = max(h, w)
    if m <= max_lado:
        return x
    escala = max_lado / float(m)
    nw = max(1, int(round(w * escala)))
    nh = max(1, int(round(h * escala)))
    img = Image.fromarray(np.clip(x, 0, 255).astype(np.uint8), mode="L")
    img = img.resize((nw, nh), Image.Resampling.LANCZOS)
    return np.array(img, dtype=np.uint8)


def salvar_cinza(caminho: str, imagem_cinza: np.ndarray) -> None:
    """Salva ndarray 2D como PNG."""
    Image.fromarray(np.clip(imagem_cinza, 0, 255).astype(np.uint8), mode="L").save(caminho)

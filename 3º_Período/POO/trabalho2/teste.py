import matplotlib.pyplot as plt
import numpy as np
from scipy.special import comb

n = 5
p = 1/2

k = np.arange(0, n+1)
fmp = comb(n, k) * p**k * (1-p)**(n-k)
fda = np.cumsum(fmp)

# Gráfico da f.m.p
plt.subplot(1, 2, 1)
plt.bar(k, fmp)
plt.xlabel('k')
plt.ylabel('P(X = k)')
plt.title('Função de Massa de Probabilidade (f.m.p)')

# Gráfico da f.d.a
plt.subplot(1, 2, 2)
plt.plot(k, fda, marker='o', linestyle='-', drawstyle='steps-post')
plt.xlabel('k')
plt.ylabel('F(X ≤ k)')
plt.title('Função de Distribuição Acumulada (f.d.a)')

plt.tight_layout()
plt.show()

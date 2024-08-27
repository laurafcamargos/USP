import math

v = [6.6,2.1] #declaração do vetor velocidade 

for i in range (2):
    print(f"Componente {i+1}: {v[i]}")

modulo_r12 = math.sqrt(sum([component ** 2 for component in v])) #cálculo do módulo

print(f"Módulo do vetor separação: {modulo_r12:.1f}")

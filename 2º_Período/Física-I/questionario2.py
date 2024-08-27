import numpy as np

#Parâmetros fornecidos
amplitude = 3.2
frequencia_angular = 2
constante_b = 1.9
tempo = 2.8

#Derivada primeira para obter os componentes do vetor velocidade
velocidade_x = -amplitude * frequencia_angular * np.sin(frequencia_angular * tempo)  # Derivada de x(t)
velocidade_y = amplitude * frequencia_angular * np.cos(frequencia_angular * tempo)    # Derivada de y(t)
velocidade_z = 2 * constante_b * tempo                                               # Derivada de z(t)

#Cálculo do módulo do vetor velocidade
modulo_velocidade = np.sqrt(velocidade_x**2 + velocidade_y**2 + velocidade_z**2)

#Resultado arredondado para uma casa decimal
print("{:.1f}".format(modulo_velocidade))

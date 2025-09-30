/* 
Dupla:
Arthur Domingues Rios - 13731751
Laura Fernandes Camargos - 13692334

O programa verifica se o número é maior que zero, menor que zero ou nulo, e retorna, respectivamente, positivo, negativo ou zero. 
Para melhorar o programa, pode-se adicionar cortes nos finais da primeira e segunda linha, além de trocar a , ficando da seguinte maneira: */

classe(Numero, positivo) :- Numero > 0, !.
classe(Numero, negativo) :- Numero < 0, !.
classe(0, zero). 

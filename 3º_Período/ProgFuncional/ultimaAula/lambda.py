def f(x):
    global d #não é uma boa solução
    d += 1
    return x + 1

a = [3,4,5,2,0,-1]

b = map(f,a) #aplica a funcao f em cada elemento da lista a
d = 0
c = filter(lambda x: x % 2 == 0, map(lambda x : f(x),a)) #filtra qual é par da lista 

print(list(a))
print(list(b))
print(list(c))
print(d) 
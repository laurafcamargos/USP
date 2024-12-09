Ideia geral:
def dfs(u):
    visitados[u] = true
    tamanho = 1
    para cada v em G[u]:
        se não visitados[v]:
            tamanho += dfs(v)
    retornar tamanho

# Inicialização
componentes = 0
maior_componente = 0
para i de 1 até n:
    se não visitados[i]:
        componentes += 1
        tamanho_componente = dfs(i)
        maior_componente = max(maior_componente, tamanho_componente)


Disjoint sets union find (ED)

Componentes (G, n)
1 c := n
2 Initialize ( )
3 para cada aresta uv de G
4 r := Find (u)
5 s := Find (v)
6 se r ≠ s
7 Union (r, s)
8 c := c − 1
9 devolva c


Initialize-1 ( )
1 para cada vértice v
2 dir[v] := v

Union-1 (r, s)  ▷ r ≠ s
1 para cada vértice v
2 se dir[v] = r
3 dir[v] := s

union fica O(n) no pior caso

segunda implementação:

Para tornar o operação Union mais rápida, vamos introduzir a ideia de "superior imediato", 
ou "chefe", na hierarquia corporativa. Imagine que cada vértice de uma componente tem um chefe, 
que é um outro vértice da mesma componente. Cada chefe, por sua vez, tem um chefe, e assim por 
diante, até chegar a um vértice que é chefe dele mesmo. Essa ideia precisa ser implementada de 
tal modo que um único vértice de cada componente seja chefe dele mesmo; esse vértice faz o papel
de diretor da componente. 
---------------------------------------------------
Initialize-2 ( )
1 para cada vértice v
2 chefe[v] := v

Find-2 (v)
1 enquanto chefe[v] ≠ v
2 v := chefe[v]
3 devolva v

Union-2 (r, s)  ▷ r ≠ s
1 chefe[r] := s

-----------------------------------------
Terceira implementação: union-by-rank
Union-3 (r, s)  ▷ union-by-rank; r ≠ s
1 se alt[r] > alt[s]
2 chefe[s] := r
3 senão chefe[r] := s
4 se alt[r] = alt[s]
5 alt[s] := alt[r] + 1

No início do processo, antes que a primeira aresta seja inserida, o altura de cada vértice é 0:
Initialize-3 ( )
1 para cada vértice v
2 chefe[v] := v
3 alt[v] := 0 

A implementação Find-3 é idêntica à Find-2. 
O consumo de tempo de Find-2 é proporcional à profundidade de v e portanto, no pior caso, proporcional ao máximo das alturas dos diretores. 
Infelizmente, a altura de um diretor pode chegar a n-1. Portanto, o algoritmo Find-2 é lento. 
int find(int i) {
    if(p[i] == i) return i;
    return find(p[i]);
}
/*
Dupla:
Arthur Domingues Rios - 13731751
Laura Fernandes Camargos - 13692334

a) A solução que nós usaríamos é a utilização de um grafo dirigido. Nesse modelo, cada vértice do grafo representaria uma cidade, e as arestas direcionadas representariam a existência de uma linha de ônibus direta entre as cidades. A escolha se deu porque a presença de uma linha de uma cidade A para uma cidade B não garante a existência de uma linha de volta, por exemplo. O problema, então, se resume a encontrar um caminho entre dois vértices do grafo, o que pode ser resolvido com algoritmos de busca, como DFS.
*/

b) 
% Araraquara
linha_direta(araraquara, saocarlos).

% Barretos
linha_direta(barretos, franca).

% Bauru
linha_direta(bauru, botucatu).

% Botucatu
linha_direta(botucatu, sorocaba).

% Franca
linha_direta(franca, ribeiraopreto).

% Marília
linha_direta(marilia, bauru).

% Ribeirão Preto
linha_direta(ribeiraopreto, araraquara).

% São Carlos
linha_direta(saocarlos, bauru).

c) 

%predicados

pertence(Cabeca, [Cabeca|Cauda]).
pertence(Cabeca,  [OutraCabeca|Cauda]) :-  pertence(Cabeca, Cauda).


viagemEntre(Origem, Destino) :- existeCaminho(Origem, Destino, [Origem]).

existeCaminho(Origem, Destino,_) :- linha_direta(Origem, Destino).

existeCaminho(Origem, Destino, Visitados) :- linha_direta(Origem, ProximaParada),
    \+ pertence(ProximaParada, Visitados), %a próxima parada ProximaParada não pode ser um membro da lista de cidades já Visitados
    existeCaminho(ProximaParada, Destino, [ProximaParada|Visitados]).

d) 
%predicados

pertence(Cabeca, [Cabeca|Cauda]).
pertence(Cabeca,  [OutraCabeca|Cauda]) :-  pertence(Cabeca, Cauda).


viagemEntre(Origem, Destino) :- existeCaminho(Origem, Destino, [Origem]).

idaeVolta(A, B) :- linha_direta(A, B), !.
idaeVolta(A, B) :- linha_direta(B, A).

existeCaminho(Origem, Destino, _) :- idaeVolta(Origem, Destino).
existeCaminho(Origem, Destino, Visitados) :- idaeVolta(Origem, ProximaParada),
    \+ pertence(ProximaParada, Visitados), %a próxima parada ProximaParada não pode ser um membro da lista de cidades já Visitados
    existeCaminho(ProximaParada, Destino, [ProximaParada|Visitados]).

% Sim, é melhor usar o corte, uma vez que ele evita a busca redundante. Sem ele, para a consulta idaeVolta(araraquara, saocarlos), o prolog primeiro encontra uma resposta na regra linha_direta(araraquara, saocarlos) e a retorna. No entanto, por causa do backtracking, ele tenta a segunda regra também, buscando por linha_direta(saocarlos, araraquara). Se este fato não existir como um fato, a busca da segunda regra falha, mas o processo como um todo já encontrou uma resposta válida e não falha.   

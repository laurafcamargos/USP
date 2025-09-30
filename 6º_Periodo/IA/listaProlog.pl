
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
%predicados

pertence(Cabeca, [Cabeca|Cauda]).
pertence(Cabeca,  [OutraCabeca|Cauda]) :-  pertence(Cabeca, Cauda).

viagemEntre(Origem, Destino) :- existeCaminho(Origem, Destino, [Origem]).
idaeVolta(A, B) :- linha_direta(X, Y), !.
idaeVolta(A, B) :- linha_direta(Y, X).

existeCaminho(Origem, Destino,_) :- idaeVolta(Origem, Destino).
existeCaminho(Origem, Destino, Visitados) :- idaeVolta(Origem, ProximaParada),
    \+ pertence(ProximaParada, Visitados), %a próxima parada ProximaParada não pode ser um membro da lista de cidades já Visitados
    existeCaminho(ProximaParada, Destino, [ProximaParada|Visitados]).









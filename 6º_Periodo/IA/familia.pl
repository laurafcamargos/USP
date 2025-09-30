%Laura Fernandes Camargos 13692334

%Fatos

/*genero*/
%Fatos

/*genero*/
mulher(maria_perpetua).
mulher(fabiana).
mulher(ana_luiza).
mulher(laura).
mulher(danielle).
mulher(alice).
homem(elcio).
homem(elcio_jr).
homem(luiz_miguel).
homem(paulo).

/*genitor*/
genitor(maria_perpetua, elcio_jr).
genitor(maria_perpetua, fabiana).
genitor(elcio, fabiana).
genitor(elcio, elcio_jr).
genitor(fabiana, ana_luiza).
genitor(fabiana, laura).
genitor(elcio_jr, luiz_miguel).
genitor(elcio_jr, alice).
genitor(danielle, luiz_miguel).
genitor(danielle, alice).


/*conjuges*/
casados(elcio, maria_perpetua).
casados(elcio_jr, danielle).

%Regras
mae(X, Y) :-
    mulher(X),
    genitor(X, Y).

pai(X, Y) :-
    homem(X),
    genitor(X, Y).

avo(X, Z) :-
    pai(X, Y),
    genitor(Y, Z).

avo(X, Z) :-
    mae(X, Y),
    genitor(Y, Z).

irmaos(X, Y) :-
    pai(Z, X), pai(Z, Y),
    mae(W, X), mae(W, Y),
    X \= Y. 

tio(X, Z) :-
    genitor(Y, Z),
    irmaos(Y, X),
    homem(X).

tia(X, Z) :-
    genitor(Y, Z),
    irmaos(Y, W),
    casados(W, X),
    mulher(X),
    genitor(Y, Z).

primos(X, Y) :-
    genitor(Z, X),
    genitor(W, Y),
    irmaos(Z, W),
    X \= Y.              

conjuges(X, Y) :-
    casados(X, Y);
    casados(Y, X).

marido(X, Y) :-
    conjuges(X, Y),
    homem(X).

esposa(X, Y) :-
    conjuges(Y, X),
    mulher(X).
    
/*:
 * avo(X, luiz_miguel).
 * tia(danielle, ana_luiza).
 * marido(Marido, fabiana), pai(Sogro, Marido).
 * primos(laura, Y).
 * tio(X, Y).
 * irmaos(X, Y).
 * primos(X, Y), homem(X), mulher(Y).
 * */

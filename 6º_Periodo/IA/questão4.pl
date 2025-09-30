
/*

Dupla:
Arthur Domingues Rios - 13731751
Laura Fernandes Camargos - 13692334

I. Desenvolva programas que informem:

A. a média de prova de um aluno, tendo a p1 peso 2 e a p2 peso 3 e considerando
a possibilidade da sub. */

media_prova(aluno(_, _, _, _, _, P1, _, P2, Sub, _, _), Media) :-
	P1 < 5,
	P2 >= 5,
	Sub > P1,
    Media is (2 * Sub + 3 * P2) / 5.

media_prova(aluno(_, _, _, _, _, P1, _, P2, Sub, _, _), Media) :-
	P1 >= 5,
	P2 < 5,
	Sub > P2,
    Media is (2 * P1 + 3 * Sub) / 5.

media_prova(aluno(_, _, _, _, _, P1, _, P2, Sub, _, _), Media) :-
    Media is (2 * P1 + 3 * P2) / 5.

/* B. a média de trabalho de um aluno, tendo o t1 peso 1 e o t2 peso 3.
R: */

media_trabalho(aluno(_, _, _, _, T1, _, T2, _, _, _, _), Media) :-
	Media is (T1 + 3 * T2) / 4.

/* C. a média final de um aluno, considerando a situação antes da rec.
R: Considerando que o peso dos trabalhos e das provas são iguais: */

media_final(aluno(_, _, _, _, T1, P1, T2, P2, Sub, _, _), Media) :-
	media_prova(aluno(_, _, _, _, T1, P1, T2, P2, Sub, _, _), MP),
	media_trabalho(aluno(_, _, _, _, T1, P1, T2, P2, Sub, _, _), MT),
	Media is (MP + MT) / 2.


/* D. se o aluno foi aprovado ou reprovado, considerando a situação antes da rec.
R: */

situacao(aluno(_, _, _, _, T1, P1, T2, P2, Sub, _, Freq), aprovado) :-
    media_final(aluno(_, _, _, _, T1, P1, T2, P2, Sub, _, Freq), Media),
    Media >= 5,
    Freq >= 70.

situacao(aluno(_, _, _, _, T1, P1, T2, P2, Sub, _, Freq), reprovado) :-
    media_final(aluno(_, _, _, _, T1, P1, T2, P2, Sub, _, Freq), Media),
    (Media < 5 ; Freq < 70).

% II. Mostre as interrogações (e os resultados) para determinar:

% A. Quem tirou 10 na p1 e na p2?
?- aluno(nome, _, _, _, _, 10, _, 10, _, _, _).

% B. Quem tirou 10 no t1 e no t2?
?- aluno(nome, _, _, _, 10, _, 10, _, _, _, _).

% C. Quem ficou com nota abaixo da média (abaixo de 5), nas duas provas? (p1<5 e p2<5).
?- aluno(nome, _, _, _, _, p1, _, p2, _, _, _), p1 < 5, p2 < 5.

% D. Quem ficou com presença abaixo de 70%?
?- aluno(nome, _, _, _, _, _, _, _, _, _, freq), freq < 70.

% E. Quais foram os alunos reprovados?
?- situacao(aluno(nome, _, _, _, _, _, _, _, _, _, _), reprovado).

% F. Quais foram os alunos aprovados?
?- situacao(aluno(nome, _, _, _, _, _, _, _, _, _, _), aprovado).

/* III. Indique as alterações necessárias na estrutura aluno para que seja possível fazer as seguintes interrogações:

A. Quais são as informações dos alunos cujo primeiro nome é X?
R: Ao invés de ter apenas nome na estrutura, deve-se colocar nome e sobrenome, assim podendo verificar o primeiro nome separadamente.

B. Quais são as informações dos alunos cujo sobrenome é X?
R: A mesma mudança da questão “A”, já que assim o sobrenome pode ser verificado de maneira separada do nome.

C. Quem são os alunos nascidos no ano X?
R: A data deve ser separada em dia, mês e ano, assim sendo possível checar apenas o ano de nascimento do aluno.

D. Quem são os alunos cujo CEP é X?
R: O endereço pode ser ampliado e dividido em outras partes, como Rua, Bairro, Complemento, Número, etc, e entre esses campos, deve existir CEP.

E. Qual o número da casa do aluno X?
R: A mesma mudança da questão “D”, já que com isso o número da casa do aluno pode ser acessado diretamente. */

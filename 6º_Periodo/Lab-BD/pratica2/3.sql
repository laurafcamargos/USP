--3. Selecionar todos os eventos que alguma vez já tiveram disputas em locais com capacidade maior do que 50.000 pessoas.
--a) versão 1: apenas usando junção
SELECT D.PAIS1, D.PAIS2, D.VENCEDOR, D.DATA_HORA, D.MODALIDADE
FROM DISPUTA D JOIN LOCAL L ON D.LOCAL = L.ID
WHERE L.CAPACIDADE > 50000;

--b) versão 2: com consultas aninhadas correlacionadas (EXISTS)
SELECT D.PAIS1, D.PAIS2, D.VENCEDOR, D.DATA_HORA, D.MODALIDADE
FROM DISPUTA D
WHERE EXISTS (
    SELECT L.NOME, L.CAPACIDADE
    FROM LOCAL L
    WHERE L.ID = D.LOCAL AND L.CAPACIDADE > 50000
);

--c) versão 3: com consultas aninhadas não correlacionadas (IN)
SELECT D.PAIS1, D.PAIS2, D.VENCEDOR, D.DATA_HORA, D.MODALIDADE
FROM DISPUTA D
WHERE D.LOCAL IN (
    SELECT L.ID 
    FROM LOCAL L 
    WHERE L.CAPACIDADE > 50000
);

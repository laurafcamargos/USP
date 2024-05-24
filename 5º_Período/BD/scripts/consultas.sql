------------------------------------------------------------------------------------------------
-- |                               5 QUERYS REALIZADAS NA BASE DO PLANETDATA                   | --
------------------------------------------------------------------------------------------------

-- Consulta que calcula a m�dia das idades dos planetas por sistema planet�rio(subconsulta),
-- considerando apenas os sistemas planet�rios com pelo menos 2 planetas.
SELECT M�DIA_SISTEMAS.NOME, AVG(M�DIA_SISTEMAS.MEDIA_IDADE) AS MEDIA_GERAL
FROM (
    SELECT SP.NOME, AVG(P.IDADE) AS MEDIA_IDADE
    FROM SISTEMA_PLANETARIO SP
    JOIN PLANETA P ON SP.NOME = P.SISTEMA_PLANETARIO--agrupa os planetas por sistema planet�rio
    GROUP BY SP.NOME
    HAVING COUNT(*) >= 2
) M�DIA_SISTEMAS
GROUP BY M�DIA_SISTEMAS.NOME --agrupa os resultados da consulta principal pelo nome do sistema planet�rio
ORDER BY MEDIA_GERAL DESC; --ordena pela maior m�dia (decrescente) 

----------------------------------------------------------------------------------------------------------------

--Consulta para obter o nome de todos os tripulantes que participam de todas as miss�es que o tripulante jo�o silva participa

SELECT T.NOME
FROM TRIPULANTE T JOIN PARTICIPA P ON T.ID_ESPACIAL = P.TRIPULANTE
WHERE T.NOME <> 'JO�O SILVA' --seleciona o tripulante diferente do pr�prio jo�o silva e que n�o esteja 
AND NOT EXISTS (    	     --participando de alguma miss�o que o jo�o silva n�o participa
    SELECT P.MISSAO  --c�digo de todas as miss�es que o jo�o silva participa
    FROM PARTICIPA P
    JOIN TRIPULANTE T ON P.TRIPULANTE = T.ID_ESPACIAL
    WHERE T.NOME = 'JO�O SILVA' 

    MINUS

    SELECT P.MISSAO  --c�digo de todas as miss�es que algum tripulante participa
    FROM PARTICIPA P
    WHERE P.TRIPULANTE = T.ID_ESPACIAL 
);
----------------------------------------------------------------------------------------------------------------

--Consulta que conta o n�mero de observa��es por ano dos planetas que possuem algum sat�lite natural

SELECT P.NOME AS NOME_PLANETA, EXTRACT(YEAR FROM O.DATA) AS ANO_OBSERVACAO, COUNT(O.ID) AS NUMERO_OBSERVACOES
FROM  PLANETA P 
JOIN OBSERVACAO O ON P.NOME = O.PLANETA
WHERE P.NOME IN ( --subconsulta que retorna os nomes dos planetas que possuem sat�lites naturais
        SELECT SN.PLANETA
        FROM SATELITES_NATURAIS SN
      )
GROUP BY P.NOME, EXTRACT(YEAR FROM O.DATA); --agrupa os resultados pelo nome do planeta e pelo ano da observa��o
----------------------------------------------------------------------------------------------------------------

--Consulta que retorna a m�dia do tempo de dura��o das miss�es terminadas por planeta

SELECT P.SISTEMA_PLANETARIO, P.NOME, AVG(M.DURACAO) AS MEDIA_DURACAO
FROM MISSAO M JOIN TAREFA T ON M.CODIGO = T.CODIGO
JOIN PLANETA P ON M.PLANETA = P.NOME AND M.SISTEMA_PLANETARIO = P.SISTEMA_PLANETARIO
WHERE M.STATUS = 'TERMINADA'
GROUP BY P.SISTEMA_PLANETARIO,P.NOME;
----------------------------------------------------------------------------------------------------------------

--Consulta que retorna todos os recursos naturais do tipo atmosfera que n�o est�o presentes no sistema solar

SELECT NUM_CATALOGACAO, PRESSAO, COMPOSICAO, TEMPERATURA
FROM ATMOSFERA 

MINUS

SELECT A.NUM_CATALOGACAO, A.PRESSAO, A.COMPOSICAO, A.TEMPERATURA
FROM ATMOSFERA A
JOIN RECURSO_NATURAL RN ON RN.NUM_CATALOGACAO = A.NUM_CATALOGACAO
JOIN POSSUI P ON P.RECURSO_NATURAL = RN.NUM_CATALOGACAO --recursos do tipo atmosfera que est�o presente no sistema solar
WHERE P.SISTEMA_PLANETARIO = 'SISTEMA SOLAR';


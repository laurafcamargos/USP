------------------------------------------------------------------------------------------------
-- |                               5 QUERYS REALIZADAS NA BASE DO PLANETDATA                   | --
------------------------------------------------------------------------------------------------

-- Consulta que calcula a média das idades dos planetas por sistema planetário(subconsulta),
-- considerando apenas os sistemas planetários com pelo menos 2 planetas.
SELECT MÉDIA_SISTEMAS.NOME, AVG(MÉDIA_SISTEMAS.MEDIA_IDADE) AS MEDIA_GERAL
FROM (
    SELECT SP.NOME, AVG(P.IDADE) AS MEDIA_IDADE
    FROM SISTEMA_PLANETARIO SP
    JOIN PLANETA P ON SP.NOME = P.SISTEMA_PLANETARIO--agrupa os planetas por sistema planetário
    GROUP BY SP.NOME
    HAVING COUNT(*) >= 2
) MÉDIA_SISTEMAS
GROUP BY MÉDIA_SISTEMAS.NOME --agrupa os resultados da consulta principal pelo nome do sistema planetário
ORDER BY MEDIA_GERAL DESC; --ordena pela maior média (decrescente) 

----------------------------------------------------------------------------------------------------------------

--Consulta para obter o nome de todos os tripulantes que participam de todas as missões que o tripulante joão silva participa

SELECT T.NOME
FROM TRIPULANTE T JOIN PARTICIPA P ON T.ID_ESPACIAL = P.TRIPULANTE
WHERE T.NOME <> 'JOÃO SILVA' --seleciona o tripulante diferente do próprio joão silva e que não esteja 
AND NOT EXISTS (    	     --participando de alguma missão que o joão silva não participa
    SELECT P.MISSAO  --código de todas as missões que o joão silva participa
    FROM PARTICIPA P
    JOIN TRIPULANTE T ON P.TRIPULANTE = T.ID_ESPACIAL
    WHERE T.NOME = 'JOÃO SILVA' 

    MINUS

    SELECT P.MISSAO  --código de todas as missões que algum tripulante participa
    FROM PARTICIPA P
    WHERE P.TRIPULANTE = T.ID_ESPACIAL 
);
----------------------------------------------------------------------------------------------------------------

--Consulta que conta o número de observações por ano dos planetas que possuem algum satélite natural

SELECT P.NOME AS NOME_PLANETA, EXTRACT(YEAR FROM O.DATA) AS ANO_OBSERVACAO, COUNT(O.ID) AS NUMERO_OBSERVACOES
FROM  PLANETA P 
JOIN OBSERVACAO O ON P.NOME = O.PLANETA
WHERE P.NOME IN ( --subconsulta que retorna os nomes dos planetas que possuem satélites naturais
        SELECT SN.PLANETA
        FROM SATELITES_NATURAIS SN
      )
GROUP BY P.NOME, EXTRACT(YEAR FROM O.DATA); --agrupa os resultados pelo nome do planeta e pelo ano da observação
----------------------------------------------------------------------------------------------------------------

--Consulta que retorna a média do tempo de duração das missões terminadas por planeta

SELECT P.SISTEMA_PLANETARIO, P.NOME, AVG(M.DURACAO) AS MEDIA_DURACAO
FROM MISSAO M JOIN TAREFA T ON M.CODIGO = T.CODIGO
JOIN PLANETA P ON M.PLANETA = P.NOME AND M.SISTEMA_PLANETARIO = P.SISTEMA_PLANETARIO
WHERE M.STATUS = 'TERMINADA'
GROUP BY P.SISTEMA_PLANETARIO,P.NOME;
----------------------------------------------------------------------------------------------------------------

--Consulta que retorna todos os recursos naturais do tipo atmosfera que não estão presentes no sistema solar

SELECT NUM_CATALOGACAO, PRESSAO, COMPOSICAO, TEMPERATURA
FROM ATMOSFERA 

MINUS

SELECT A.NUM_CATALOGACAO, A.PRESSAO, A.COMPOSICAO, A.TEMPERATURA
FROM ATMOSFERA A
JOIN RECURSO_NATURAL RN ON RN.NUM_CATALOGACAO = A.NUM_CATALOGACAO
JOIN POSSUI P ON P.RECURSO_NATURAL = RN.NUM_CATALOGACAO --recursos do tipo atmosfera que estão presente no sistema solar
WHERE P.SISTEMA_PLANETARIO = 'SISTEMA SOLAR';


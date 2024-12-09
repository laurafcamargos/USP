-- a) Quais disputas irão ocorrer em uma data específica (data, horário, local, modalidade)?
--							(09/08/2008 14:00:00, 10, 8)
SELECT * FROM DISPUTA WHERE DATA_HORA = TO_DATE('2008-08-09 14:00:00', 'YYYY-MM-DD HH24:MI:SS') AND Local = 10 AND Modalidade = 8;

-- b) Quais são os locais de competição e qual é a agenda de eventos para cada local?
SELECT LOCAL.ID AS Local, LOCAL.NOME AS Nome_Local, DISPUTA.ID AS Disputa, DATA_HORA
FROM (DISPUTA JOIN LOCAL ON(DISPUTA.LOCAL = LOCAL.ID)) 
ORDER BY LOCAL.ID, DATA_HORA;

-- c) Quanto é o ganho de patrocínio de cada atleta em cada ano?
CREATE VIEW View_Patrocinios_Anuais AS
SELECT DISTINCT Atleta, EXTRACT(YEAR FROM Inicio) + LEVEL - 1 AS Ano, (Valor_Total / Vigencia) AS Valor_Anual
FROM Patrocina
CONNECT BY LEVEL <= Vigencia;

SELECT Passaporte, Nome, Ano, SUM(Valor_Anual)
FROM (Atleta JOIN View_Patrocinios_Anuais ON Atleta.Passaporte=View_Patrocinios_Anuais.Atleta)
GROUP BY Passaporte, Nome, Ano
ORDER BY Passaporte, Ano;

DROP VIEW View_Patrocinios_Anuais;

-- d) Em quais mídias ocorrerá a transmissão de uma dada modalidade esportiva? Qual é a agenda de transmissões para uma dada modalidade? (Modalidade 2)
SELECT MODALIDADE, MIDIA, DATA_HORA 
FROM (DISPUTA JOIN TRANSMITE ON(DISPUTA.ID=TRANSMITE.DISPUTA)) WHERE MODALIDADE = 2 
ORDER BY DATA_HORA;

-- e) Compute o número total de disputas que ocorreram em cada local, para cada modalidade, durante uma determinada Olimpíada. (Olimpiada 2008)
SELECT Local, Modalidade, Olimpiada, COUNT(*)
FROM DISPUTA
GROUP BY Local, Modalidade, Olimpiada HAVING Olimpiada = 2008;

-- f) Compute a média de capacidade dos locais por tipo de local e continente dos países onde ocorreram as Olimpíadas.
SELECT Tipo, Continente, AVG(Capacidade) 
FROM (Local JOIN Pais ON(Pais.Nome=Local.Pais)) 
GROUP BY Tipo, Continente;

-- g) Reporte quais são os atletas que participaram do maior número de disputas em toda a história de olimpiadas.
SELECT Passaporte, Nome, COUNT(Disputa) 
FROM (Atleta JOIN Joga ON Atleta.Passaporte=Joga.Atleta)
GROUP BY Passaporte, Nome
HAVING COUNT(Disputa) = (SELECT MAX(Total_Disputas) 
                         FROM (SELECT COUNT(Disputa) AS Total_Disputas 
                         FROM Joga GROUP BY Joga.Atleta));    

--h) Qual foi a sequência de resultados de uma dada modalidade em um dado ano? (Olimpiada 2008, Modalidade 8)
--   Indique o número de vitórias de cada país, ordene e ranqueie os mais vitoriosos – use função analítica.

WITH Disputas_Filtradas AS (
    SELECT ID, Pais1, Pais2, Vencedor, Modalidade, Olimpiada, Data_Hora
    FROM Disputa
    WHERE Olimpiada = 2012 AND Modalidade = 11
),
Vitorias_Por_Pais AS (
    SELECT P.NOME AS PAIS, COUNT(D.VENCEDOR) AS VITORIAS
    FROM (SELECT PAIS1 AS NOME FROM Disputas_Filtradas
         UNION
         SELECT PAIS2 AS NOME FROM Disputas_Filtradas) P
    LEFT JOIN 
        Disputas_Filtradas D ON P.NOME = D.VENCEDOR
    GROUP BY 
        P.NOME
),
Ranking_Vitorias AS (
    SELECT PAIS, VITORIAS, RANK() OVER (ORDER BY VITORIAS DESC, PAIS) AS RANKING
    FROM Vitorias_Por_Pais
)
SELECT Data_Hora, Pais1, Pais2, Vencedor, Vitorias, Ranking
FROM (Disputas_Filtradas LEFT JOIN Ranking_Vitorias ON (Disputas_Filtradas.VENCEDOR=Ranking_Vitorias.PAIS))
ORDER BY Ranking, Data_Hora;

-- VERSAO ANTIGA
SELECT
    Pais.Nome,
    SUM(CASE WHEN Disputa.Vencedor=Pais.Nome THEN 1 ELSE 0 END) AS Vitorias,
    RANK() OVER (ORDER BY SUM(CASE WHEN Disputa.Vencedor=Pais.Nome THEN 1 ELSE 0 END) DESC) AS Rank_Vitorias
FROM (Disputa JOIN Pais ON(Disputa.Pais1=Pais.Nome OR Disputa.Pais2=Pais.Nome))
WHERE Disputa.Modalidade = 11 AND Disputa.Olimpiada = 2012
GROUP BY Pais.Nome;
    
-- i) Calcule o valor acumulado dos patrocínios recebidos por cada atleta ao longo dos anos, indicando o nome do atleta, e o seu ranking de acordo com o valor acumulado. 
SELECT A.NOME AS NOME_ATLETA, SUM(P.VALOR_TOTAL) AS VALOR_ACUMULADO, RANK() OVER (ORDER BY SUM(P.VALOR_TOTAL) DESC) AS RANKING
FROM PATROCINA P JOIN  ATLETA A ON  P.ATLETA = A.PASSAPORTE
GROUP BY A.NOME
ORDER BY RANKING;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

--iii)
SELECT VENCEDOR 
FROM L05_DISPUTA
WHERE ID = 32;

--iv) Vencedor = Alemanha -> sem commit
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
--v)
UPDATE L05_DISPUTA
SET VENCEDOR = 'Brasil'
WHERE ID = 32;
--Vencedor = Brasil -> com commit
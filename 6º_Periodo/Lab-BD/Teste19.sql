CREATE OR REPLACE VIEW Teste19_View_Atleta_Disputa AS
SELECT 
    A.Nome AS Nome_Atleta, 
    A.Genero AS Genero_Atleta,
    M.Esporte as Esporte
FROM  L13692334.l06_atleta A
JOIN L13692334.l03_modalidade M ON A.Modalidade = M.ID;

--b)
CREATE TABLE L13_ESTOQUE (
    ID NUMBER PRIMARY KEY,
    QTD_ESTOQUE NUMBER,
    Mat_Esportivo_ID NUMBER,
    FOREIGN KEY (Mat_Esportivo_ID) REFERENCES L13692334.L12_MAT_ESPORTIVO(ID)
);
--inserindo
INSERT INTO L13_ESTOQUE (ID, QTD_ESTOQUE, Mat_Esportivo_ID)
VALUES (1, 50, 1); -- 50 unidades de 'Bola de Futebol' com ID 1

INSERT INTO L13_ESTOQUE (ID, QTD_ESTOQUE, Mat_Esportivo_ID)
VALUES (2, 30, 2); -- 30 unidades de 'Raquete de Tênis' com ID 2
--c)
--Antes de criar o trigger, o dono do esquema onde a tabela L13_ESTOQUE
--está localizada precisa conceder permissão de UPDATE na coluna QTD_ESTOQUE ao seu usuário.
GRANT ALL ON Teste19.L13_ESTOQUE TO L13692334;
SELECT * from L13_estoque;


-- 3) 

-- Criando a tabela de Log
DROP TABLE logTabelaDisputa;
CREATE TABLE logTabelaDisputa (usuario VARCHAR(100),data DATE,op CHAR);

-- Trigger para gerar os Logs
CREATE OR REPLACE TRIGGER Log_Disputa
AFTER INSERT OR UPDATE OR DELETE ON Disputa
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
    v_Operacao CHAR;
BEGIN
    IF INSERTING 
        THEN v_Operacao := 'I';
    ELSIF UPDATING 
        THEN v_Operacao := 'U';
    ELSIF DELETING 
        THEN v_Operacao := 'D';
    END IF;
    INSERT INTO logTabelaDisputa VALUES (USER, SYSDATE, v_Operacao);
    COMMIT;
END LogDisputa;

-- Trigger para impedir edição externa na tabela de Log
CREATE OR REPLACE TRIGGER Log_Disputa_Impede_Edicao
BEFORE UPDATE OR DELETE ON logTabelaDisputa
FOR EACH ROW
BEGIN
    RAISE_APPLICATION_ERROR(-20001, 'Não, não, você não pode mexer no log!');
END Log_Disputa_Impede_Edicao;

-- Testando

INSERT INTO L05_DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (9999, 'Brasil', 'Estados Unidos', 'Brasil', 11, 2008, TO_DATE('2008-08-19 00:13:44', 'YYYY-MM-DD HH24:MI:SS'), 3);

SELECT * FROM logTabelaDisputa;

DELETE FROM logTabelaDisputa
WHERE op = 'I';

-- 2)
-- a)  Escreva um trigger que impede que uma disputa seja cadastrada em um local que não seja no país onde a
-- olimpíada está ocorrendo.

CREATE OR REPLACE TRIGGER Verifica_Local_Disputa
BEFORE INSERT OR UPDATE ON L05_DISPUTA
FOR EACH ROW
DECLARE
    v_Pais_Local L01_PAIS.NOME%TYPE;
    v_Pais_Olimpiada L01_PAIS.NOME%TYPE;
BEGIN
    SELECT Pais INTO v_Pais_Local FROM Local WHERE ID=:new.Local;
    SELECT Pais INTO v_Pais_Olimpiada FROM Olimpiada WHERE Ano=:new.Olimpiada;
    IF v_Pais_Local != v_Pais_Olimpiada THEN
        RAISE_APPLICATION_ERROR(-20002, 'O local da disputa não está no mesmo país da Olimpíada.');
    END IF;
END Verifica_Local_Disputa;

-- Testando:
INSERT INTO L05_DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (9999, 'Brasil', 'Estados Unidos', 'Brasil', 1, 2008, TO_DATE('2008-08-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);

-- b) Escreva um trigger que impede que uma disputa seja cadastrada em um dia fora do período programado para
-- a respectiva olimpíada.
CREATE OR REPLACE TRIGGER Verifica_Data_Disputa
BEFORE INSERT OR UPDATE ON L05_DISPUTA
FOR EACH ROW
DECLARE
    v_Data_Inicio DATE;
    v_Data_Fim DATE;
BEGIN
    SELECT Data_Inicio, Data_Encerramento INTO v_Data_Inicio, v_Data_Fim 
    FROM L02_OLIMPIADA 
    WHERE Ano = :NEW.OLIMPIADA;
    
    IF :NEW.DATA_HORA < v_Data_Inicio OR :NEW.DATA_HORA > v_Data_Fim THEN
        RAISE_APPLICATION_ERROR(-20002, 'A disputa não pode ser cadastrada fora do período da Olimpíada.');
    END IF;
END Verifica_Data_Disputa;

-- Testando:
INSERT INTO L05_DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (9999, 'Brasil', 'Estados Unidos', 'Brasil', 1, 2008, TO_DATE('2012-08-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);


--c) Escreva um trigger para impedir que um atleta jogue em uma modalidade diferente daquela declarada em seu
--registro na tabela L06_ATLETA, impedindo a inserção na tabela L07_JOGA.

CREATE OR REPLACE TRIGGER Verifica_Modalidade_Atleta
BEFORE INSERT OR UPDATE ON L07_JOGA
FOR EACH ROW
DECLARE
    v_Modalidade_Atleta L06_ATLETA.Modalidade%TYPE;
    v_Modalidade_Disputa L03_MODALIDADE.ID%TYPE;
BEGIN
    -- Buscar a modalidade do atleta na tabela L06_ATLETA
    SELECT Modalidade 
    INTO v_Modalidade_Atleta
    FROM L06_ATLETA
    WHERE Passaporte = :NEW.Atleta;

    -- Buscar a modalidade da disputa na tabela Disputa
    SELECT Modalidade 
    INTO v_Modalidade_Disputa
    FROM Disputa
    WHERE ID = :NEW.Disputa;

    -- Verificar se a modalidade do atleta é diferente da modalidade da disputa
    IF v_Modalidade_Atleta != v_Modalidade_Disputa THEN
        RAISE_APPLICATION_ERROR(-20002, 'O atleta não pode jogar em uma modalidade diferente da registrada.');
    END IF;
END Verifica_Modalidade_Atleta;

-- Testando:

INSERT INTO L07_JOGA (ATLETA, DISPUTA) VALUES ('A002', 5);
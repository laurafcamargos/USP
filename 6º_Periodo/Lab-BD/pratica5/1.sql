-- 1)
-- a) Crie um atributo VITORIAS na tabela Pais para guardar o número de disputas vencidas por um dado país em
-- todas as edições de olimpíadas. Execute um procedimento, ou um UPDATE com consulta aninhada
-- correlacionada, para inicializar este atributo com base nos dados que já existem na base de dados.

-- Atualizando a tabela
ALTER TABLE L01_PAIS ADD Vitorias NUMBER;

-- Inicializando os dados 
CREATE OR REPLACE PROCEDURE Set_Vitorias
    AS
        CURSOR C_Pais IS 
            SELECT ID, Nome FROM Pais;
    BEGIN
        FOR v_Pais in C_Pais LOOP
        
            UPDATE L01_PAIS P
            SET P.Vitorias = (SELECT Count(*) FROM Disputa D WHERE D.Vencedor=P.Nome)
            WHERE P.ID=v_Pais.ID;
            
        END LOOP;
END Set_Vitorias;

BEGIN
    Set_Vitorias;
END;

-- b) Crie um trigger para manter o atributo VITORIAS atualizado para INSERT, UPDATE, ou DELETE. A
-- atualização deve ocorrer sempre que uma disputa for registrada na tabela L05_DISPUTA.

CREATE OR REPLACE TRIGGER Atualiza_Vitorias
AFTER INSERT OR UPDATE OR DELETE ON DISPUTA
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE L01_PAIS
        SET Vitorias = Vitorias + 1
        WHERE Nome = :new.Vencedor;
    
    ELSIF UPDATING THEN
        IF :old.Vencedor != :new.Vencedor THEN
            UPDATE L01_PAIS
            SET Vitorias = Vitorias - 1
            WHERE Nome = :old.Vencedor;
            
            UPDATE L01_PAIS
            SET Vitorias = Vitorias + 1
            WHERE Nome = :new.Vencedor;
        END IF;
    
    ELSIF DELETING THEN
        UPDATE L01_PAIS
        SET Vitorias = Vitorias - 1
        WHERE Nome = :old.Vencedor;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Erro nro: ' || SQLCODE || '. Mensagem: ' || SQLERRM);
END Atualiza_Vitorias;

-- Testando:
SELECT Nome, Vitorias FROM Pais WHERE Nome IN ('Brasil', 'Alemanha');

-- Trocando o vencedor:
UPDATE L05_DISPUTA
SET Vencedor = 'Brasil'
WHERE ID = 32;





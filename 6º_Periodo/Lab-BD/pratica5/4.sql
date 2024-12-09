-- 4)
-- Escreva um trigger que simula o comportamento de ON UPDATE CASCADE para garantir que, ao atualizar o
-- nome de um país em L01_PAIS, essa mudança se reflita automaticamente em todas as outras tabelas que têm esse país referenciado.
-- Considere o timing AFTER para resolver o exercício.

CREATE OR REPLACE TRIGGER Consist_Pais
AFTER UPDATE OF Nome ON L01_PAIS
FOR EACH ROW
BEGIN
    -- Update table L02_OLIMPIADA
    UPDATE L02_OLIMPIADA
    SET Pais = :NEW.Nome
    WHERE Pais = :OLD.Nome;

    -- Update table L04_LOCAL
    UPDATE L04_LOCAL
    SET Pais = :NEW.Nome
    WHERE Pais = :OLD.Nome;

    -- Update table L05_DISPUTA for FK_PAIS1 and FK_PAIS2
    UPDATE L05_DISPUTA
    SET Pais1 = :NEW.Nome,
        Vencedor = CASE 
                      WHEN Vencedor = :OLD.Nome AND Vencedor = Pais1 THEN :NEW.Nome ELSE Vencedor
                   END
    WHERE PAIS1 = :OLD.Nome;

    UPDATE L05_DISPUTA
    SET Pais2 = :NEW.Nome,
        Vencedor = CASE 
                      WHEN Vencedor = :OLD.Nome AND Vencedor = Pais2 THEN :NEW.Nome ELSE Vencedor
                   END
    WHERE Pais2 = :OLD.Nome;

    -- Update table L06_ATLETA
    UPDATE L06_ATLETA
    SET Pais = :NEW.Nome
    WHERE Pais = :OLD.Nome;
END Consist_Pais;

UPDATE L01_PAIS
SET NOME = 'Br'
WHERE NOME = 'Brasil';

DROP TRIGGER VERIFICA_LOCAL_DISPUTA;
DROP TRIGGER VERIFICA_DATA_DISPUTA;









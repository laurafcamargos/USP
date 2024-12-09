set SERVEROUTPUT on;

-- Cabeçalho do pacote
CREATE OR REPLACE PACKAGE P4_Procedures AS
    -- 1)
    TYPE Medalhistas_Record IS RECORD
    (
        Primeiro VARCHAR2(150),
        Segundo  VARCHAR2(150),
        Terceiro VARCHAR2(150)
    );
    FUNCTION Get_Medalhistas 
    (
        Par_Ano_Olimpico NUMBER,
        Par_Modalidade   INTEGER
    ) 
    RETURN Medalhistas_Record;
    
    -- 2)
    PROCEDURE Set_Placar;
    PROCEDURE Get_Resultados
    (
        Par_Ano_Olimpico NUMBER,
        Par_Modalidade   INTEGER
    );
    
    -- 3)
    PROCEDURE Set_Medalhas;
    
    -- 4)
    PROCEDURE Check_Locais_Disputas;
    PROCEDURE Check_Data_Disputas;
    
    -- 5)
    PROCEDURE Check_Atletas_Genero;
    
END P4_Procedures;
/

CREATE OR REPLACE PACKAGE BODY P4_Procedures AS
    
    -- 1)
    FUNCTION Get_Medalhistas 
    (
        Par_Ano_Olimpico NUMBER,
        Par_Modalidade   INTEGER
    ) 
    RETURN Medalhistas_Record IS
    
        v_Medalhistas Medalhistas_Record;
        v_Ranking NUMBER;
        CURSOR C_Medalhistas IS
            WITH Disputas_Filtradas AS 
            (
                SELECT ID, Pais1, Pais2, Vencedor, 
                       (CASE WHEN Vencedor = Pais1 THEN Pais2 ELSE Pais1 END) AS Perdedor, 
                       Modalidade, Olimpiada, Data_Hora
                FROM Disputa
                WHERE Olimpiada = Par_Ano_Olimpico AND Modalidade = Par_Modalidade
            ),
            Vitorias_Por_Pais AS 
            (
                SELECT Nome AS Pais, COUNT(Vencedor) AS Vitorias
                FROM (SELECT Pais1 AS Nome FROM Disputas_Filtradas
                     UNION
                     SELECT Pais2 AS Nome FROM Disputas_Filtradas) P
                LEFT JOIN Disputas_Filtradas ON P.Nome = Disputas_Filtradas.Vencedor
                GROUP BY Nome
            ),
            Ranking_Vitorias AS 
            (
                SELECT Pais, Vitorias, RANK() OVER (ORDER BY Vitorias DESC, Pais) AS Ranking
                FROM Vitorias_Por_Pais
            ),
            Primeiro_Colocado AS
            (
                SELECT Pais AS Primeiro_Pais
                FROM Ranking_Vitorias
                WHERE Ranking = 1
            ),
            Disputas_Completas AS
            (
                SELECT 
                    R.Pais AS Pais, 
                    R.Vitorias AS Vitorias, 
                    R.Ranking AS Ranking, 
                    D.Vencedor AS Vencedor, 
                    D.Perdedor AS Perdedor,
                    SUM(CASE WHEN(Pais=Perdedor AND Vencedor=Primeiro_Pais) THEN 1 ELSE 0 END) AS Disputas_Contra_Primeiro
                FROM Ranking_Vitorias R
                LEFT JOIN Disputas_Filtradas D ON (R.Pais = D.Vencedor OR R.Pais = D.Perdedor)
                LEFT JOIN Primeiro_Colocado P ON (D.Pais1 = P.Primeiro_Pais OR D.Pais2 = P.Primeiro_Pais)
                WHERE R.Ranking <= 4
                GROUP BY R.Pais, 
                    R.Vitorias, 
                    R.Ranking, 
                    D.Vencedor, 
                    D.Perdedor
            )
            SELECT DISTINCT Pais, Ranking FROM Disputas_Completas
            WHERE (Ranking <= 2 OR (Ranking <= 4 AND Disputas_Contra_Primeiro > 0))
            ORDER BY Ranking;
    
    BEGIN
        OPEN C_Medalhistas;
    
        FETCH C_Medalhistas INTO v_Medalhistas.Primeiro, v_Ranking;
        FETCH C_Medalhistas INTO v_Medalhistas.Segundo, v_Ranking;
        FETCH C_Medalhistas INTO v_Medalhistas.Terceiro, v_Ranking;
        
        CLOSE C_Medalhistas;
    
        RETURN v_Medalhistas;
    END Get_Medalhistas;

    -- 2.a)
    PROCEDURE Set_Placar
    AS
        CURSOR C_Disputas IS 
            SELECT * FROM Disputa;
    BEGIN
        FOR v_Disputas IN C_Disputas LOOP
    
            IF v_Disputas.Pais1 = v_Disputas.Vencedor THEN 
                UPDATE L05_Disputa
                SET Placar_Pais1 = FLOOR(dbms_random.value(1, 10))
                WHERE ID = v_Disputas.ID;
                UPDATE L05_Disputa 
                SET Placar_Pais2 = FLOOR(dbms_random.value(0, Placar_Pais1))
                WHERE ID = v_Disputas.ID;
    
            ELSE
                UPDATE L05_Disputa 
                SET Placar_Pais2 = FLOOR(dbms_random.value(1, 10))
                WHERE ID = v_Disputas.ID;
                UPDATE L05_Disputa 
                SET Placar_Pais1 = FLOOR(dbms_random.value(0, Placar_Pais2))
                WHERE ID = v_Disputas.ID;
            END IF;
        END LOOP;
    END Set_Placar;

    
    -- 2.b)
    PROCEDURE Get_Resultados
    (
        Par_Ano_Olimpico NUMBER,
        Par_Modalidade   INTEGER
    ) 
    AS
        CURSOR C_Resultados IS 
            WITH Locais AS
            (
                SELECT ID AS Local_ID, Nome AS Nome_Local FROM Local
            ),
            Midia_E_Transmissoes AS
            (
                SELECT ID AS Transmissao_ID, Nome AS Nome_Midia, Disputa FROM (Midia JOIN Transmite ON(Midia.ID=Transmite.Midia)) 
            )
            SELECT * 
            FROM Disputa 
            JOIN Locais ON Disputa.Local = Locais.Local_ID 
            LEFT JOIN Midia_E_Transmissoes ON Disputa.ID = Midia_E_Transmissoes.Disputa
            WHERE Disputa.Olimpiada = Par_Ano_Olimpico 
            AND Disputa.Modalidade = Par_Modalidade;
            
        v_Medalhistas Medalhistas_Record;
    BEGIN
        v_Medalhistas := Get_Medalhistas(Par_Ano_Olimpico, Par_Modalidade);
        FOR v_Resultados IN C_Resultados LOOP
            dbms_output.put_line('Partida ' || v_Resultados.ID || ' - ' || v_Resultados.Nome_Local || ' - ' 
                                            || TO_CHAR(v_Resultados.Data_Hora, 'DD/MM/YYYY HH24:MI:SS') || ' - ' 
                                            || v_Resultados.Pais1 || ' ' || v_Resultados.Placar_Pais1 || ' X ' || v_Resultados.Placar_Pais2 
                                            || ' ' || v_Resultados.Pais2 || ' Transmissao ' || v_Resultados.Nome_Midia);
        END LOOP;
    
        dbms_output.put_line('Medalhista de Ouro: ' || v_Medalhistas.Primeiro);
        dbms_output.put_line('Medalhsita de Prata: ' || v_Medalhistas.Segundo);
        dbms_output.put_line('Medalhista de Bronze: ' || v_Medalhistas.Terceiro);
        
    END Get_Resultados;

    
    -- 3)
PROCEDURE Set_Medalhas
AS
    CURSOR C_Olimpiadas IS
        SELECT Ano FROM Olimpiada;
    CURSOR C_Modalidades IS
        SELECT ID FROM Modalidade;

    v_Medalhistas P4_Procedures.Medalhistas_Record;
BEGIN
    FOR v_Olimpiadas IN C_Olimpiadas LOOP
        FOR v_Modalidades IN C_Modalidades LOOP
            v_Medalhistas := P4_Procedures.Get_Medalhistas(v_Olimpiadas.Ano, v_Modalidades.ID);
            
            IF v_Medalhistas.Primeiro IS NOT NULL THEN
                UPDATE Pais
                SET Ouros = Ouros + 1
                WHERE Nome = v_Medalhistas.Primeiro;
            END IF;
    
            IF v_Medalhistas.Segundo IS NOT NULL THEN
                UPDATE Pais
                SET Pratas = Pratas + 1
                WHERE Nome = v_Medalhistas.Segundo;
            END IF;
        
            IF v_Medalhistas.Terceiro IS NOT NULL THEN
                UPDATE Pais
                SET Bronzes = Bronzes + 1
                WHERE Nome = v_Medalhistas.Terceiro;
            END IF;                            
        END LOOP;
    END LOOP;
END Set_Medalhas;


    -- 4.a)
    PROCEDURE Check_Locais_Disputas
    AS
        CURSOR C_Disputas IS 
            WITH Locais_E_Paises AS
            (
                SELECT ID AS ID_Local, Pais AS Pais_Local FROM Local
            )
            SELECT Disputa.ID, Disputa.Olimpiada, Olimpiada.Pais AS Pais_Olimpiada, Disputa.Local, Pais_Local, Disputa.Data_Hora
            FROM Disputa 
            JOIN Olimpiada ON Disputa.Olimpiada = Olimpiada.Ano 
            JOIN Locais_E_Paises ON Disputa.Local = Locais_E_Paises.ID_Local
            WHERE Olimpiada.Pais != Pais_Local;
    
        v_Disputas C_Disputas%ROWTYPE;
        v_New_Local Local.ID%TYPE;
    BEGIN
        OPEN C_Disputas;
        FETCH C_Disputas INTO v_Disputas;
    
        IF C_Disputas%ROWCOUNT = 0 THEN
            dbms_output.put_line('Nenhum registro encontrado.');
        ELSE
            LOOP
            
                SELECT ID INTO v_New_Local FROM LOCAL 
                WHERE Pais = v_Disputas.Pais_Olimpiada 
                AND ID NOT IN (SELECT Local FROM Disputa WHERE Data_Hora = v_Disputas.Data_Hora) 
                AND ROWNUM = 1; 
                
                UPDATE Disputa 
                SET Local = v_New_Local
                WHERE ID = v_Disputas.ID;
            
                dbms_output.put_line('Disputa: ' || v_Disputas.ID || ' atualizada, novo local: ' || v_New_Local);
            
                FETCH C_Disputas INTO v_Disputas;
                EXIT WHEN C_Disputas%NOTFOUND;
            END LOOP;
        END IF;
    
        CLOSE C_Disputas;
    END Check_Locais_Disputas;

    -- 4.b)
    PROCEDURE Check_Data_Disputas
    AS
        CURSOR C_Disputas IS 
            
            SELECT Disputa.ID, Disputa.Data_Hora, Olimpiada.Data_Inicio, Olimpiada.Data_Encerramento
            FROM Disputa JOIN Olimpiada ON(Disputa.Olimpiada=Olimpiada.Ano)
            WHERE Disputa.Data_Hora < Olimpiada.Data_Inicio OR Disputa.Data_Hora > Olimpiada.Data_Encerramento;
    
        v_Nova_Data DATE;
        v_Intervalo NUMBER;
        v_Disputas C_Disputas%ROWTYPE;
    BEGIN
        OPEN C_Disputas;
        FETCH C_Disputas INTO v_Disputas;
    
        IF C_Disputas%ROWCOUNT = 0 THEN
            dbms_output.put_line('Nenhum registro encontrado.');
        ELSE
            LOOP
                v_Intervalo := v_Disputas.Data_Encerramento - v_Disputas.Data_Inicio;
                v_Nova_Data := v_Disputas.Data_Inicio + TRUNC(DBMS_RANDOM.VALUE(0, v_Intervalo));
                dbms_output.put_line('Disputa: ' || v_Disputas.ID || ' atualizada, nova data: ' || v_Nova_Data);
                
                UPDATE Disputa 
                SET Data_Hora = v_Nova_Data
                WHERE ID = v_Disputas.ID;
                
                FETCH C_Disputas INTO v_Disputas;
                EXIT WHEN C_Disputas%NOTFOUND;
            END LOOP;
        END IF;
    
        CLOSE C_Disputas;
    END Check_Data_Disputas;
    
    -- 5.a
    PROCEDURE Check_Atletas_Genero 
    AS
        CURSOR C_Atletas IS
            WITH Disputas_E_Modalidedes AS
            (
                SELECT Disputa.ID AS ID_Disputa, Modalidade.ID AS ID_Modalidade, Esporte, Genero AS Genero_Modalidade FROM Disputa JOIN Modalidade ON(Disputa.Modalidade=Modalidade.ID)
            )
            SELECT Passaporte, Atleta.Genero AS Genero_Atleta, Modalidade, ID_Disputa, Esporte, Genero_Modalidade FROM 
            Atleta
            JOIN JOGA ON (Atleta.Passaporte=Joga.Atleta)
            JOIN Disputas_E_Modalidedes ON(Joga.Disputa=Disputas_E_Modalidedes.ID_Disputa)
            WHERE Atleta.Genero != Genero_Modalidade;
    BEGIN
        FOR v_Atletas IN C_Atletas LOOP
            
            IF v_Atletas.Genero_Atleta = 'M'THEN
                UPDATE Atleta
                SET Genero = 'F'
                WHERE Passaporte = v_Atletas.Passaporte;
            ELSE
                UPDATE Atleta
                SET Genero = 'M'
                WHERE Passaporte = v_Atletas.Passaporte;
            END IF;
        END LOOP;
    END Check_Atletas_Genero;
    
END P4_Procedures;
/

-- Chamadas de função

-- 1) Olimpiada 2012, Modalidade 11
DECLARE
    v_Medalhistas P4_Procedures.Medalhistas_Record;
BEGIN
    v_Medalhistas := P4_Procedures.Get_Medalhistas(2012, 11);
    dbms_output.put_line('Primeiro: ' || v_Medalhistas.Primeiro);
    dbms_output.put_line('Segundo: ' || v_Medalhistas.Segundo);
    dbms_output.put_line('Terceiro: ' || v_Medalhistas.Terceiro);
END;
/

-- 2.a) 

-- Alterando a tabela Disputa conforme indicado:
ALTER TABLE L05_Disputa
    ADD Placar_Pais1 NUMBER CHECK (Placar_Pais1 >= 0 AND Placar_Pais1 <= 10);
ALTER TABLE L05_Disputa
    ADD Placar_Pais2 NUMBER CHECK (Placar_Pais2 >= 0 AND Placar_Pais2 <= 10);
    
BEGIN
    P4_Procedures.Set_Placar;
END;
/

-- 2.b) Olimpiada 2012, Modalidade 11
BEGIN
    P4_Procedures.Get_Resultados(2012, 11);
END;
/

-- 3)

-- Alterando a tabela Pais conforme indicado:
ALTER TABLE L01_Pais 
    ADD Bronzes INTEGER DEFAULT 0;
ALTER TABLE L01_Pais 
    ADD Pratas INTEGER DEFAULT 0;
ALTER TABLE L01_Pais 
    ADD Ouros INTEGER DEFAULT 0;
    
BEGIN
    P4_Procedures.Set_Medalhas;
END;
/

-- 4.a)
BEGIN
    P4_Procedures.Check_Locais_Disputas;
END;
/

-- 4.b)
BEGIN
    P4_Procedures.Check_Data_Disputas;
END;
/

-- 5.a)
BEGIN
    P4_Procedures.Check_Atletas_Genero;
END;
/

-- 5.b) Alterando a tabela Atleta conforme indicado:
ALTER TABLE L06_Atleta
ADD Esporte VARCHAR2(30);

ALTER TABLE L06_ATLETA
ADD CONSTRAINT KF_MOD_EG FOREIGN KEY (Esporte, Genero)
REFERENCES L03_MODALIDADE(Esporte, Genero);

ALTER TABLE L06_ATLETA
DROP CONSTRAINT FK_MOD_A;

ALTER TABLE L06_ATLETA
DROP COLUMN modalidade;

-- 5.c)
CREATE OR REPLACE PROCEDURE Set_Esporte
AS
    CURSOR C_Atletas IS 
        SELECT DISTINCT Passaporte FROM Atleta;

    v_Esporte Modalidade.Esporte%TYPE;

BEGIN
    FOR v_Atletas IN C_Atletas LOOP

        WITH Disputas_E_Modalidedes AS
        (
            SELECT Disputa.ID AS ID_Disputa, Modalidade.ID AS ID_Modalidade, Esporte AS Esporte_Disputa, Genero AS Genero_Modalidade 
            FROM Disputa JOIN Modalidade ON(Disputa.Modalidade=Modalidade.ID)
        )
        SELECT Esporte_Disputa INTO v_Esporte 
        FROM Atleta
        JOIN JOGA ON (Atleta.Passaporte=Joga.Atleta)
        JOIN Disputas_E_Modalidedes ON(Joga.Disputa=Disputas_E_Modalidedes.ID_Disputa)
        WHERE Passaporte = v_Atletas.Passaporte AND ROWNUM = 1;

        UPDATE L06_Atleta 
        SET Esporte = v_Esporte
        WHERE Passaporte = v_Atletas.Passaporte;
        
    END LOOP;
END Set_Esporte;

-- 5.c)
BEGIN
    Set_Esporte;
END;
/











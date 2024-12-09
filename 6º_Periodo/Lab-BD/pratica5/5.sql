
--5.a) Crie uma tabela de log para armazenar informações de todas as operações de DDL que ocorrerem no esquema do seu usuário. A tabela deve conter:
--usuário que executou a operação
--a data
--o nome da operação
--o tipo de objeto envolvido na operação (tabela, procedimento, trigger, ...)
--nome do objeto envolvido na operação (nome da tabela, nome do procedimento, ...)

DROP TABLE ddl_log;

CREATE TABLE ddl_log (
    USERNAME        VARCHAR2(30),    
    OPERATION_DATE  DATE,            
    OPERATION_NAME  VARCHAR2(30),
    OBJECT_TYPE     VARCHAR2(30),   
    OBJECT_NAME     VARCHAR2(128)    
);

--b) Implemente um trigger para alimentar esta tabela. Pesquise os atributos de eventos em
CREATE OR REPLACE TRIGGER ddl_audit_trigger
AFTER DDL ON SCHEMA
BEGIN
    INSERT INTO ddl_log (
        username,
        operation_date,
        operation_name,
        object_type,
        object_name
    )
    VALUES (
        SYS_CONTEXT('USERENV', 'SESSION_USER'), 
        SYSDATE,                               
        ORA_SYSEVENT,                          
        ORA_DICT_OBJ_TYPE,                     
        ORA_DICT_OBJ_NAME                      
    );
END;

SELECT * FROM ddl_log;

DELETE FROM ddl_log WHERE username='L13671810';

-- Testando:
-- Create a test table
CREATE TABLE TABELA_TESTE (
    ID NUMBER
);

ALTER TABLE TABELA_TESTE
ADD (NAME VARCHAR2(50));

DROP TABLE TABELA_TESTE;


SELECT * FROM ddl_log;

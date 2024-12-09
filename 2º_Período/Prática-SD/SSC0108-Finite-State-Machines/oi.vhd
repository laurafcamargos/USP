library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UnidadeControle is
    Port (
        clk           : in std_logic;                           -- Clock
        reset         : in std_logic;                           -- Reset
        instrucao     : in std_logic_vector(7 downto 0);        -- Instrução completa de 8 bits
        signal reg: std_logic_vector(3 downto 0); -- Bits 3 a 0: Seleção de registrador ou operando
        mem_enable    : out std_logic;                          -- Enable para memória
        mem_read  : out std_logic;                          -- Enable para leitura de memória
        mem_write  : out std_logic;                          -- Enable para write na memória
        input_enable  : out std_logic;                          -- Enable para entrada
        output_enable : out std_logic;                          -- Enable para saída
        programcounter     : out std_logic;                          -- Enable para contador de programa
        ULA_enable    : out std_logic;                          -- Enable para ULA
        reg_a  : out std_logic;                          -- Enable específico para registrador A
        reg_b : out std_logic;                          -- Enable específico para registrador B
        reg_r  : out std_logic;                          -- Enable específico para registrador de resultado (R)
        output: out std_logic_vector(1 downto 0)    -- Seleção de saída
        jump     : out STD_LOGIC;  -- Controle de salto (JMP)
        eq_flag  : out STD_LOGIC;  -- Flag de igualdade para JEQ
        gr_flag  : out STD_LOGIC;  -- Flag de maior para JGR
 	    halt     : out STD_LOGIC  -- Sinal de parada ou wait
end UnidadeControle;

architecture Behavioral of UnidadeControle is
    type state_type is (wait, search, decode, exec, memoria, write);
    signal estado, prox_estado : state_type;
    signal opcode    : std_logic_vector(3 downto 0); 
    signal reg: std_logic_vector(3 downto 0); 

begin
    op_code <= instrucao(7 downto 4);  -- Extrai os 4 bits mais significativos
    reg <= instrucao(3 downto 0); -- Extrai os 4 bits menos significativos

    -- Processo de controle principal
    process(clk, reset)
    begin
        if reset = '1' then
            -- Resetar todos os sinais e voltar para o estado inicial
            estado <= wait;
            mem_enable <= '0';
            mem_read <= '0';
            mem_write <= '0';
            input_enable <= '0';
            output_enable <= '0';
            programcounter <= '0';
            ULA_enable <= '0';
            reg_a <= '0';
            reg_b <= '0';
            reg_r <= '0';
            output <= "00";
        elsif rising_edge(clk) then
            estado <= proximo_estado;
        end if;
    end process;

    process(estado, opcode, reg)
begin
    -- Valores padrão para evitar latches
    mem_enable <= '0';
    mem_read <= '0';
    mem_write <= '0';
    input_enable <= '0';
    output_enable <= '0';
    programcounter <= '0';
    ULA_enable <= '0';
    reg_a <= '0';
    reg_b <= '0';
    reg_r <= '0';
    output <= "00";
    jump <= '0';
    eq_flag <= '0';
    gr_flag <= '0';
    halt <= '0';

    case estado is
        -- Estado de wait
        when wait =>
            if reset = '0' then
                proximo_estado <= search;
            else
                proximo_estado <= wait;
            end if;

        -- Busca a próxima instrução
        when search =>
            programcounter <= '1'; -- Incrementa o contador de programa (PC)
            proximo_estado <= decode;

        -- Decodifica a instrução
        when decode =>
            case opcode is
                when "0001" => proximo_estado <= exec; -- ADIC
                when "0010" => proximo_estado <= exec; -- SUB
                when "0011" => proximo_estado <= exec; -- OR
                when "0100" => proximo_estado <= exec; -- AND
                when "0101" => proximo_estado <= exec; -- NOT
                when "0110" => proximo_estado <= memoria; -- INPUT
                when "0111" => proximo_estado <= memoria; -- OUTPUT
                when "1000" => proximo_estado <= exec; -- CMP
                when "1001" => proximo_estado <= memoria; -- LOAD
                when "1010" => proximo_estado <= memoria; -- STORE
                when "1011" => proximo_estado <= exec; -- MOV
                when "1100" => proximo_estado <= exec; -- JMP
                when "1101" => proximo_estado <= exec; -- JEQ
                when "1110" => proximo_estado <= exec; -- JGR
                when "1111" => proximo_estado <= wait; -- WAIT
                when others => proximo_estado <= wait; -- Instrução inválida
            end case;

        -- Execução da operação
        when exec =>
            ULA_enable <= '1'; -- Ativa a ULA
            case opcode is
                when "0001" => -- ADIC
                    reg_a <= '1';
                    reg_b <= '1';
                    reg_r <= '1';
                when "0010" => -- SUB
                    reg_a <= '1';
                    reg_b <= '1';
                    reg_r <= '1';
                when "0011" => -- OR
                    reg_a <= '1';
                    reg_b <= '1';
                    reg_r <= '1';
                when "0100" => -- AND
                    reg_a <= '1';
                    reg_b <= '1';
                    reg_r <= '1';
                when "0101" => -- NOT
                    reg_a <= '1';
                    reg_r <= '1';
                when "1000" => -- CMP
                    reg_a <= '1';
                    reg_b <= '1';
                    -- Atualiza as flags com base na comparação
                    if reg_a = reg_b then
                        eq_flag <= '1'; -- Ativa flag de igualdade
                    elsif reg_a > reg_b then
                        gr_flag <= '1'; -- Ativa flag de maior
                    end if;
                when "1011" => -- MOV
                    reg_a <= '1'; -- Reg1 recebe o valor de Reg2
                    reg_b <= '1';
                when "1100" => -- JMP
                    jump <= '1'; -- Realiza salto incondicional
                when "1101" => -- JEQ
                    if eq_flag = '1' then
                        jump <= '1'; -- Salta se a última comparação foi igual
                    end if;
                when "1110" => -- JGR
                    if gr_flag = '1' then
                        jump <= '1'; -- Salta se a última comparação foi maior
                    end if;
                when others =>
                    null;
            end case;
            proximo_estado <= search;

        -- Acesso à memória (LOAD ou STORE)
        when memoria =>
            case opcode is
                when "0110" => -- INPUT
                    input_enable <= '1';
                    reg_a <= '1';
                when "0111" => -- OUTPUT
                    output_enable <= '1';
                    output <= "10"; -- Seleciona saída do registrador
                when "1001" => -- LOAD
                    mem_read <= '1'; -- Ativa leitura de memória
                    reg_a <= '1'; -- Reg1 recebe o dado da memória
                when "1010" => -- STORE
                    mem_write <= '1'; -- Ativa escrita na memória
                    reg_a <= '1'; -- Escreve o valor de Reg1 na memória
                when others =>
                    null;
            end case;
            proximo_estado <= search;
        -- Estado padrão
        when others =>
            proximo_estado <= wait;
    end case;
end process;

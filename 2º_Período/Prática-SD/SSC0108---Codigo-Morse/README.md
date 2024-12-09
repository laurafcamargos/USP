# SSC0108 - Prática-SD

[Laboratory Exercise 5 - Timers and Real-time Clock](doc/lab5.pdf)

### Alunos

|        Nome                         |    NUSP   |       
|:-----------------------------------:|:---------:|  
|   Laura Fernandes Camargos          |  13692334 |   
|   Sandy da Costa Dutra       	      |  12544570 |   
|   Vitor Nishimura		                |  5255289  | 

# Softwares utilizados

Quartus Prime 21.1 <br>

## Part IV

Foi projetado e implementado um circuito que recebe como entrada uma das oito primeiras letras do alfabeto (como no exemplo abaixo) e exibe o código Morse para ela em um LED vermelho.

| Letra | Código Morse |
|-------|--------------|
| A     | • —          |
| B     | — • • •      |
| C     | — • — •      |
| D     | — • •        |
| E     | •            |
| F     | • • — •      |
| G     | — — •        |
| H     | • • • •      |

Ao testar o circuito na placa DE0-CV Cyclone V usando os interruptores SW2−0 e botões KEY1−0 como entradas. Quando um usuário pressiona KEY1, o circuito deve exibir o código Morse para uma letra especificada por SW2−0 (000 para A, 001 para B, etc.), usando pulsos de 0,5 segundo para representar pontos e pulsos de 1,5 segundo para representar traços. O botão KEY0 deve funcionar como uma reinicialização assíncrona. Foi utilizado um contador para gerar pulsos de 0,5 segundo e outro contador para manter a luz LEDR0 acesa por 0,5 ou 1,5 segundos.

### Codigo VHDL:

```
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity morseGen is
	port (
		clk  : in std_logic;
		rst  : in std_logic;
		num  : in std_logic_vector(2 downto 0);
		load : in std_logic;
		led  : out std_logic
	);
end morseGen;

architecture Behavioral of morseGen is

	signal counter : integer := 0;
	signal running : std_logic := '0';

begin

	process(clk, rst)
	begin
		if rst = '0' then
			counter <= 0;
			led <= '0';
			running <= '0';
				
		elsif rising_edge(clk) then
			if load = '0' then
				running <= '1';
				counter <= 0;
			end if;

			if running = '1' then
				if counter < 375000000 then
					counter <= counter + 1;
				else
					counter <= 0;
				end if;

				-- Lógica do sinal led baseada no valor do counter e num
				case num is
					when "000" =>  -- Letra A: .-
						if counter < 25000000 then
							led <= '1';  -- Ponto
						elsif counter < 50000000 then
							led <= '0';  -- Espaço
						elsif counter < 125000000 then
							led <= '1';  -- Traço
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when "001" =>  -- Letra B: -...
						if counter < 75000000 then
							led <= '1';  -- Traço
						elsif counter < 100000000 then
							led <= '0';  -- Espaço
						elsif counter < 125000000 then
							led <= '1';  -- Ponto
						elsif counter < 150000000 then
							led <= '0';  -- Espaço
						elsif counter < 175000000 then
							led <= '1';  -- Ponto
						elsif counter < 200000000 then
							led <= '0';  -- Espaço
						elsif counter < 225000000 then
							led <= '1';  -- Ponto
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when "010" =>  -- Letra C: -.-.
						if counter < 75000000 then
							led <= '1';  -- Traço
						elsif counter < 100000000 then
							led <= '0';  -- Espaço
						elsif counter < 125000000 then
							led <= '1';  -- Ponto
						elsif counter < 150000000 then
							led <= '0';  -- Espaço
						elsif counter < 225000000 then
							led <= '1';  -- Traço
						elsif counter < 250000000 then
							led <= '0';  -- Espaço
						elsif counter < 275000000 then
							led <= '1';  -- Ponto
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when "011" =>  -- Letra D: -..
						if counter < 75000000 then
							led <= '1';  -- Traço
						elsif counter < 100000000 then
							led <= '0';  -- Espaço
						elsif counter < 125000000 then
							led <= '1';  -- Ponto
						elsif counter < 150000000 then
							led <= '0';  -- Espaço
						elsif counter < 175000000 then
							led <= '1';  -- Ponto
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when "100" =>  -- Letra E: .
						if counter < 25000000 then
							led <= '1';  -- Ponto
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when "101" =>  -- Letra F: ..-.
						if counter < 25000000 then
							led <= '1';  -- Ponto
						elsif counter < 50000000 then
							led <= '0';  -- Espaço
						elsif counter < 75000000 then
							led <= '1';  -- Ponto
						elsif counter < 100000000 then
							led <= '0';  -- Espaço
						elsif counter < 175000000 then
							led <= '1';  -- Traço
						elsif counter < 200000000 then
							led <= '0';  -- Espaço
						elsif counter < 225000000 then
							led <= '1';  -- Ponto
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when "110" =>  -- Letra G: --.
						if counter < 75000000 then
							led <= '1';  -- Traço
						elsif counter < 100000000 then
							led <= '0';  -- Espaço
						elsif counter < 175000000 then
							led <= '1';  -- Traço
						elsif counter < 200000000 then
							led <= '0';  -- Espaço
						elsif counter < 225000000 then
							led <= '1';  -- Ponto
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when "111" =>  -- Letra H: ....
						if counter < 25000000 then
							led <= '1';  -- Ponto
						elsif counter < 50000000 then
							led <= '0';  -- Espaço
						elsif counter < 75000000 then
							led <= '1';  -- Ponto
						elsif counter < 100000000 then
							led <= '0';  -- Espaço
						elsif counter < 125000000 then
							led <= '1';  -- Ponto
						elsif counter < 150000000 then
							led <= '0';  -- Espaço
						elsif counter < 175000000 then
							led <= '1';  -- Ponto
						else
							led <= '0';  -- Fim do sinal
							running <= '0';
						end if;
					when others =>
						led <= '0';  -- Desligado para outros casos
				end case;
			else
				led <= '0';  -- Desligado quando não está rodando
			end if;
		end if;
	end process;

end Behavioral;

```
[Link para o projeto implementado no Quartus](quartus/morse)

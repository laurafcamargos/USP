LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_1164.all ;
USE ieee.std_logic_unsigned.all ;
 
ENTITY ula IS
    PORT
    (
        operacao : IN STD_LOGIC_OverflowECTOR (3 DOWNTO 0);
        operA    : IN STD_LOGIC_OverflowECTOR(7 DOWNTO 0);
        operB    : IN STD_LOGIC_OverflowECTOR(7 DOWNTO 0);
        Result    : buffer STD_LOGIC_OverflowECTOR(7 DOWNTO 0);
        Cin        : IN STD_LOGIC;
        Neg,Igual,Carry,Borrow,Overflow : buffer STD_LOGIC        
    );
END ula;
 
ARCHITECTURE ula1 OF ula IS
constant ADIC : STD_LOGIC_OverflowECTOR(3 DOWNTO 0):="0001";
constant SUB  : STD_LOGIC_OverflowECTOR(3 DOWNTO 0):="0010";
constant OU   : STD_LOGIC_OverflowECTOR(3 DOWNTO 0):="0011";
constant E    : STD_LOGIC_OverflowECTOR(3 DOWNTO 0):="0100";
constant NAO  : STD_LOGIC_OverflowECTOR(3 DOWNTO 0):="0101";
constant CMP : STD_LOGIC_OverflowECTOR(3 DOWNTO 0):="1000"; 
 
BEGIN
    process (operA, operB, operacao,result,Cin)
    Overflowariable temp : STD_LOGIC_OverflowECTOR(8 DOWNTO 0);
    begin
        case operacao is
        when ADIC =>
            temp := ('0'&operA) + ('0'&operB);
            result <= temp(7 DOWNTO 0);
            Carry <= temp(8);
            if (operA(7)=operB(7)) then
                if (operA(7) /= result(7)) then Overflow <= '1';
                    else Overflow <= '0';
                end if;
            else Overflow <= '0';
            end if;
        when SUB =>
            temp := ('0'&operA) - ('0'&operB);
            result <= temp(7 DOWNTO 0);
            Borrow <= temp(8);
            if (operA(7) /= operB(7)) then
                if (operA(7) /= result(7)) then Overflow <= '1';
                    else Overflow <= '0';
                end if;
            else Overflow <= '0';
            end if;
        when OU =>
            result <= operA or operB;
        when E =>
            result <= operA and operB;
        when NAO =>
            result <= not operA;
        when CMP =>
            temp := ('0'&operA) - ('0'&operB);
            Igual <= '1' when (temp(7 downto 0) = "00000000") else '0'; 
            N <= temp(7); -- 
            C <= temp(8); -- Flag Carry/Borrow
            if (operA(7) /= operB(7)) and (operA(7) /= temp(7)) then
                Overflow <= '1'; 
            else
                Overflow <= '0';
            end if;
        when others =>
            result <= "00000000";
            Igual <= '0';
            Neg <= '0';
            Carry <= '0';
            Overflow <= '0';
            Borrow <= '0';
        end case;
        if (result="00000000") then 
            Igual <= '1'; else Igual <= '0';
        end if;
        Neg <= result(7);
    end process;
END ula1;
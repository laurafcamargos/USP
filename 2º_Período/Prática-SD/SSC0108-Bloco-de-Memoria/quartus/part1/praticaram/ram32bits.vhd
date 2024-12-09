LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ram32bits IS
    PORT (
        address : IN  STD_LOGIC_VECTOR(4 DOWNTO 0); -- 5-bit address for 32 locations
        clock   : IN  STD_LOGIC;
        dataIn  : IN  STD_LOGIC_VECTOR(3 DOWNTO 0); -- 4-bit input data
        write   : IN  STD_LOGIC; -- write enable signal
        dataOut : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) -- 4-bit output data
    );
END ram32bits;

ARCHITECTURE Behavior OF ram32bits IS

    COMPONENT ram32x4
    PORT (
        address : IN  STD_LOGIC_VECTOR (4 DOWNTO 0); -- 5-bit address input
        clock   : IN  STD_LOGIC; -- clock input
        data    : IN  STD_LOGIC_VECTOR (3 DOWNTO 0); -- 4-bit data input
        wren    : IN  STD_LOGIC; -- write enable
        q       : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) -- 4-bit output
    );
    END COMPONENT;

BEGIN

    -- Instantiate the RAM32x4 module
    ram_inst : ram32x4
        PORT MAP (
            address => address, -- connect address input
            clock   => clock,   -- connect clock
            data    => dataIn,  -- connect data input
            wren    => write,   -- connect write enable
            q       => dataOut  -- connect data output
        );

END Behavior;
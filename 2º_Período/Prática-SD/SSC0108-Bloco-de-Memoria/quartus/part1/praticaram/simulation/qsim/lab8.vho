-- Copyright (C) 2021  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"

-- DATE "10/01/2024 17:04:50"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	ram32bits IS
    PORT (
	address : IN std_logic_vector(4 DOWNTO 0);
	clock : IN std_logic;
	dataIn : IN std_logic_vector(3 DOWNTO 0);
	write : IN std_logic;
	dataOut : OUT std_logic_vector(3 DOWNTO 0)
	);
END ram32bits;

-- Design Ports Information
-- dataOut[0]	=>  Location: PIN_E7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOut[1]	=>  Location: PIN_B7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOut[2]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataOut[3]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- write	=>  Location: PIN_D6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIn[0]	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[0]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[1]	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[2]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[3]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address[4]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIn[1]	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIn[2]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dataIn[3]	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF ram32bits IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_address : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_clock : std_logic;
SIGNAL ww_dataIn : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_write : std_logic;
SIGNAL ww_dataOut : std_logic_vector(3 DOWNTO 0);
SIGNAL \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAIN_bus\ : std_logic_vector(19 DOWNTO 0);
SIGNAL \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTAADDR_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAOUT_bus\ : std_logic_vector(19 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \write~input_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputCLKENA0_outclk\ : std_logic;
SIGNAL \dataIn[0]~input_o\ : std_logic;
SIGNAL \address[0]~input_o\ : std_logic;
SIGNAL \address[1]~input_o\ : std_logic;
SIGNAL \address[2]~input_o\ : std_logic;
SIGNAL \address[3]~input_o\ : std_logic;
SIGNAL \address[4]~input_o\ : std_logic;
SIGNAL \dataIn[1]~input_o\ : std_logic;
SIGNAL \dataIn[2]~input_o\ : std_logic;
SIGNAL \dataIn[3]~input_o\ : std_logic;
SIGNAL \ram_inst|altsyncram_component|auto_generated|q_a\ : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_address <= address;
ww_clock <= clock;
ww_dataIn <= dataIn;
ww_write <= write;
dataOut <= ww_dataOut;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAIN_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & \dataIn[3]~input_o\ & \dataIn[2]~input_o\ & \dataIn[1]~input_o\ & 
\dataIn[0]~input_o\);

\ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTAADDR_bus\ <= (\address[4]~input_o\ & \address[3]~input_o\ & \address[2]~input_o\ & \address[1]~input_o\ & \address[0]~input_o\);

\ram_inst|altsyncram_component|auto_generated|q_a\(0) <= \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAOUT_bus\(0);
\ram_inst|altsyncram_component|auto_generated|q_a\(1) <= \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAOUT_bus\(1);
\ram_inst|altsyncram_component|auto_generated|q_a\(2) <= \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAOUT_bus\(2);
\ram_inst|altsyncram_component|auto_generated|q_a\(3) <= \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAOUT_bus\(3);

-- Location: IOOBUF_X8_Y45_N93
\dataOut[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ram_inst|altsyncram_component|auto_generated|q_a\(0),
	devoe => ww_devoe,
	o => ww_dataOut(0));

-- Location: IOOBUF_X14_Y45_N53
\dataOut[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ram_inst|altsyncram_component|auto_generated|q_a\(1),
	devoe => ww_devoe,
	o => ww_dataOut(1));

-- Location: IOOBUF_X8_Y45_N76
\dataOut[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ram_inst|altsyncram_component|auto_generated|q_a\(2),
	devoe => ww_devoe,
	o => ww_dataOut(2));

-- Location: IOOBUF_X14_Y45_N2
\dataOut[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \ram_inst|altsyncram_component|auto_generated|q_a\(3),
	devoe => ww_devoe,
	o => ww_dataOut(3));

-- Location: IOIBUF_X12_Y45_N52
\write~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_write,
	o => \write~input_o\);

-- Location: IOIBUF_X54_Y18_N61
\clock~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G10
\clock~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clock~input_o\,
	outclk => \clock~inputCLKENA0_outclk\);

-- Location: IOIBUF_X10_Y45_N18
\dataIn[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIn(0),
	o => \dataIn[0]~input_o\);

-- Location: IOIBUF_X14_Y45_N18
\address[0]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_address(0),
	o => \address[0]~input_o\);

-- Location: IOIBUF_X10_Y45_N35
\address[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_address(1),
	o => \address[1]~input_o\);

-- Location: IOIBUF_X12_Y45_N1
\address[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_address(2),
	o => \address[2]~input_o\);

-- Location: IOIBUF_X14_Y45_N35
\address[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_address(3),
	o => \address[3]~input_o\);

-- Location: IOIBUF_X12_Y45_N18
\address[4]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_address(4),
	o => \address[4]~input_o\);

-- Location: IOIBUF_X12_Y45_N35
\dataIn[1]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIn(1),
	o => \dataIn[1]~input_o\);

-- Location: IOIBUF_X10_Y45_N52
\dataIn[2]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIn(2),
	o => \dataIn[2]~input_o\);

-- Location: IOIBUF_X10_Y45_N1
\dataIn[3]~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dataIn(3),
	o => \dataIn[3]~input_o\);

-- Location: M10K_X11_Y44_N0
\ram_inst|altsyncram_component|auto_generated|ram_block1a0\ : cyclonev_ram_block
-- pragma translate_off
GENERIC MAP (
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "ram32x4:ram_inst|altsyncram:altsyncram_component|altsyncram_hvv3:auto_generated|ALTSYNCRAM",
	operation_mode => "single_port",
	port_a_address_clear => "none",
	port_a_address_width => 5,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 20,
	port_a_first_address => 0,
	port_a_first_bit_number => 0,
	port_a_last_address => 31,
	port_a_logical_ram_depth => 32,
	port_a_logical_ram_width => 4,
	port_a_read_during_write_mode => "new_data_no_nbe_read",
	port_b_address_width => 5,
	port_b_data_width => 20,
	ram_block_type => "M20K")
-- pragma translate_on
PORT MAP (
	portawe => \write~input_o\,
	portare => VCC,
	clk0 => \clock~inputCLKENA0_outclk\,
	portadatain => \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAIN_bus\,
	portaaddr => \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTAADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portadataout => \ram_inst|altsyncram_component|auto_generated|ram_block1a0_PORTADATAOUT_bus\);

-- Location: LABCELL_X19_Y24_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;



Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;


entity adder IS PORT(
	a: IN std_logic;
	b: IN std_logic;
	ci: IN std_logic;
	c: OUT std_logic;
	co: OUT std_logic;
	);
end entitiy adder;

Architecture structure OF adder IS
BEGIN
inputs <= a&b&ci;
with inputs select
	c <= '1' when "001",
	     '1' when "010",
	     '1' when "100",
	     '1' when "111",
	     '0' when others;
with inputs select
	co <= '1' when "011",
	      '1' when "101",
	      '1' when "110",
	      '1' when "111",
	      '0' when others;
end structure;

Library ieee;
Use ieee.std_logic_1164.all;

entity adder_subtracter is 
port( datain_a: in std_logic_vector(31 downto 0);
	datain_b: in std_logic_vector(31 downto 0);
	add_sub: in std_logic;
	dataout_as: out std_logic_vector(31 downto o);
	co: out std_logic);
end entity adder_subtracter;

Architecture plus_minus of adder_subtracter is 

COMPONENT adder IS PORT(
	a: IN std_logic;
	b: IN std_logic;
	ci: IN std_logic;
	c: OUT std_logic;
	co: OUT std_logic);
END COMPONENT;

SIGNAL carryLine: std_logic_vector(31 downto 0);
SIGNAL ToBeOrNotToBe: std_logic_vector(30 downto 0);
SIGNAL addsubSwitch: std_logic_vector(30 downto 0);

BEGIN
addsubSwitch <= (others=>add_sub);
ToBeOrNotToBe <= (datain_b and not(addsubSwitch)) or (not(datain_b) and addsubSwitch);
carryLine(0) <= addsubSwitch

FOR I in 0 to 30 GENERATE

P(I+1): adder PORT MAP(
	a=> datain_a(I),
	b=> ToBeOrNotToBe(I),
	ci=> carryLine(I),
	c => dataout_as(I),
	co => carryLine(I+1)
);
END GENERATE;
co <= carryLine(31)
END plus_minus;


Library ieee;
Use ieee.std_logic_1164.all;

entity test_bench is
end entity;

architecture hopeAndPray of test_bench is

COMPONENT adder_subtracter is 
	port( datain_a: in std_logic_vector(31 downto 0);
	datain_b: in std_logic_vector(31 downto 0);
	add_sub: in std_logic;
	dataout_as: out std_logic_vector(31 downto o);
	co: out std_logic);
END COMPONENT adder_subtracter;

SIGNAL TST_A,TST_B,TST_C: std_logic_vector(31 downto 0);
SIGNAL TST_CO,TST_add_sub: std_logic;

BEGIN
	test: adder_subtracter PORT MAP(
		datain_a=>TST_A,
		datain_b=>TST_B,
		dataout_as=>TST_C,
		co=>TST_CO,
		add_sub=>TST_add_sub);

	tb: process
	Begin
		wait for 100 ns;
		TST_A <=X"00000000";
		TST_B <=X"00000000";
		TST_CO <='Z';
		TST_add_sub <= '0';
		wait for 5 ns;
		TST_A <=X"00000001";
		TST_B <=X"00000000";
		TST_add_sub <= '0';
		wait for 5 ns;
		TST_A <=X"00000000";
		TST_B <=X"00000001";
		TST_add_sub <= '0';
		wait for 5 ns;
		TST_A <=X"00000000";
		TST_B <=X"00000001";
		TST_add_sub <= '1';
		wait for 5 ns;
		TST_A <=X"00010101";
		TST_B <=X"01010000";
		TST_add_sub <= '0';
		wait for 5 ns;
		TST_A <=X"00000000";
		TST_B <=X"00010100";
		TST_add_sub <= '0';
		wait for 5 ns;
		TST_A <=X"01001010";
		TST_B <=X"00000101";
		TST_add_sub <= '1';
		wait for 5 ns;
		wait;
	end process;


entity shift_register is 
port( datain: in std_logic_vector(31 downto 0);
	dir: in std_logic;
	shamt: in std_logic_vector(5 downto o);
	dataout_shreg: out std_logic_vector(31 downto 0));
end entity shift_register;


Architecture of shifty is shift_register is 

signal inputs: std_logic_vector(5 downto 0)

BEGIN
inputs <= dir&shamt;
with inputs select 
dataout_shreg <=

datain(31 downto 0) when "000000",
datain(30 downto 0)&'0' when "000001",
datain(29 downto 0)&"00" when "000010",
datain(28 downto 0)&"000" when "000011",
datain(27 downto 0)&"0000" when "000100",
datain(26 downto 0)&"00000" when "000101",
datain(25 downto 0)&"000000" when "000111",
datain(24 downto 0)&"0000000" when "001000",
datain(23 downto 0)&"00000000" when "001001",
datain(22 downto 0)&"000000000" when "001010",
datain(21 downto 0)&"0000000000" when "001011",
datain(20 downto 0)&"00000000000" when "001100",
datain(19 downto 0)&"000000000000" when "001101",
datain(18 downto 0)&"0000000000000" when "001110",
datain(17 downto 0)&"00000000000000" when "001111",
datain(16 downto 0)&"000000000000000" when "010000",
datain(15 downto 0)&"0000000000000000" when "010001",
datain(14 downto 0)&"00000000000000000" when "010010",
datain(13 downto 0)&"000000000000000000" when "010011",
datain(12 downto 0)&"0000000000000000000" when "010100",
datain(10 downto 0)&"00000000000000000000" when "010101",
datain(9 downto 0)&"000000000000000000000" when "010111",
datain(8 downto 0)&"0000000000000000000000" when "011000",
datain(7 downto 0)&"00000000000000000000000" when "011001",
datain(6 downto 0)&"000000000000000000000000" when "011010",
datain(5 downto 0)&"0000000000000000000000000" when "011011",
datain(4 downto 0)&"00000000000000000000000000" when "011100",
datain(3 downto 0)&"000000000000000000000000000" when "011101",
datain(2 downto 0)&"0000000000000000000000000000" when "011110",
datain(1 downto 0)&"00000000000000000000000000000" when "011111",
'0'&datain(31 downto 1) when "100001",
"00"&datain(31 downto 2) when "100010",
"000"&datain(31 downto 3) when "100011",
"0000"&datain(31 downto 4) when "100100",
"00000"&datain(31 downto 5) when "100101",
"000000"&datain(31 downto 6) when "100110",
"0000000"&datain(31 downto 7) when "100111",
"00000000"&datain(31 downto 8) when "101000",
"000000000"&datain(31 downto 9) when "101001",
"0000000000"&datain(31 downto 10) when "101010",
"00000000000"&datain(31 downto 11) when "101011",
"000000000000"&datain(31 downto 12) when "101100",
"0000000000000"&datain(31 downto 13) when "101101",
"00000000000000"&datain(31 downto 14) when "101110",
"000000000000000"&datain(31 downto 15) when "101111",
"0000000000000000"&datain(31 downto 16) when "110000",
"00000000000000000"&datain(31 downto 17) when "110001",
"000000000000000000"&datain(31 downto 18) when "110010",
"0000000000000000000"&datain(31 downto 19) when "110011",
"00000000000000000000"&datain(31 downto 20) when "110100",
"000000000000000000000"&datain(31 downto 21) when "110101",
"0000000000000000000000"&datain(31 downto 22) when "110110",
"00000000000000000000000"&datain(31 downto 23) when "110111",
"000000000000000000000000"&datain(31 downto 24) when "111000",
"0000000000000000000000000"&datain(31 downto 25) when "111001",
"00000000000000000000000000"&datain(31 downto 26) when "111010",
"000000000000000000000000000"&datain(31 downto 27) when "111011",
"0000000000000000000000000000"&datain(31 downto 28) when "111100",
"00000000000000000000000000000"&datain(31 downto 29) when "111101",
"000000000000000000000000000000"&datain(31 downto 30) when "111110",
"0000000000000000000000000000000" when "111111",
'0' when others;


end architecture shifty;

Library ieee;
Use ieee.std_logic_1164.all;

entity ALU is 
	Port(DataIn1,DataIn2: in std_logic_vector(31 downto 0);
	Control: in std_logic_vector(4 downto 0);
	Shift_dir: in std_logic;
	Shift_amount: in std_logic_vector(5 downto 0);
	Negative, Zero, Overflow, Carry: out std_logic;
	ALUResult: out std_logic_vector(31 downto 0) );
end entity ALU;

Architecture num of ALU is 
	component adder_subtracter
		port( datain_a: in std_logic_vector(31 downto 0);
			datain_b: in std_logic_vector(31 downto 0);
			add_sub: in std_logic;
			dataout_as: out std_logic_vector(31 downto o);
			co: out std_logic);
	end component;
	
	component shift_register 
		port( datain: in std_logic_vector(31 downto 0);
			dir: in std_logic;
			shamt: in std_logic_vector(5 downto o);
			dataout_shreg: out std_logic_vector(31 downto 0));
	end component;

signal addResult : std_logic_vector(31 downto 0);
signal shiftResult : std_logic_vector(31 downto 0);
signal sub_add : std_logic;

with Control select ALUResult <=
	addResult when "00010",
	addResult when "00110",
	shiftResult when "10000";
with Control select sub_add <=
	'0' when "00010",
	'1' when "00110";

BEGIN

addsub : adder_subtracter is PORT MAP(
	datain_a =>DataIn1,
	datain_b => DataIn2,
	add_sub =>sub_add,
	dataout_as => addResult,
	co => Overflow);

shifter : shift_register is PORT MAP(
	datain => DataIn1,
	dir => Shift_dir,
	shamt => Shift_amount,
	dataout_as => shiftResult);


end architecture;
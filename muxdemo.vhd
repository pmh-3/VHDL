Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity bitstorage is
	port(bitin: in std_logic;
		 enout: in std_logic;  -- this input is important for normal memory elements.
		 writein: in std_logic;
		 bitout: out std_logic);
end entity bitstorage;

architecture memlike of bitstorage is
	signal q: std_logic;
begin
	process(writein) is
	begin
		if (rising_edge(writein)) then
			q <= bitin;
		end if;
	end process;
	bitout <= q when enout = '0' else 'Z';
end architecture memlike;

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity SmallBusMux16to1 is
	Port(	selector: in std_logic_vector(3 downto 0);
		In0, In1, In2, In3: in std_logic;
		In4, In5, In6, In7: in std_logic;
		In8, In9, In10, In11: in std_logic;
		In12, In13, In14, In15: in std_logic;
		Result: out std_logic );
end entity SmallBusMux16to1;

architecture switching of SmallBusMux16to1 is
begin
	with selector select
		Result <=	In0 when "0000",
				In1 when "0001",
				In2 when "0010",
				In3 when "0011",
				In4 when "0100",
				In5 when "0101",
				In6 when "0110",
				In7 when "0111",
				In8 when "1000",
				In9 when "1001",
				In10 when "1010",
				In11 when "1011",
				In12 when "1100",
				In13 when "1101",
				In14 when "1110",
				In15 when "1111",
				In0 when others;
end architecture switching;

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity SmallBusDecoder16to1 is
	Port(	selector: in std_logic_vector(3 downto 0);
		decode: out std_logic_vector(15 downto 0) );
end entity SmallBusDecoder16to1;

architecture switching of SmallBusDecoder16to1 is
begin
	with selector select
		decode <=	"0000000000000001" when "0000",
				"0000000000000010" when "0001",
				"0000000000000100" when "0010",
				"0000000000001000" when "0011",
				"0000000000010000" when "0100",
				"0000000000100000" when "0101",
				"0000000001000000" when "0110",
				"0000000010000000" when "0111",
				"0000000100000000" when "1000",
				"0000001000000000" when "1001",
				"0000010000000000" when "1010",
				"0000100000000000" when "1011",
				"0001000000000000" when "1100",
				"0010000000000000" when "1101",
				"0100000000000000" when "1110",
				"1000000000000000" when "1111",
				"0000000000000000" when others;
end architecture switching;


Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity bit_array is
	port(data: inout std_logic;
		 address: in std_logic_vector(3 downto 0);
		 rdwr: in std_logic;
		 enout: in std_logic);
end entity bit_array;

architecture chooseme of bit_array is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;

	component SmallBusDecoder16to1 is
		port(	selector: in std_logic_vector(3 downto 0);
		decode: out std_logic_vector(15 downto 0) );
	end component;

	signal en_to_endec, wr_to_rdwrdec, enoutsprd, enouttargeted, writespread,wr_to_rdwr_targeted: std_logic_vector(15 downto 0);

begin
	mem0: bitstorage PORT MAP(
		bitin => data,
		enout => enouttargeted(0), -- OR not(en_to_endec(0) ),
		writein => wr_to_rdwr_targeted(0),-- wr_to_rdwrdec(0),
		bitout => data
	);

	enoutdecoder: SmallBusDecoder16to1 PORT MAP(
		selector => address,
		decode => en_to_endec
	);

	rdwrdecoder: SmallBusDecoder16to1 PORT MAP(
		selector => address,
		decode => wr_to_rdwrdec
	);
	enoutsprd <= (others => enout);
	enouttargeted <= enoutsprd OR NOT en_to_endec;
	writespread <= (others => rdwr);
	wr_to_rdwr_targeted <= wr_to_rdwrdec AND writespread;
end architecture;

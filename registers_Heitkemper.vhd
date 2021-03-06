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

entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
		 enout: in std_logic;
		 writein: in std_logic;
		 dataout: out std_logic_vector(7 downto 0));
end entity register8;

architecture memmy of register8 is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	G1: bitstorage port map (datain(0), enout, writein, dataout(0));
	G2: bitstorage port map (datain(1), enout, writein, dataout(1));
	G3: bitstorage port map (datain(2), enout, writein, dataout(2));
	G4: bitstorage port map (datain(3), enout, writein, dataout(3));
	G5: bitstorage port map (datain(4), enout, writein, dataout(4));
	G6: bitstorage port map (datain(5), enout, writein, dataout(5));
	G7: bitstorage port map (datain(6), enout, writein, dataout(6));
	G8: bitstorage port map (datain(7), enout, writein, dataout(7));
	
	-- insert your code here.
end architecture memmy;

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32: in std_logic;
		 writein32: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
end entity register32;

architecture biggermem of register32 is
	entity register8 is
	port(datain: in std_logic_vector(7 downto 0);
		 enout: in std_logic;
		 writein: in std_logic;
		 dataout: out std_logic_vector(7 downto 0));
end entity register8;
	-- hint: you'll want to put register8 as a component here 
	-- so you can use it below
begin
	H1: register8 port map (datain(7 downto 0), enout32, writein32, dataout(7 downto 0));
	H2: register8 port map (datain(15 downto 8), enout32, writein32, dataout(15 downto 8));
	H3: register8 port map (datain(23 downto 16), enout32, writein32, dataout(23 downto 16));
	H4: register8 port map (datain(31 downto 24), enout32, writein32, dataout(31 downto 24));
	-- insert code here.
end architecture biggermem;

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

entity bytemem is
	port(data: inout std_logic_vector(7 downto 0);
		 rdwr: in std_logic;
		 enout8: in std_logic);
end entity bytemem;


architecture memory of bytemem is
	component bitstorage
		port(bitin: in std_logic;
		 	 enout: in std_logic;
		 	 writein: in std_logic;
		 	 bitout: out std_logic);
	end component;
begin
	J0: bitstorage port map (data(0),rdwr,enout8,data(0));
	J1: bitstorage port map (data(1),rdwr,enout8,data(1));
	J2: bitstorage port map (data(2),rdwr,enout8,data(2));
	J3: bitstorage port map (data(3),rdwr,enout8,data(3));
	J4: bitstorage port map (data(4),rdwr,enout8,data(4));
	J5: bitstorage port map (data(5),rdwr,enout8,data(5));
	J6: bitstorage port map (data(6),rdwr,enout8,data(6));
	J7: bitstorage port map (data(7),rdwr,enout8,data(7));
--not sure how to control the input and placement of the bits into the byte  
 
	bit0: bitstorage PORT MAP(
	data => data(0)
	);
end architecture memory;
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity byte_array is
	port(data: inout std_logic_vector(7 downto 0);
		 address: in std_logic_vector(3 downto 0);
		 rdwr: in std_logic;
		 enout: in std_logic);
end entity byte_array;

architecture choseyou of byte_array is
	component bytemem is
	port(data: inout std_logic_vector(7 downto 0);
		 rdwr: in std_logic;
		 enout8: in std_logic);
	end component;

	component SmallBusDecoder16to1 is
		port(	selector: in std_logic_vector(3 downto 0);
		decode: out std_logic_vector(15 downto 0) );
	end component;

	signal en_to_endec, wr_to_rdwrdec, enoutsprd, enouttargeted, writespread,wr_to_rdwr_targeted: std_logic_vector(15 downto 0);
begin
	mem0: bytemem PORT MAP(
		data => data,
		enout8 => enouttargeted(0), -- OR not(en_to_endec(0) ),
		rdwr => wr_to_rdwr_targeted(0),-- wr_to_rdwrdec(0),
		data => data
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

	

end architecture choseyou;

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity controller is
	port(instruction: in std_logic_vector(31 downto 0);
	     clock: in std_logic;
		 ALU_Ctrl:	out std_logic_vector(3 downto 0); -- 0010 for ADD, 0110 for SUB
		 ReadRegister1: out std_logic_vector(4 downto 0);
		 ReadRegister2: out std_logic_vector(4 downto 0);
		 WriteRegister: out std_logic_vector(4 downto 0));
end entity controller;

architecture combo of controller is
	component byte_array is
	port(data: inout std_logic_vector(7 downto 0);
		 address: in std_logic_vector(3 downto 0);
		 rdwr: in std_logic;
		 enout: in std_logic);
	end component byte_array;

	component register32 is
	port(datain: in std_logic_vector(31 downto 0);
		 enout32: in std_logic;
		 writein32: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	end component register32;
begin 
	A: byte_array PORT MAP(
		);
	R1: register32 PORT MAP(
		);
	R2: register32 PORT MAP(
		);

	with intruction select
		ALU_Ctrl <= 'ADD' when 0010
			    'SUB' when 0110
--when instruction is sent to ALU control unit, read from the correct registers and place either added or subtracted value into new place on register. 

end architecture combo;


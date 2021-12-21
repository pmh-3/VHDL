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
	-- hint: you'll want to put register8 as a component here 
	-- so you can use it below
begin
	-- insert code here.
end architecture biggermem;
	
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
			

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_arith.all;
Use ieee.std_logic_unsigned.all;

entity tmuxdemo is
end entity tmuxdemo;


ARCHITECTURE behavior OF tmuxdemo IS 

	component bit_array is
		port(data: inout std_logic;
			 address: in std_logic_vector(3 downto 0);
			 rdwr: in std_logic;
			 enout: in std_logic);
	end component bit_array;

	signal data_ba: std_logic;
	signal rdwr_ba: std_logic := '0';
	signal enout_ba: std_logic := '1';
	signal address_ba: std_logic_vector(3 downto 0);
begin
	uut: bit_array PORT MAP(
		data => data_ba,
		address => address_ba,
		rdwr => rdwr_ba,
		enout => enout_ba
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;						-- 100 ns

		-- test the bit_array first
		address_ba <= "0000";
		data_ba <= '0';
		wait for 5 ns;							-- 105 ns
		rdwr_ba <= '1';
		wait for 5 ns;							-- 110 ns
		rdwr_ba <= '0';
		data_ba <= 'Z';
		wait for 5 ns;							-- 115 ns
		enout_ba <= '0'; -- data_ba should be 0
		wait for 10 ns;
		enout_ba <= '1';						-- 125 ns

		address_ba <= "0001";
		data_ba <= '1';
		wait for 5 ns;							-- 130 ns
		rdwr_ba <= '1';
		wait for 5 ns;							-- 135 ns
		rdwr_ba <= '0';
		data_ba <= 'Z';
		wait for 5 ns;							-- 140 ns
		enout_ba <= '0'; -- data_ba should be 1
		wait for 10 ns;							-- 150 ns
		enout_ba <= '1';

		address_ba <= "0010";
		data_ba <= '0';
		wait for 5 ns;							-- 155 ns
		rdwr_ba <= '1';
		wait for 5 ns;							-- 160 ns
		rdwr_ba <= '0';
		data_ba <= 'Z';
		wait for 5 ns;							-- 165 ns
		enout_ba <= '0'; -- data_ba should be 0
		wait for 10 ns;							-- 175 ns
		enout_ba <= '1';

		address_ba <= "0011";
		data_ba <= '1';
		wait for 5 ns;							-- 180 ns
		rdwr_ba <= '1';
		wait for 5 ns;							-- 185 ns
		rdwr_ba <= '0';
		data_ba <= 'Z';
		wait for 5 ns;							-- 190 ns
		enout_ba <= '0'; -- data_ba should be 1
		wait for 10 ns;							-- 200 ns
		enout_ba <= '1';

		address_ba <= "0000";
		wait for 5 ns;							-- 205 ns 
		enout_ba <= '0'; -- data_ba should be 0
		wait for 5 ns;							-- 210 ns
		enout_ba <= '1';
		wait for 5 ns;							-- 215 ns
		address_ba <= "0001";
		wait for 5 ns;							-- 220 ns
		enout_ba <= '0'; -- data_ba should be 1
		wait for 5 ns;							-- 225 ns
		enout_ba <= '1';
		wait for 5 ns;							-- 230 ns
		address_ba <= "0010";
		wait for 5 ns;							-- 235 ns
		enout_ba <= '0'; -- data_ba should be 0
		wait for 5 ns;							-- 240 ns
		enout_ba <= '1';
		wait for 5 ns;							-- 245 ns
		address_ba <= "0011";
		wait for 5 ns;							-- 250 ns 
		enout_ba <= '0'; -- data_ba should be 1
		wait for 5 ns;							-- 255 ns
		enout_ba <= '1';
		wait for 5 ns;							-- 260 ns
		address_ba <= "0011";

		wait;
	END PROCESS;
end architecture;


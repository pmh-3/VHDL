
--------------------------------------------------------------------------------
--
-- Create Date:   15:15:14 02/11/2008
-- Design Name:   adder_subtracter
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 1.0  - updated for W2009 offering of ECEGR304 Lab 2
-- Additional Comments:
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY testreg_vhd IS
END testreg_vhd;

ARCHITECTURE behavior OF testreg_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT bytemem
	PORT(
		data : INOUT std_logic_vector(7 downto 0);
		rdwr : IN std_logic;
		enout : IN std_logic
		);
	END COMPONENT;
	
	COMPONENT register32
	PORT(datain: in std_logic_vector(31 downto 0);
		 enout32: in std_logic;
		 writein32: in std_logic;
		 dataout: out std_logic_vector(31 downto 0));
	END COMPONENT;
	
	COMPONENT byte_array
	PORT(	data: inout std_logic_vector(7 downto 0);
			address: in std_logic_vector(3 downto 0);
			rdwr : IN std_logic;
			enout : IN std_logic);
	END COMPONENT;

	COMPONENT controller
	PORT(instruction: in std_logic_vector(31 downto 0);
			 clock: in std_logic;
			 ALU_Ctrl:	out std_logic_vector(3 downto 0); -- 0010 for ADD, 0110 for SUB
			 ReadRegister1: out std_logic_vector(4 downto 0);
			 ReadRegister2: out std_logic_vector(4 downto 0);
			 WriteRegister: out std_logic_vector(4 downto 0) );
	END COMPONENT;
	
	--Inputs
	SIGNAL rdwr_bm :  std_logic := '0';
	SIGNAL data_bm :  std_logic_vector(7 downto 0) := (others=>'0');
	SIGNAL enout_bm:  std_logic := '1';
	SIGNAL datain_r32 :  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL enout32_r32: std_logic := '1';
	SIGNAL writein32_r32: std_logic := '0';
	SIGNAL dataout_r32	:  std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL data_ba :  std_logic_vector(7 downto 0) := (others=>'0');
	SIGNAL address_ba: std_logic_vector(3 downto 0) := (others=>'0');
	SIGNAL rdwr_ba :  std_logic := '1';
	SIGNAL enout_ba:  std_logic := '1';
	SIGNAL instruction_c	:	std_logic_vector(31 downto 0) := (others=>'0');
	SIGNAL clock_c   : std_logic := '0';
	SIGNAL ALU_Ctrl_c : std_logic_vector(3 downto 0) := (others=> '0');
	SIGNAL ReadRegister1_c	:		std_logic_vector(4 downto 0)	:= (others=>'0');
	SIGNAL ReadRegister2_c	:		std_logic_vector(4 downto 0)	:= (others=>'0');
	SIGNAL WriteRegister_c	:		std_logic_vector(4 downto 0)	:= (others=>'0');

	--Outputs
	SIGNAL addsubdataout :  std_logic_vector(31 downto 0);
	SIGNAL shdataout:	std_logic_vector(31 downto 0);
	SIGNAL dataout: std_logic_vector(31 downto 0);
	SIGNAL co :  std_logic;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut1: bytemem PORT MAP(
		data => data_bm,
		rdwr => rdwr_bm,
		enout => enout_bm
	);
	
	uut2: register32 PORT MAP(
		datain => datain_r32,
		enout32 => enout32_r32,
		writein32 => writein32_r32,
		dataout => dataout_r32
	);
	
	uut3: byte_array PORT MAP(
		data => data_ba,
		address => address_ba,
		rdwr => rdwr_ba,
		enout => enout_ba
	);

	uut4: controller PORT MAP(
		instruction => instruction_c,
		clock => clock_c,
		ALU_Ctrl => ALU_Ctrl_c,
		ReadRegister1 => ReadRegister1_c,
		ReadRegister2 => ReadRegister2_c,
		WriteRegister => WriteRegister_c
	);

	tb : PROCESS
	BEGIN

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;									-- 100 ns

		-- test the bytemem first
		data_bm <= X"4F";
		wait for 5 ns;										-- 105 ns
		rdwr_bm <= '1';
		wait for 5 ns;										-- 110 ns
		rdwr_bm <= '0';
		data_bm <= "ZZZZZZZZ";
		wait for 5 ns;										-- 115 ns
		enout_bm <= '0'; -- data_bm should be 4F
		wait for 20 ns;										-- 135 ns
		
		-- test the register32 next
		datain_r32 <= X"5A5A5A5A";  
		wait for 5 ns;										-- 140 ns
		writein32_r32 <= '1'; -- can't tell if it took yet
		wait for 5 ns;										-- 145 ns
		writein32_r32 <= '0';
		datain_r32 <= "ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"; 
		wait for 5 ns;  									-- 150 ns 
		enout32_r32 <= '0'; 
		wait for 5 ns;  -- data should be 0x5A5A5A5A		-- 155 ns
		enout32_r32 <= '1'; 
		wait for 5 ns;  -- data should be ZZZZZZZZ			-- 160 ns
		datain_r32 <= X"A5A5A5A5";
		wait for 5 ns;										-- 165 ns
		writein32_r32 <= '1';
		wait for 5 ns;										-- 170 ns
		writein32_r32 <= '0';
		wait for 5 ns;										-- 175 ns
		datain_r32 <= (others => 'Z');
		wait for 5 ns;										-- 180 ns
		enout32_r32 <= '0';
		wait for 5 ns;  -- data should be 0xA5A5A5A5		-- 185 ns
		enout32_r32 <= '1';
		wait for 5 ns;										-- 190 ns

		-- test the byte_array next
		data_ba <= X"27"; 
		address_ba <= "0000";
		wait for 5 ns;										-- 195 ns
		rdwr_ba <= '0';
		wait for 5 ns;										-- 200 ns
		rdwr_ba <= '1';
		wait for 5 ns;										-- 205 ns
		data_ba <= X"D9";
		address_ba <= "0100";
		wait for 5 ns;										-- 210 ns
		rdwr_ba <= '0';
		wait for 5 ns;										-- 215 ns
		rdwr_ba <= '1';
		wait for 5 ns;										-- 220 ns
		data_ba <= (others => 'Z');
		address_ba <= "0000";
		wait for 5 ns;										-- 225 ns
		enout_ba <= '0';
		wait for 5 ns;	-- should be X"27"					-- 230 ns
		enout_ba <= '1';
		wait for 5 ns;										-- 235 ns
		address_ba <= "0100";
		wait for 5 ns;										-- 240 ns
		enout_ba <= '0';
		wait for 5 ns;	-- should be X"D9"					-- 245 ns
		enout_ba <='1';
		wait for 5 ns;										-- 250 ns
		
		
		-- finally test the controller
		instruction_c <= "10001011000010110000000100000110"; -- ADD X6, X8, X11
		wait for 5 ns;										-- 255 ns
		clock_c <= '1'; -- ALU_Ctrl_c should be 0010
		wait for 5 ns;  -- ReadRegister1_c should be 01000	-- 260 ns
		clock_c <= '0'; -- ReadRegister2_c should be 01011
		wait for 5 ns;  -- WriteRegister_c should be 0011	-- 265 ns
		instruction_c <= "11001011000001100000001010100111"; -- SUB X7, X21, X6
		wait for 5 ns;										-- 270 ns
		clock_c <= '1'; -- ALU_Ctrl_c shold be 0110
		wait for 5 ns;	-- ReadRegister1_c should be		-- 275 ns
		clock_c <= '0'; -- ReadRegister2_c should be
		wait for 5 ns;  -- WriteRegister_c shoult be		-- 280 ns
		
		wait; -- will wait forever
	END PROCESS;

END;

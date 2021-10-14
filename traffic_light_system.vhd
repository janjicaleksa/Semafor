library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_system is
	port (
		reset 	: in std_logic;
		clk 	: in std_logic; 
		rc	: out std_logic;
		yc	: out std_logic;
		gc	: out std_logic;
		rp	: out std_logic;
		gp	: out std_logic;
		display0 	: out std_logic_vector(6 downto 0);
		display1 	: out std_logic_vector(6 downto 0)
	);
end traffic_light_system;

architecture Rtl of traffic_light_system is
	component bcd_to_7seg is
	port (
		digit	: in integer;
		display	: out std_logic_vector(6 downto 0)
	);	
	end component;

	--component bcd_to_7seg_2 is
	--port (
	--	digit2	: in integer;
	--	display2	: out std_logic_vector(6 downto 0)
	--);	
	--end component;

	component traffic_light is
   	port (
        	reset   : in std_logic;
        	clk     : in std_logic;
        	rc      : out std_logic;
		yc      : out std_logic;
		gc      : out std_logic;
		rp      : out std_logic;
		gp      : out std_logic;
		time_d1 : out integer;
		time_d2 : out integer
	    );
	end component;

	signal digit1	: integer;
	signal digit2	: integer;	
begin
	
	TL_INST: traffic_light port map (reset => reset, clk => clk, rc => rc, yc => yc, gc => gc, rp => rp, gp => gp, time_d1 => digit1, time_d2 => digit2);
	BCD_INST_1: bcd_to_7seg port map (digit => digit1, display => display0);
	BCD_INST_2: bcd_to_7seg port map (digit => digit2, display => display1);
	
end architecture Rtl;
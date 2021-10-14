library ieee;
use ieee.std_logic_1164.all;

entity traffic_light_tb is
end traffic_light_tb ;

architecture Test of traffic_light_tb is
	
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
		signal reset   : std_logic;
	        signal clk     : std_logic := '1';
	        signal rc      : std_logic;
		signal yc      : std_logic;
		signal gc      : std_logic;
		signal rp      : std_logic;
		signal gp      : std_logic;
		signal time_d1 : integer;
		signal time_d2 : integer;

		constant C_CLK_PERIOD : time := 125 ms;
begin
	TL	: traffic_light port map (reset,clk,rc,yc,gc,rp,gp,time_d1,time_d2);

	CLK_GEN: process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD/2;
		clk <= '0';
		wait for C_CLK_PERIOD/2;
	end process CLK_GEN;

	STIMULUS: process
	begin
		reset <= '1';
		wait for C_CLK_PERIOD;
		reset <= '0';
		wait for 1500*C_CLK_PERIOD;
		reset <= '1';
		wait;
	end process STIMULUS;

end Test;
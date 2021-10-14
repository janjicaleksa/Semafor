library ieee;
use ieee.std_logic_1164.all;

entity bcd_to_7seg is
	port (
		digit	: in integer;
		display	: out std_logic_vector(6 downto 0)
	);	
end bcd_to_7seg;

architecture Behavioral of bcd_to_7seg is
	signal D0 : std_logic_vector(6 downto 0) := "0111111";
	signal D1 : std_logic_vector(6 downto 0) := "0000110";
	signal D2 : std_logic_vector(6 downto 0) := "1011011";
	signal D3 : std_logic_vector(6 downto 0) := "1001111";
	signal D4 : std_logic_vector(6 downto 0) := "1100110";
	signal D5 : std_logic_vector(6 downto 0) := "1101101";
	signal D6 : std_logic_vector(6 downto 0) := "1111101";
	signal D7 : std_logic_vector(6 downto 0) := "0000111";
	signal D8 : std_logic_vector(6 downto 0) := "1111111";
	signal D9 : std_logic_vector(6 downto 0) := "1101111";
	signal Dothers : std_logic_vector(6 downto 0) := "0000000";
begin
		display(6 downto 0) <= D0 when (digit = 0) else  
		D1 when (digit = 1) else
		D2 when (digit = 2) else
		D3 when (digit = 3) else
		D4 when (digit = 4) else
		D5 when (digit = 5) else
		D6 when (digit = 6) else
		D7 when (digit = 7) else
		D8 when (digit = 8) else
		D9 when (digit = 9) else
		Dothers;
end Behavioral;
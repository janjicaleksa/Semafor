library ieee;
use ieee.std_logic_1164.all;

entity traffic_light is
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
end traffic_light;


architecture Behavioral of traffic_light is
	type State_t is (redRed1, redGreen, redRed2, redYellowRed, greenRed, yellowRed);
	signal state_reg, next_state : State_t;

	constant FREQUENCY: integer := 8;
	
	signal outputNumber : integer := 21;
	signal counter : integer range 0 to 22*FREQUENCY := 2*FREQUENCY;
begin
	
	STATE_TRANSITION: process (clk) is
	begin
		if rising_edge(clk) then
            		if reset = '1' then
            			state_reg <= redRed1;
          	 	else
          	 		state_reg <= next_state;
          	 	end if;
       		end if;

	end process STATE_TRANSITION;

	TIME_COUNTING: process (clk, counter) is 
	begin
		if rising_edge(clk) then
			if counter > 1 then 
				counter <= counter - 1;
			else 			
				case state_reg is
				when redRed1 =>
					counter <= 9*FREQUENCY;
				when redGreen =>
					counter <= 2*FREQUENCY;
				when redRed2 =>
					counter <= FREQUENCY;
				when redYellowRed =>
					counter <= 22*FREQUENCY;
				when greenRed =>
					counter <= FREQUENCY;
				when yellowRed =>
					counter <= 2*FREQUENCY;
				end case;
			
			end if;
		end if;
	end process TIME_COUNTING;

	NEXT_STATE_LOGIC: process (state_reg, counter) is	
	begin
		case (state_reg) is
			when redRed1 =>
				if (counter > 1) then
					next_state <= redRed1;
				else 
					next_state <= redGreen;
				end if;
			when redGreen =>
				if(counter > 1) then
					next_state <= redGreen;
				else
					next_state <= redRed2;
				end if;
			when redRed2 =>
				if(counter > 1) then
					next_state <= redRed2;
				else 
					next_state <= redYellowRed;
				end if;
			when redYellowRed =>
				if(counter > 1) then
					next_state <= redYellowRed;
				else 
					next_state <= greenRed;
				end if;
			when greenRed =>
				if(counter > 1) then
					next_state <= greenRed;
				else 
					next_state <= yellowRed;
				end if;
			when yellowRed =>
				if(counter > 1) then
					next_state <= yellowRed;
				else 
					next_state <= redRed1;
				end if;
		end case;
	end process NEXT_STATE_LOGIC;

	OUTPUT_LOGIC: process (state_reg, counter) is
	begin
		case (state_reg) is
			when redRed1 =>
				rc     	<= '1';
				yc      <= '0';
				gc      <= '0';
				rp      <= '1';
				gp      <= '0';
				time_d1 <= 10;
				time_d2 <= 10;
			when redGreen =>
				rc     	<= '1';
				yc      <= '0';
				gc      <= '0';
				rp      <= '0';
				gp      <= '1';
				time_d1 <= 10;
				time_d2 <= 10;
			when redRed2 =>
				rc     	<= '1';
				yc      <= '0';
				gc      <= '0';
				rp      <= '1';
				gp      <= '0';
				time_d1 <= 10;
				time_d2 <= 10;
			when redYellowRed =>
				rc     	<= '1';
				yc      <= '1';
				gc      <= '0';
				rp      <= '1';
				gp      <= '0';
				time_d1 <= 10;
				time_d2 <= 10;
			when greenRed =>
				rc     	<= '0';
				yc      <= '0';
				gc      <= '1';
				rp      <= '1';
				gp      <= '0';
				
				if ((counter mod FREQUENCY = 0) and (counter /= 22*FREQUENCY)) then 
				outputNumber <= outputNumber - 1;
				end if;
				
				if ((outputNumber/10) > 0) then 
					time_d2 <= outputNumber/10;
				else
					time_d2 <= 10;
				end if;
 				time_d1 <= (outputNumber mod 10); 
				--time_d2 <= (((counter-8)/8)/10);
				--time_d1 <= (((counter-8)/8) mod 10);

			when yellowRed =>
				rc     	<= '0';
				yc      <= '1';
				gc      <= '0';
				rp      <= '1';
				gp      <= '0';
				time_d1 <= 10;
				time_d2 <= 10;
				outputnumber <= 21;
				
		end case;
	end process OUTPUT_LOGIC;

end architecture Behavioral;
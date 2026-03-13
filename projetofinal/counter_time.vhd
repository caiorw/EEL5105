library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter_time is
port (
    R, E, clock: in std_logic;
	segundos: out std_logic_vector(3 downto 0);
	endtime: out std_logic
);
end counter_time;
architecture counter_bhv of counter_time is
signal contador: std_logic_vector(3 downto 0); -- registra valor da contagem

begin
P1: process(clock, R, E, contador)
begin
	if R = '1' then
		contador <= "1010";
		endtime <= '0';
		segundos <= contador;
	elsif (clock'event and clock = '1') then
	    if (E='1') then
		    contador <= contador - 1;
		    segundos <= contador;
		    if (contador < "0001") then
			    endtime <= '1';
			    contador <= "0000";
		    else
			    endtime <= '0';
			end if;
		end if;
	end if;
end process;
end counter_bhv;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter_round is
port (
    R, E, clock: in std_logic;
	X: out std_logic_vector(3 downto 0);
	endround: out std_logic
);
end counter_round;
architecture counter_bhv of counter_round is
signal contador: std_logic_vector(3 downto 0); -- registra valor da contagem

begin
P1: process(R, E, clock, contador)
begin
	if R = '1' then
		contador <= "0000";
		endround <= '0';
	elsif (clock'event and clock = '1') then --and contador>"0000" ?
		if E = '1' then
		    contador <= contador + 1;
		    if contador = "1111" then
			    endround <= '1';
			    contador <= "1111";
		    else
			    endround <= '0';
			end if;
		end if;
	end if;
end process;
X <= contador;
end counter_bhv;

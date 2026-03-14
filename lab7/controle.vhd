library ieee;
use ieee.std_logic_1164.all;
entity controle is port (
c, Tm, clock, reset: in std_logic;
Tc, Tw: out std_logic);
end controle;
architecture bhv of controle is
type STATES is (Init,EWait,Count);
signal EA, PE: STATES;
begin
	
	P1: process(clock, reset)
	begin
		if reset='0' then
			EA <= Init;
		elsif clock'event and clock='1' then
			EA <= PE;
		end if;
	end process;
	
	P2: process(EA,Tm,c)
	begin
		case EA is
			when Init => 
				Tc<='1';
				Tw<='0';
				PE<=EWait;
			when EWait =>
				Tc<='0';
				Tw<='0';
				if Tm='0' then
					PE<=Init;
				else
					if c='0' then
						PE<=EWait;
					else
						PE<=Count;
					end if;
				end if;
			when Count =>
				Tc<='0';
				Tw<='1';
				PE<=EWait;
		end case;
	end process;
end bhv;
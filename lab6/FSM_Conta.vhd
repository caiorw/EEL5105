library ieee;
use ieee.std_logic_1164.all;
entity FSM_Conta is port(
clock: in std_logic;
reset: in std_logic;
L: in std_logic;
contagem: out std_logic_vector(3 downto 0)
);
end FSM_Conta;

architecture bhv of FSM_Conta is
type STATES is (E0,E1,E2,E3,E4);
signal EA, PE: STATES;

begin
P1: process(clock, reset)

begin
if reset= '0' then
EA <= E0;
elsif clock'event and clock= '1' then
EA <= PE;
end if;
end process;

P2: process(EA)

begin
	case EA is

		when E0 =>
			contagem <= "0001";
			if L = '0' then
			PE <= E1;
			else
			PE <= E4;
				end if;
		when E1 =>
			contagem <= "0010";
			if L = '0' then
			PE <= E2;
			else
			PE <= E0;
				end if;
		when E2 =>
			contagem <= "0011";
			if L = '0' then
			PE <= E3;
			else
			PE <= E1;
				end if;
		when E3 =>
			contagem <= "0100";
			if L = '0' then
			PE <= E4;
			else
			PE <= E2;
				end if;
		when E4 =>
			contagem <= "0101";
			if L = '0' then
			PE <= E0;
			else
			PE <= E3;
				end if;

end case;
end process;
end bhv;
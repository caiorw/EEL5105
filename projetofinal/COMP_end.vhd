library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity COMP_end is
port (
	bonus: in std_logic_vector(3 downto 0);
	endgame: out std_logic
);
end COMP_end;
architecture COMP_bhv of COMP_end is

begin
	endgame <= '1' when bonus="0000" else
	           '0';

end COMP_bhv;

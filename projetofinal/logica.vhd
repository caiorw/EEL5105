library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity logica is
port(
	round, bonus: in std_logic_vector(3 downto 0);
	nivel: in std_logic_vector(1 downto 0);
	result: out std_logic_vector(7 downto 0)
);
end logica;
architecture arc_logica of logica is
signal divround, divbonus: std_logic_vector(3 downto 0);
signal opround, opbonus: std_logic_vector(7 downto 0);

begin
    divbonus <= '0' & bonus(3 downto 1);
    divround <= "00" & round(3 downto 2);
    opbonus <= "00" & divbonus & "00";
    opround <= "0000" & divround;
    result <= ('0'&nivel&"00000") + (opbonus) + (opround);
end arc_logica;
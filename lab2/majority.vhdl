library IEEE;
use IEEE.Std_Logic_1164.all;
entity majority is
port (
SW: 	in 	std_logic_vector(9 downto 0);
LEDR: out	std_logic_vector(9 downto 0)
);
end majority;
architecture circuito_logico of majority is
signal D,E,F: std_logic;
begin
LEDR(0) <= D or E or F;
D <= SW(0) and SW(1);
E <= SW(0) and SW(2);
F <= SW(1) and SW(2);
end circuito_logico;
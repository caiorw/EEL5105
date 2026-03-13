library IEEE;
use IEEE.Std_Logic_1164.all;
entity modmajor is
port (
SW: 	in 	std_logic_vector(9 downto 0);
LEDR: out	std_logic_vector(9 downto 0)
);
end modmajor;
architecture circuito_logico of modmajor is
signal D,E,F: std_logic;
begin
LEDR(0) <= D and E and F;
D <= SW(0) and not(SW(1));
E <= SW(0) and not(SW(2));
F <= not(SW(1)) and not(SW(2));
end circuito_logico;
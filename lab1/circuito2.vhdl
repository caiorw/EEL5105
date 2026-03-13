library IEEE;
use IEEE.Std_Logic_1164.all;


entity circuito2 is
port (
SW: 	in 	std_logic_vector(9 downto 0);
LEDR: out	std_logic_vector(9 downto 0)
);
end circuito2;


architecture arc_circuito2 of circuito2 is
begin

LEDR(9) <= SW(9);
LEDR(8) <= SW(8);
LEDR(7) <= SW(7);
LEDR(6) <= SW(6);
LEDR(5) <= SW(5);
LEDR(4) <= SW(4);
LEDR(3) <= SW(3);
LEDR(2) <= SW(2);
LEDR(1) <= SW(1);
LEDR(0) <= SW(0);

end arc_circuito2;
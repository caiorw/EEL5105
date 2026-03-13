library IEEE;
use IEEE.Std_Logic_1164.all;


entity circuito1 is
port (
LEDR: out std_logic_vector(9 downto 0)
);
end circuito1;


architecture arc_circuito1 of circuito1 is
begin

LEDR(9) <= '1';
LEDR(8) <= '0';
LEDR(7) <= '1';
LEDR(6) <= '1';
LEDR(5) <= '0';
LEDR(4) <= '1';
LEDR(3) <= '0';
LEDR(2) <= '1';
LEDR(1) <= '1';
LEDR(0) <= '1';

end arc_circuito1;

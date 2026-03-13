library IEEE;
use IEEE.Std_Logic_1164.all;

entity modb is
port (C: in std_logic_vector(1 downto 0);
B: in std_logic_vector(3 downto 0);
R: out std_logic_vector(3 downto 0)
);
end modb;

architecture isoma4 of modb is
begin
R(0) <= (not C(0) and B(0)) or (not B(0) and C(1));
R(1) <= (not C(0) and B(1)) or (not B(1) and C(1));
R(2) <= (not C(0) and B(2)) or (not B(2) and C(1));
R(3) <= (not C(0) and B(3)) or (not B(3) and C(1));
end isoma4;
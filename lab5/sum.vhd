library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all; -- necessário para o +
entity sum is
port (F: in std_logic_vector(3 downto 0);
F1: in std_logic_vector(3 downto 0);
G: out std_logic_vector(3 downto 0)
);
end sum;
architecture circuito of sum is
begin
G <= F + F1;
end circuito;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; -- necessário para o +
entity subtracao is
port(
	bonus: in std_logic_vector(3 downto 0);
	diferenca: in std_logic_vector(3 downto 0);
	resultado: out std_logic_vector(3 downto 0)
);
end subtracao;
architecture circuito of subtracao is
signal c2bonus, c2erros, res: std_logic_vector(4 downto 0);
signal negativo: std_logic;

begin
    c2bonus <= '0'&bonus;
    c2erros <= '0'&diferenca;
    res <= c2bonus - c2erros;
    negativo <= res(4);
    resultado <= "0000" when negativo = '1' else
                res(3 downto 0);
end circuito;
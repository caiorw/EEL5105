library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM3a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM3a;

architecture arc_ROM3a of ROM3a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "100100001101010" when address = "0000" else
"101110001100000" when address = "0001" else
"000001110111000" when address = "0010" else
"100100110000101" when address = "0011" else
"011010101010000" when address = "0100" else
"000100011011001" when address = "0101" else
"101100010001010" when address = "0110" else
"001011100100100" when address = "0111" else
"000100100110101" when address = "1000" else
"001010010010011" when address = "1001" else
"101000100010110" when address = "1010" else
"000110001101001" when address = "1011" else
"110001100010001" when address = "1100" else
"001000110110001" when address = "1101" else
"010010010110001" when address = "1110" else
"000111000101010";
			 
end arc_ROM3a;

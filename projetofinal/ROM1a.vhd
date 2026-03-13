library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM1a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM1a;

architecture arc_ROM1a of ROM1a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "010101001000000" when address = "0000" else
"010000101100000" when address = "0001" else
"000100010100100" when address = "0010" else
"100110000100000" when address = "0011" else
"000001010000101" when address = "0100" else
"000001000100011" when address = "0101" else
"000101000010100" when address = "0110" else
"101000100100000" when address = "0111" else
"100100000000110" when address = "1000" else
"001001010001000" when address = "1001" else
"000010001101000" when address = "1010" else
"110000100000001" when address = "1011" else
"010001010000010" when address = "1100" else
"100101000000010" when address = "1101" else
"001011010000000" when address = "1110" else
"101100100000000";
			 
end arc_ROM1a;
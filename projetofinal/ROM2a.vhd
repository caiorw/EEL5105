library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM2a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM2a;

architecture arc_ROM2a of ROM2a is
begin

--         switches 0 a 14
--         EDCBA9876543210                 round
output <= "000010110010100" when address = "0000" else
"001100000000111" when address = "0001" else
"010010100010010" when address = "0010" else
"010110010000100" when address = "0011" else
"010010000100101" when address = "0100" else
"000001100110100" when address = "0101" else
"010001000110100" when address = "0110" else
"100001110000100" when address = "0111" else
"001001100010001" when address = "1000" else
"000111010000001" when address = "1001" else
"101010100000010" when address = "1010" else
"010110100010000" when address = "1011" else
"001101100000100" when address = "1100" else
"001101100100000" when address = "1101" else
"000100101000101" when address = "1110" else
"101110000010000";
			 
end arc_ROM2a;

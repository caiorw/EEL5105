library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM0a is
port(
	  address: in std_logic_vector(3 downto 0);
	  output : out std_logic_vector(14 downto 0)
);
end ROM0a;

architecture arc_ROM0a of ROM0a is
begin

output <= "000000100100100" when address = "0000" else
"001100000001000" when address = "0001" else
"000001000010001" when address = "0010" else
"000001101000000" when address = "0011" else
"100000100010000" when address = "0100" else
"000010010000100" when address = "0101" else
"001000100000001" when address = "0110" else
"000010110000000" when address = "0111" else
"010100000010000" when address = "1000" else
"100000001100000" when address = "1001" else
"000000110010000" when address = "1010" else
"000110000000001" when address = "1011" else
"100001010000000" when address = "1100" else
"000000100110000" when address = "1101" else
"100000001100000" when address = "1110" else
"100011000000000";

end arc_ROM0a;

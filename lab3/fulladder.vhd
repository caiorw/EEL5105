library IEEE;
use IEEE.Std_Logic_1164.all;
entity fulladder is
port (A: in std_logic;
B: in std_logic;
Cin: in std_logic;
Sum: out std_logic;
Cout: out std_logic
);
end fulladder;
architecture arc_fulladder of fulladder is
begin
Sum <= (A xor B) xor Cin;
Cout <= (Cin and (A xor B)) or (A and B);
end arc_fulladder;
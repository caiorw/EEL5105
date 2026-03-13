library IEEE;
use IEEE.Std_Logic_1164.all;

entity Subtrador is
port(SW: in std_logic_vector(9 downto 0);
	LEDR: out std_logic_vector(9 downto 0)
	);
end Subtrador ;

architecture soma4 of Subtrador is
    signal R: std_logic_vector(3 downto 0); 
    signal CY: std_logic_vector(3 downto 0);

component modb is
    port (C: in std_logic_vector(1 downto 0);
B: in std_logic_vector(3 downto 0);
R: out std_logic_vector(3 downto 0)
);
end component;

component fulladder is
    port (A: in std_logic;
B: in std_logic;
Cin: in std_logic;
Sum: out std_logic;
Cout: out std_logic
);
end component;

begin
    MB: modb port map(SW(9 downto 8),SW(7 downto 4),R(3 downto 0));
    FA1: fulladder port map(SW(0),R(0),SW(8),LEDR(0),CY(0));
    FA2: fulladder port map(SW(1),R(1),CY(0),LEDR(1),CY(1));
    FA3: fulladder port map(SW(2),R(2),CY(1),LEDR(2),CY(2));
    FA4: fulladder port map(SW(3),R(3),CY(2),LEDR(3),CY(3));

    LEDR(9) <= CY(2) XOR CY(3);

end soma4;
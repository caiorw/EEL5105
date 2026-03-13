library IEEE;
use IEEE.Std_Logic_1164.all;

entity topo is
port (SW: in std_logic_vector(9 downto 0);
	LEDR: out std_logic_vector(9 downto 0);
	HEX0: out std_logic_vector(6 downto 0)
	);
end topo;
architecture arc_topo of topo is
	signal F1,F2,F3,F4,F,G: std_logic_vector(3 downto 0);

component circuito1 is
	port (A: in std_logic_vector(2 downto 0);
B: in std_logic_vector(2 downto 0);
F1: out std_logic_vector(3 downto 0);
F2: out std_logic_vector(3 downto 0);
F3: out std_logic_vector(3 downto 0);
F4: out std_logic_vector(3 downto 0)
);
end component;

component mux is
	port (F1: in std_logic_vector(3 downto 0);
F2: in std_logic_vector(3 downto 0);
F3: in std_logic_vector(3 downto 0);
F4: in std_logic_vector(3 downto 0);
sel: in std_logic_vector(1 downto 0);
F: out std_logic_vector(3 downto 0)
);
end component;

component sum is
	port (F: in std_logic_vector(3 downto 0);
F1: in std_logic_vector(3 downto 0);
G: out std_logic_vector(3 downto 0)
);
end component;

component decod7seg is
	port (G: in std_logic_vector(3 downto 0);
out_hex: out std_logic_vector(6 downto 0)
);
end component;

begin 
-- entradas precisam ser A=SW(2 downto 0), B=SW(6 downto 4)
CC: circuito1 port map(SW(2 downto 0),SW(6 downto 4),F1,F2,F3,F4);
MULTIPLEX: mux port map(F1,F2,F3,F4,SW(9 downto 8),F);
SOMA: sum port map(F,F1,G);
DECOD: decod7seg port map(G,HEX0);

LEDR(3 downto 0)<=G;
end arc_topo;
library IEEE;
use IEEE.Std_Logic_1164.all;
entity topo is
port ( LEDR: out std_logic_vector(3 downto 0);
CLOCK_50: in std_logic;
KEY: in std_logic_vector(1 downto 0);
SW: in std_logic_vector(1 downto 0);
HEX0: out std_logic_vector(6 downto 0)
);
end topo;
architecture topo_beh of topo is
signal F: std_logic_vector(3 downto 0);
signal C2Hz: std_logic;

component FSM_Conta is
port (
contagem: out std_logic_vector(3 downto 0);
clock: in std_logic;
L: in std_logic;
reset: in std_logic
);
end component;

component decod7seg is
port (
G: in std_logic_vector(3 downto 0);
out_hex: out std_logic_vector(6 downto 0)
);
end component;

component div_freq is
port (
reset: in std_logic;
clock: in std_logic;
C2Hz: out std_logic
);
end component;

begin
DIVFREQ: div_freq port map(KEY(0),CLOCK_50,C2Hz);
L0: FSM_Conta port map (F,C2Hz,SW(0),KEY(0));
DISPLAY: decod7seg port map(F,HEX0);
LEDR(3 downto 0) <= F;
end topo_beh;
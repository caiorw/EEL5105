library ieee;
use ieee.std_logic_1164.all;

entity topo is port (
   KEY: in std_logic_vector(3 downto 0);
   SW: in std_logic_vector(9 downto 0);
   CLOCK_50: in std_logic;
   LEDR: out std_logic_vector(9 downto 0);
	HEX0: out std_logic_vector(6 downto 0)
	);
end topo;

architecture arqmachine of topo is
	signal m, r: std_logic_vector(6 downto 0); --m = valor máximo da contagem  --r = saída da contagem
	signal c, C1Hz: std_logic; --c = pause da contagem  --C1Hz = relógio de 1Hz
	signal Tw, Tc, Tm: std_logic;
-- Incluir signals se preciso
	
	
-- Declarar componentes
component datapath is
	port(
		m: in std_logic_vector(6 downto 0);
		r: out std_logic_vector(6 downto 0);
		clock, Tw, Tc: in std_logic;
		Tm: out std_logic
		);
end component;

component controle is
	port(
		c, Tm, clock, reset: in std_logic;
		Tc, Tw: out std_logic
		);
end component;		

component div_freq is
	port(
		reset: in std_logic;
		clock: in std_logic;
		C1Hz: out std_logic
		);
end component;

component decod7seg is
	port(
		G: in std_logic_vector(3 downto 0);
		out_hex: out std_logic_vector(6 downto 0)
		);
end component;

begin
	m <= SW(6 downto 0);
	c <= KEY(1);
	DIVFREQ: div_freq port map(KEY(0),CLOCK_50,C1Hz);
	CTR: controle port map(c,Tm,C1Hz,KEY(0),Tc,Tw);
	DTPH: datapath port map(m,r,C1Hz,Tw,Tc,Tm);
	LEDR(6 downto 0) <= r;
	DEC: decod7seg port map(r(3 downto 0),HEX0);
	-- Incluir instancias de Datapath e Controle e conectá-las...
end arqmachine;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity div_freq is
port ( reset: in std_logic;
clock: in std_logic;
C2Hz: out std_logic
);
end div_freq;
architecture div_bhv of div_freq is
signal contador: std_logic_vector(27 downto 0); -- registra valor da contagem

begin
P1: process(clock, reset, contador)
begin
if reset = '0' then
	contador <= x"0000000";
elsif clock'event and clock = '1' then
	contador <= contador + 1;
if contador = x"17D783F" then
	contador <= x"0000000";
	C2Hz <= '1';
else
C2Hz <= '0';
end if;
end if;
end process;
end div_bhv;
library IEEE;
use IEEE.Std_Logic_1164.all;


entity circuito3 is
port (
HEX5: out	std_logic_vector(6 downto 0);
HEX4: out	std_logic_vector(6 downto 0);
HEX3: out	std_logic_vector(6 downto 0);
HEX2: out	std_logic_vector(6 downto 0);
HEX1: out	std_logic_vector(6 downto 0);
HEX0: out	std_logic_vector(6 downto 0)
);
end circuito3;


architecture arc_circuito3 of circuito3 is
begin

-- Mostra a letra t no display HEX0
HEX5(6) <='1';		--ligado
HEX5(5) <='0';		--ligado
HEX5(4) <='0';		--ligado
HEX5(3) <='0';		--ligado
HEX5(2) <='1';		--desligado
HEX5(1) <='1';		--desligado
HEX5(0) <='0';		--desligado

HEX4(6) <='0';		--ligado
HEX4(5) <='0';		--ligado
HEX4(4) <='0';		--ligado
HEX4(3) <='1';		--ligado
HEX4(2) <='0';		--desligado
HEX4(1) <='0';		--desligado
HEX4(0) <='0';		--desligado

HEX3(6) <='1';		--ligado
HEX3(5) <='1';		--ligado
HEX3(4) <='1';		--ligado
HEX3(3) <='1';		--ligado
HEX3(2) <='0';		--desligado
HEX3(1) <='0';		--desligado
HEX3(0) <='1';		--desligado

HEX2(6) <='1';		--ligado
HEX2(5) <='0';		--ligado
HEX2(4) <='0';		--ligado
HEX2(3) <='0';		--ligado
HEX2(2) <='0';		--desligado
HEX2(1) <='0';		--desligado
HEX2(0) <='0';		--desligado

HEX1(6) <='1';		--ligado
HEX1(5) <='1';		--ligado
HEX1(4) <='1';		--ligado
HEX1(3) <='1';		--ligado
HEX1(2) <='1';		--desligado
HEX1(1) <='1';		--desligado
HEX1(0) <='1';		--desligado

HEX0(6) <='1';		--ligado
HEX0(5) <='1';		--ligado
HEX0(4) <='1';		--ligado
HEX0(3) <='1';		--ligado
HEX0(2) <='1';		--desligado
HEX0(1) <='1';		--desligado
HEX0(0) <='1';		--desligado

-- Completar para os outros displays HEX4, HEX3 ... HEX0

end arc_circuito3;
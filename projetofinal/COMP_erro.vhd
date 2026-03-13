library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity COMP_erro is
port (
	auxcode, swuser: in std_logic_vector(14 downto 0);
	erros: out std_logic_vector(3 downto 0)
);
end COMP_erro;
architecture COMP_bhv of COMP_erro is
signal aux: std_logic_vector(14 downto 0);

begin
	aux <= (not swuser) and auxcode;
	erros <= ("000"&aux(14))+("000"&aux(13))+("000"&aux(12))+("000"&aux(11))+("000"&aux(10))+("000"&aux(9))+("000"&aux(8))+("000"&aux(7))+("000"&aux(6))+("000"&aux(5))+("000"&aux(4))+("000"&aux(3))+("000"&aux(2))+("000"&aux(1))+("000"&aux(0));

end COMP_bhv;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity datapath is
port(
	-- Entradas de dados
	clk: in std_logic;
	SW: in std_logic_vector(17 downto 0);
	
	-- Entradas de controle
	R1, R2, E1, E2, E3, E4, E5: in std_logic;
	
	-- Saídas de dados
	hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7: out std_logic_vector(6 downto 0);
	ledr: out std_logic_vector(15 downto 0);
	
	-- Saídas de status
	end_game, end_time, end_round, end_FPGA: out std_logic
);
end datapath;

architecture arquitetura_dpt of datapath is
    signal tempo, X, testando: std_logic_vector(3 downto 0); --contadores
    
    signal CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: std_logic; --FSM_clock
    
    signal RESULT: std_logic_vector(7 downto 0); --Logica combinacional
    
    signal SEL: std_logic_vector(3 downto 0); 				--Registradores
    signal USER: std_logic_vector(14 downto 0); 			--Registradores
    signal b0nus: std_logic_vector(3 downto 0);
    signal Bonus_reg: std_logic_vector(3 downto 0); 	--Registradores
    
    signal CODE_aux: std_logic_vector(14 downto 0); 	--ROMs
    signal CODE: std_logic_vector(31 downto 0); 		--ROMs
    
    signal erros: std_logic_vector(3 downto 0); 	--COMP
    
    signal E23, E25, E12: std_logic; --NOR enables displays
    
    --signals implícitos--
    
    signal stermoround, stermobonus, andtermo: std_logic_vector(15 downto 0); --dec termometrico
    
    signal sdecod7, sdec7, sdecod6, sdec6, sdecod5, sdecod4, sdec4, sdecod3, sdecod2, sdec2, sdecod1, sdecod0, sdec0: std_logic_vector(6 downto 0); 	--decoders HEX 7-0
    signal smuxhex7, smuxhex6, smuxhex5, smuxhex4, smuxhex3, smuxhex2, smuxhex1, smuxhex0: std_logic_vector(6 downto 0); 								--decoders HEX 7-0
    signal edec2, edec0: std_logic_vector(3 downto 0); 																									--decoders HEX 7-0
    
    signal srom0, srom1, srom2, srom3: std_logic_vector(31 downto 0); 		--saida ROMs
    signal srom0a, srom1a, srom2a, srom3a: std_logic_vector(14 downto 0); 	--saida ROMs
    
    signal E2orE3: std_logic; --FSM_clock
-----------------COMPONENTS----------------
component counter_time is --pronto
port(
    R, E, clock: in std_logic;
	segundos: out std_logic_vector(3 downto 0);
	endtime: out std_logic
);
end component;

component counter_round is --pronto
port(
    R, E, clock: in std_logic;
	X: out std_logic_vector(3 downto 0);
	endround: out std_logic
);
end component;

component decoder_termometrico is --pronto
port(
	X: in  std_logic_vector(3 downto 0);
	S: out std_logic_vector(15 downto 0)
);
end component;

component FSM_clock_emu is --pronto
port(
	reset, E: in std_logic;
	clock: in std_logic;
	CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz: out std_logic
);
end component;

component decod7seg is --pronto
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
);
end component;

component d_code is --pronto
port(
	C: in std_logic_vector(3 downto 0);
	F: out std_logic_vector(6 downto 0)
);
end component;

component mux2x1_7bits is --pronto
port(
	E0, E1: in std_logic_vector(6 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(6 downto 0)
);
end component;

component mux2x1_16bits is --pronto
port(
	E0, E1: in std_logic_vector(15 downto 0);
	sel: in std_logic;
	saida: out std_logic_vector(15 downto 0)
);
end component;

component mux4x1_1bit is --pronto
port(
	E0, E1, E2, E3: in std_logic;
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic
);
end component;

component mux4x1_15bits is --pronto
port(
	E0, E1, E2, E3: in std_logic_vector(14 downto 0);
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic_vector(14 downto 0)
);
end component;

component mux4x1_32bits is --pronto
port(
	E0, E1, E2, E3: in std_logic_vector(31 downto 0);
	sel: in std_logic_vector(1 downto 0);
	saida: out std_logic_vector(31 downto 0)
);
end component;

component registrador_sel is --pronto
port(
	R, E, clock: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0)
);
end component;

component registrador_user is --pronto
port(
	R, E, clock: in std_logic;
	D: in std_logic_vector(14 downto 0);
	Q: out std_logic_vector(14 downto 0)
);
end component;

component registrador_bonus is --pronto
port(
	S, E, clock: in std_logic;
	D: in std_logic_vector(3 downto 0);
	Q: out std_logic_vector(3 downto 0)
);
end component;

component COMP_erro is --pronto
port(
	auxcode, swuser: in std_logic_vector(14 downto 0);
	erros: out std_logic_vector(3 downto 0)
);
end component;

component COMP_end is --pronto
port(
	bonus: in std_logic_vector(3 downto 0);
	endgame: out std_logic
);
end component;

component subtracao is --pronto
port(
	bonus: in std_logic_vector(3 downto 0);
	diferenca: in std_logic_vector(3 downto 0);
	resultado: out std_logic_vector(3 downto 0)
);
end component;

component logica is --pronto
port(
	round, bonus: in std_logic_vector(3 downto 0);
	nivel: in std_logic_vector(1 downto 0);
	result: out std_logic_vector(7 downto 0)
);
end component;

component ROM0 is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM1 is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM2 is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM3 is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(31 downto 0)
);
end component;

component ROM0a is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM1a is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM2a is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

component ROM3a is --pronto
port(
	address: in std_logic_vector(3 downto 0);
	output : out std_logic_vector(14 downto 0)
);
end component;

begin	-- COMEÇO DO CODIGO
-- o aluno deve interligar todas as componentes seguindo o modelo do datapath dado

E2orE3 <= E2 or E3;
E23 <= not(E2 or E3);
E25 <= not(E2 or E5);
E12 <= not(E2 or E1);
freq_emu: FSM_clock_emu port map(R1, E2orE3, clk, CLK_1Hz, CLK_050Hz, CLK_033Hz, CLK_025Hz, CLK_020Hz); -- Para usar no emulador
reg_setup: registrador_sel port map(R2,E1,clk,SW(3 downto 0),SEL);
sel_freq: mux4x1_1bit port map(CLK_020Hz,CLK_025Hz,CLK_033Hz,CLK_050Hz,SEL(1 downto 0),end_FPGA);
mem0: ROM0 port map(X,srom0);
mem1: ROM1 port map(X,srom1);
mem2: ROM2 port map(X,srom2);
mem3: ROM3 port map(X,srom3);
gabmem0: ROM0a port map(X,srom0a);
gabmem1: ROM1a port map(X,srom1a);
gabmem2: ROM2a port map(X,srom2a);
gabmem3: ROM3a port map(X,srom3a);
sel_fase: mux4x1_32bits port map(srom0,srom1,srom2,srom3,SEL(3 downto 2),CODE);
sel_gabarito: mux4x1_15bits port map(srom0a,srom1a,srom2a,srom3a,SEL(3 downto 2),CODE_aux);
reg_sw: registrador_user port map(R2,E3,clk,SW(14 downto 0),USER);
compara_user_codeaux: COMP_erro port map(CODE_aux,USER,erros);
deduzir: subtracao port map(Bonus_reg,erros,b0nus);
reg_bonus: registrador_bonus port map(R2,E4,clk,b0nus,Bonus_reg);
compara_0bonus: COMP_end port map(Bonus_reg,end_game);
calc_resultado: logica port map(X,Bonus_reg,SEL(1 downto 0),RESULT);

contatempo: counter_time port map(R1,E3,CLK_1Hz,tempo,end_time);
contarounds: counter_round port map(R2,E4,clk,X,end_round);

mostrabonus_leds: decoder_termometrico port map(Bonus_reg,stermobonus);
mostraround_leds: decoder_termometrico port map(X,stermoround);
andtermo <= not(E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1&E1) and stermoround;
muxleds: mux2x1_16bits port map(andtermo,stermobonus,SW(17),ledr(15 downto 0));

-- DISPLAY 0
decod_displ0: d_code port map(CODE(3 downto 0),sdecod0); --d_code
edec0 <= "00"&SEL(1 downto 0);
dec7_displ0: decod7seg port map(edec0,sdec0);
mux_displ0: mux2x1_7bits port map(sdecod0,sdec0,E1,smuxhex0);
-- DISPLAY 1
decod_displ1: d_code port map(CODE(7 downto 4),sdecod1); --d_code
mux_displ1: mux2x1_7bits port map(sdecod1,"1000111",E1,smuxhex1);
-- DISPLAY 2
decod_displ2: d_code port map(CODE(11 downto 8),sdecod2); --d_code
edec2 <= "00"&SEL(3 downto 2);
dec7_displ2: decod7seg port map(edec2,sdec2);
mux_displ2: mux2x1_7bits port map(sdecod2,sdec2,E1,smuxhex2);
-- DISPLAY 3
decod_displ3: d_code port map(CODE(15 downto 12),sdecod3); --d_code
mux_displ3: mux2x1_7bits port map(sdecod3,"1000110",E1,smuxhex3);
-- DISPLAY 4
decod_displ4: d_code port map(CODE(19 downto 16),sdecod4); --d_code
dec7_displ4: decod7seg port map(tempo,sdec4);
mux_displ4: mux2x1_7bits port map(sdecod4,sdec4,E3,smuxhex4);
-- DISPLAY 5
decod_displ5: d_code port map(CODE(23 downto 20),sdecod5); --d_code
mux_displ5: mux2x1_7bits port map(sdecod5,"0000111",E3,smuxhex5);
-- DISPLAY 6
decod_displ6: d_code port map(CODE(27 downto 24),sdecod6); --d_code
dec7_displ6: decod7seg port map(RESULT(3 downto 0),sdec6);
mux_displ6: mux2x1_7bits port map(sdecod6,sdec6,E5,smuxhex6);
-- DISPLAY 7
decod_displ7: d_code port map(CODE(31 downto 28),sdecod7); --d_code
dec7_displ7: decod7seg port map(RESULT(7 downto 4),sdec7);
mux_displ7: mux2x1_7bits port map(sdecod7,sdec7,E5,smuxhex7);
HEX0 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex0;
HEX1 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex1;
HEX2 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex2;
HEX3 <= (E12&E12&E12&E12&E12&E12&E12) or smuxhex3;
HEX4 <= (E23&E23&E23&E23&E23&E23&E23) or smuxhex4;
HEX5 <= (E23&E23&E23&E23&E23&E23&E23) or smuxhex5;
HEX6 <= (E25&E25&E25&E25&E25&E25&E25) or smuxhex6;
HEX7 <= (E25&E25&E25&E25&E25&E25&E25) or smuxhex7;
end arquitetura_dpt;

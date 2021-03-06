library IEEE; 
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL; 
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

entity autoplay is 
	port(clk: in std_logic; 
		clr:in std_logic; --这里声明了一个复位端口
		index_auto : out std_logic_vector(4 downto 0)); 
end autoplay;
 
architecture behave of autoplay is 
	signal  count :integer range 0 to 136; --length of music
	signal jiepai: std_logic;  
	signal j: integer range 0 to 2; 
	
begin 

jiepai1:  process(clk) --分频产生16Hz 的节拍
	begin 
	if clk' event and clk = '1' then 
		if j = 2 then --original j is 1562500
			j <= 0; 
			jiepai <= not jiepai; 
		else j <= j+1; 
		end if; 
	end if; 

end process jiepai1; 

process(jiepai,clr) 
begin 
	if(clr='0') then 	
		if jiepai'event and jiepai='1' then --这里相当于一个计数器
			if count=136 then count<=0; --可根据乐曲长度改变
			else count<=count+1; 
			end if; 
		end if; 
	else count<=0; 
	end if; 
end process; 

music:process(count)--歌曲 jingle  bells 
begin 
	case count is --此 case语句：存储自动演奏部分的曲谱
		when 0 => index_auto<="11011";  --3 第一小节
		when 1 => index_auto<="11011";  --3 
		when 2 => index_auto<="11011";  --3 
		when 3 => index_auto<="10000"; --0 --这里代表乐曲中的适当停顿
		when 4 => index_auto<="11011";  --3 
		when 5 => index_auto<="11011";  --3 
		when 6 => index_auto<="11011";  --3 
		when 7 => index_auto<="10000"; --0 
		when 8 => index_auto<="11011";  --3 
		when 9 => index_auto<="11011";  --3 
		when 10 =>index_auto<="11011"; --3 
		when 11=> index_auto<="11011";  --3 
		when 12=> index_auto<="11011";  --3 
		when 13=> index_auto<="11011";  --3 
		when 14=> index_auto<="11011";  --3 
		when 15=> index_auto<="10000"; --0 
		when 16=> index_auto<="11011";  --3 
		when 17 => index_auto<="11011";  --3 
		when 18 => index_auto<="11011";  --3 
		when 19 => index_auto<="10000"; --0 
		when 20=> index_auto<="11011";  --3 
		when 21=> index_auto<="11011";  --3 
		when 22=> index_auto<="11011";  --3 
		when 23=> index_auto<="10000"; --0 
		when 24=> index_auto<="11011";  --3 
		when 25 => index_auto<="11011";  --3 
		when 26=>index_auto<="11011"; --3 
		when 27=> index_auto<="11011";  --3 
		when 28=> index_auto<="11011";  --3 
		when 29=> index_auto<="11011";  --3 
		when 30=> index_auto<="11011";  --3 
		when 31=> index_auto<="10000"; --0 
		when 32=> index_auto<="10000"; --0 
		when 33=> index_auto<="10000"; --0 
		when 34=> index_auto<="10000"; --0 
		
		when 35=> index_auto<="11011";  --3 --第二小节
		when 36=> index_auto<="11011";  --3 
		when 37=> index_auto<="11011";  --3 
		when 38=> index_auto<="10000"; --0 
		when 39=> index_auto<="11101";  --5 
		when 40=> index_auto<="11101";  --5 
		when 41=> index_auto<="11101";  --5 
		--0 
		when 42=> index_auto<="10000"; 
		--1 
		when 43=> index_auto<="11001"; 
		--1 
		when 44=> index_auto<="11001"; 
		--1 
		when 45=> index_auto<="11001"; 
		--1 
		when 46=> index_auto<="11001"; 
		--0 
		when 47=> index_auto<="10000"; 
		--2 
		when 48=> index_auto<="11010"; 
		--2 
		when 49=> index_auto<="11010"; 
		--0 
		when 50=> index_auto<="10000"; 
		when 51=> index_auto<="11011";  --3 
		when 52=> index_auto<="11011";  --3 
		when 53=> index_auto<="11011";  --3 
		when 54=> index_auto<="11011";  --3 
		when 55=> index_auto<="11011";  --3 
		when 56=> index_auto<="11011";  --3 
		when 57=> index_auto<="11011";  --3 
		when 58=> index_auto<="11011";  --3 
		when 59=> index_auto<="11011";  --3 
		when 60=> index_auto<="11011";  --3 
		when 61=> index_auto<="11011";  --3 
		when 62=> index_auto<="11011";  --0 
		--0 
		when 63=> index_auto<="10000"; 
		when 64=> index_auto<="10000"; 
		--0 
		--0 
		when 65=> index_auto<="10000"; 
		when 66=> index_auto<="10000"; 
		--0 
		--0 
		when 67=> index_auto<="10000"; 
		when 68=> index_auto<="10000"; 
		--0 
		when 69=> index_auto<="10000"; 
		--0 
		when 70=> index_auto<="11100";  --4 --第三小节
		when 71=> index_auto<="11100";  --4 
		when 72=> index_auto<="11100";  --4 
		when 73=> index_auto<="10000"; 
		--0 
		when 74=> index_auto<="11100";  --4 
		when 75=> index_auto<="11100";  --4 
		when 76=> index_auto<="11100";  --4 
		when 77=> index_auto<="10000"; 
		--0 
		when 78=> index_auto<="11100";  --4 
		when 79=> index_auto<="11100";  --4 
		when 80=> index_auto<="11100";  --4 
		when 81=> index_auto<="11100";  --4 
		when 82=> index_auto<="10000"; 
		--0 
		when 83=> index_auto<="11100";  --4 
		when 84=> index_auto<="11100";  --4 
		--0 
		when 85=> index_auto<="10000"; 
		when 86=> index_auto<="11100";  --4 
		when 87=> index_auto<="11100";  --4 
		when 88=> index_auto<="11100";  --4 
		when 89=> index_auto<="10000"; 
		--0 
		when 90=> index_auto<="11011";  --3 
		when 91=> index_auto<="11011";  --3 
		when 92=> index_auto<="11011";  --3 
		when 93=> index_auto<="10000"; 
		--0 
		when 94=> index_auto<="11011";  --3 
		when 95=> index_auto<="11011";  --3 
		when 96=> index_auto<="11011";  --0 
		when 97=> index_auto<="11011";  --3 
		when 98=> index_auto<="11011";  --3 
		when 99=> index_auto<="11011";  --0 
		when 100=> index_auto<="11011";  --3 
		when 101=> index_auto<="11011";  --3 
		
		when 102=> index_auto<="11101";  --5 --第四小节
		when 103=> index_auto<="11101";  --5 
		when 104=> index_auto<="11101";  --5 
		when 105=> index_auto<="10000"; 
		--0 
		when 106=> index_auto<="11101";  --5 
		when 107=> index_auto<="11101";  --5 
		when 108=> index_auto<="11101";  --5 
		when 109=> index_auto<="10000"; 
		--0 
		when 110=> index_auto<="11101";  --4 
		when 111=> index_auto<="11100";  --4 
		when 112=> index_auto<="11100";  --4 
		when 113=> index_auto<="10000";  --0 
		when 114=> index_auto<="11010";  --2 
		when 115=> index_auto<="11010";  --2 
		when 116=> index_auto<="11010";  --2 
		when 117=> index_auto<="10000";  --0 
		when 118=> index_auto<="11001";  --1 
		when 119=> index_auto<="11001";  --1 
		when 120=> index_auto<="11001";  --1 
		when 121=> index_auto<="11001";  --1 
		when 122=> index_auto<="11001";  --1 
		when 123=> index_auto<="11001";  --1 
		when 124=> index_auto<="11001";  --1 
		when 125=> index_auto<="11001";  --1 
		when 126=> index_auto<="11001";  --1 
		when 127=> index_auto<="11001";  --1 
		when 128=> index_auto<="11001";  --1 		
		when 129=> index_auto<="10000";--0 		
		when 130=> index_auto<="10000"; 
		when 131=> index_auto<="10000"; 
		when 132=> index_auto<="10000"; 
		when 133=> index_auto<="10000"; 
		when 134=> index_auto<="10000"; 
		when 135=> index_auto<="10000"; 
		when 136=> index_auto<="10000"; 
		when others => null; 
		end case; 
end process; 
end behave;
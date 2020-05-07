library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith; 
use ieee.std_logic_unsigned.all; 

entity keyplay is 
port( 
	pitch_low,pitch_middle,pitch_high:in std_logic; --代表高中低音的选择 
	do, re, mi, fa, so, la, ti:in std_logic;
	index_key:out std_logic_vector(4 downto 0)); 
end; 

architecture behave of keyplay is 
    signal md:std_logic_vector(6 downto 0); 
begin 
    md<=ti&la&so&fa&mi&re&do; --将按键和模式统一编码
 
    process(pitch_low,pitch_middle,pitch_high)
	begin
		if (pitch_low='1') then
			index_key(4 downto 3)<="00";
		elsif (pitch_middle='1') then
			index_key(4 downto 3)<="01";
		elsif (pitch_high='1') then
			index_key(4 downto 3)<="11";
		else index_key(4 downto 3)<="01";
		end if;
	end process;
	
	process(md) 
    begin			
		case md is 	
			when "0000001"=> index_key(2 downto 0)<="001"; -- 按键从右到左依次表示do,re,mi,fa,sol,la,ti 
			when "0000010"=> index_key(2 downto 0)<="010"; 
			when "0000100"=> index_key(2 downto 0)<="011"; 
			when "0001000"=> index_key(2 downto 0)<="100"; 
			when "0010000"=> index_key(2 downto 0)<="101"; 
			when "0100000"=> index_key(2 downto 0)<="110"; 
			when "1000000"=> index_key(2 downto 0)<="111"; 
			when others   => index_key(2 downto 0)<="000"; 		
			end case; 
    end process ; 
end behave;
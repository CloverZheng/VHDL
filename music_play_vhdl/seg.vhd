library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

ENTITY seg IS 
	PORT(clk:in std_logic; 
		index_pitch:in std_logic_vector(1 downto 0);
		index_tone: in std_logic_vector(2 downto 0);
		seg_5,seg_6:out std_logic; 				
		a,b,c,d,e,f,g,dp:OUT std_logic); 
END seg; 

ARCHITECTURE behav OF SEG IS 
	signal led:std_logic_vector(7 downto 0); 
	signal clk_tmp:std_logic; 
	signal cnt:integer range 0 to 24999; 
	signal seg_tmp:std_logic_vector(1 downto 0); 
	
BEGIN 
	dp<=led(7);
	g<=led(6);
	f<=led(5);
	e<=led(4);
	d<=led(3);
	c<=led(2);
	b<=led(1);
	a<=led(0);
	seg_5<=seg_tmp(1);
	seg_6<=seg_tmp(0);
	
p1:process(clk_tmp) --one led show pitch, the other one show level
begin 
	if(clk_tmp'event and clk_tmp='1') then 
		case seg_tmp is --������źŵ�ɨ��
			when"10"=>seg_tmp<="01"; 
			when"01"=>seg_tmp<="10"; 
			when others=>seg_tmp<="10"; 
		end case;	
	end if; 
	
	if(seg_tmp="01") then --both segment and led are low level active
		case index_tone is --��һ��ѡͨ��������ʾ��Ӧ����������
			when "000"=>led<= "11111111"; --empty
			when "001"=>led<= "10100111"; --c
			when "010"=>led<= "10100001"; --d
			when "011"=>led<= "10000100"; --e
			when "100"=>led<= "10001110"; --f
			when "101"=>led<= "11000001"; --g		
			when "110"=>led<= "10001000"; --a
			when "111"=>led<= "10000011"; --b
			when others=>led<="11111111"; 
		end case; 
	elsif(seg_tmp="111101") then --�� 2 ��ѡͨ��������ʾ��Ӧ���е���ģʽ
		case index_pitch is 
			when "00"=>led<= "10011001"; --low,4
			when "01"=>led<= "10010010"; --middle,5
			when "10"=>led<= "11111111"; 
			when "11"=>led<= "10000010";--high,6
		end case; 
	else led<="11111111"; 
	end if; 
end process p1; 


p2:process(clk) --�����������ʾһ�����ʵ�ʱ��,every 1ms renew digital led
begin 
	if(clk'event and clk='1')then 
		if cnt=1 then --original cnt is 24999
			cnt<=0; 
			clk_tmp<=not clk_tmp; 
		else cnt<=cnt+1; 
		end if; 
	end if; 
end process p2; 

END behav;
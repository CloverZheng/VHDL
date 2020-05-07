library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_Unsigned.all; 
use ieee.std_logic_ARITH.all; 

entity lattice is 
port(clk:in std_logic; 
     lie:out std_logic_vector(7 downto 0); --��
     com:out std_logic_vector(7 downto 0); --��
     index_tone: in std_logic_vector(2 downto 0); 
     clr:in std_logic ); 
end lattice; 

architecture behav of lattice is 
	signal data_row:std_logic_vector(7 downto 0); 
	signal data_line:std_logic_vector(7 downto 0); 
	signal clk_tmp:std_logic; 
	signal cnt:integer range 0 to 1;  
	signal index1: std_logic_vector(2 downto 0); 
begin 

com<=data_line; 
lie<=data_row; 
index1<=index_tone;
p2:process(index1,clk_tmp,clr) 
    begin  
    if(clr='0') then 
			if(clk_tmp='1' and clk_tmp'event)then --����ʵ��������ɨ��
				case index1 is 
					when "001"=>--���� do
						data_line<="01111111";
						data_row<="01111111";						
					when "010"=>--���� 2
						data_line<="10111111";
						data_row<="00111111";		
					when "011"=>--���� 3
						data_line<="11011111";
						data_row<="00011111";					
					when "100"=>--���� 4
						data_line<="11101111";
						data_row<="00001111";					 
					when "101"=>--���� 5 ʱ,ɨ���ͼ�����
						data_line<="11110111";
						data_row<="00000111";						
					when "110"=>--���� 6 
						data_line<="11111011";
						data_row<="00000011";
					when "111"=>--���� 7 	
						data_line<="11111101";
						data_row<="00000001";
					when others=>--������ʱ
						data_line<="11111111";
						data_row<="11111111";
					end case; 
					
				end if;
					
		elsif(clr='1') then --��λ����ɨ���ͼ�����
			data_line<="11111111";
			data_row<="11111111";
			
		end if;  
end process p2; 

p3:process(clk) --�������ɨ��һ�����ʵ�ʱ��
begin 
if(clk'event and clk='1')then --every 1 ms renews lattice
	if cnt=1 then --original cnt is 24999, for simulation, turn it to 249
		cnt<=0; 
		clk_tmp<=not clk_tmp; 
	else 
		cnt<=cnt+1; 
	end if; 
end if; 
end process p3; 

end behav;
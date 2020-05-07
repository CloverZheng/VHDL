----------------------------------------------
-- button,replay: control
-- index_key,index_auto,index_store: input message
-- tone: output music
----------------------------------------------

library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith; 
use ieee.std_logic_unsigned.all; 

entity table is 
port(index_mode:in std_logic_vector(4 downto 0); --�����ǶԼ������������ı���
	 clr:in std_logic; 
	 tone:out integer range 0 to 100000 ); 
end table;
 
architecture search of table is 
	signal index: std_logic_vector(4 downto 0); 
	
begin  

p2:process(index,clr) 
begin 
	if(clr='0') then 
		case index is 
			when "00001"=> tone<=95554; --��Ӧ������ 1������Ƶϵ�� =50MHz/2(tone+1) 
			when "00010"=> tone<=85600; --��Ӧ������ 2
			when "00011"=> tone<=74849; --��Ӧ������ 3 
			when "00100"=> tone<=71592; --��Ӧ������ 4 
			when "00101"=> tone<=63775; --��Ӧ������ 5 
			when "00110"=> tone<=56818; --��Ӧ������ 6 
			when "00111"=> tone<=50619; --��Ӧ������ 7 
			when "01001"=> tone<=47773; --��Ӧ������ 1
			when "01010"=> tone<=42800; 
			when "01011"=> tone<=37922; 
			when "01100"=> tone<=35792; 
			when "01101"=> tone<=31887; 
			when "01110"=> tone<=28409; 
			when "01111"=> tone<=25309; 
			when "11001"=> tone<=23888; --��Ӧ������ 1
			when "11010"=> tone<=21282; 
			when "11011"=> tone<=18900; 
			when "11100"=> tone<=17896; 
			when "11101"=> tone<=16000; 
			when "11110"=> tone<=14204; 
			when "11111"=> tone<=12566; 
			when others => tone<=0; 
			end case; 
	elsif(clr='1') then tone<=0; --��λ��û���������
	end if; 
end process p2 ; 

end search; 
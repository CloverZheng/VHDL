library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

ENTITY mode IS 
	PORT(index_key:IN std_logic_vector(4 downto 0); 
		index_auto:IN std_logic_vector(4 downto 0); 
		index_store : in std_logic_vector(4 downto 0); 
		index_mode:out std_logic_vector (4 downto 0);
		index_pitch: out std_logic_vector(1 downto 0);
		index_tone: out std_logic_vector(2 downto 0);
		seg_in: out std_logic_vector(15 downto 0);
		button :in std_logic; 
		replay:in std_logic); 			
END mode; 

ARCHITECTURE behav OF mode IS 
	signal index: std_logic_vector(4 downto 0); 
	signal pitch: std_logic_vector(1 downto 0);
	signal tone: std_logic_vector(2 downto 0);
	
BEGIN 
	index_mode<=index;
	index_pitch<=pitch;
	index_tone<=tone;
	
p0:process(button,replay) --根据拨码选择对应的自动手动或者录音模式
begin 
	if ( button = '1'  and  replay = '0')then 
		index<= index_auto; 
		tone<= index_auto(2)&index_auto(1)&index_auto(0); 
		pitch<=index_auto(4)&index_auto(3);
	elsif (button = '0' and  replay = '0')then 
		index<=index_key;
		tone<= index_key(2)&index_key(1)&index_key(0); 
		pitch<=index_key(4)&index_key(3);
	elsif( button='0' and replay= '1') THEN 
		index<= index_store; 
		tone<= index_store(2)&index_store(1)&index_store(0); 
		pitch<=index_store(4)&index_store(3) ;
	end if; 
	
	case index is
		when "00001"=>seg_in<="0000000010010001";
		when "00010"=>seg_in<="0000000010010010";
		when "00011"=>seg_in<="0000000010010011";
		when "00100"=>seg_in<="0000000010010100";
		when "00101"=>seg_in<="0000000010010101";
		when "00110"=>seg_in<="0000000010010110";
		when "00111"=>seg_in<="0000000010010111";
		
		when "01001"=>seg_in<="0000000010010001";
		when "01010"=>seg_in<="0000000010010010";
		when "01011"=>seg_in<="0000000010010011";
		when "01100"=>seg_in<="0000000010010100";
		when "01101"=>seg_in<="0000000010010101";
		when "01110"=>seg_in<="0000000010010110";
		when "01111"=>seg_in<="0000000010010111";
		
		when "11001"=>seg_in<="0000000010010001";
		when "11010"=>seg_in<="0000000010010010";
		when "11011"=>seg_in<="0000000010010011";
		when "11100"=>seg_in<="0000000010010100";
		when "11101"=>seg_in<="0000000010010101";
		when "11110"=>seg_in<="0000000010010110";
		when "11111"=>seg_in<="0000000010010111";
		when others=>seg_in<="0000000000000000";
	end case;
	
end process p0; 


END behav;
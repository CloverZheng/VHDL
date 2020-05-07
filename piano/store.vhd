library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 

entity store is 
port(index_key : in std_logic_vector(4 downto 0); 
	clk : in std_logic; 
	store1: in std_logic; --¼������
	replay:in std_logic; --�ز�����
	clr : in std_logic; 
	index_store : out std_logic_vector(4 downto 0)); 
end store; 

architecture behave of store is 
	signal jishu : integer range 0 to 50; 
	signal xiabiao : integer range 0 to 50; 
	signal changdu : integer range 0 to 60; 
	signal jiepai : std_logic; 
	signal k : integer range 0 to 10000000; 
	type shuzu is array(100 downto 0) of std_logic_vector(4 downto 0);  --������ά����������
	signal shuzu1 : shuzu; 
	
begin 
	process(clk) 
	begin 		
		if clk' event and clk='1' then --����¼���Ľ���ʱ��		
			if k=1 then 			
				k <= 0; 
				jiepai <= not jiepai; 				
			else k <= k+1; 			
			end if; 		
		end if; 
	
	end process; 
	
	process(jiepai,index_key,store1,clr) --record what you input
	begin 	
		if store1 = '1' then 
		
			if clr = '1' then jishu<= 0; --��λ��Ч����¼���洢��ԭ���������
			elsif jiepai' event and jiepai='1' then 	--��ʼ¼���洢
				shuzu1(jishu)<= index_key; 
				if jishu=100 then jishu<=0; --once store 100 tone at most
				else jishu<=jishu+1; --¼��������Ŀ�� 1 
				end if; 
			end if; 
		else changdu<=jishu; 
		end if; 	
	end process; 
	
	process(replay,jiepai,clr) --replay what you input
	begin 	
		if replay = '1' then 	
			if clr='1' then xiabiao<=0; --xiabiao ��Ϊ¼���ز��ļ�����	
			elsif jiepai' event and jiepai='1' then 
				index_store<=shuzu1(xiabiao); 
				if xiabiao=changdu then xiabiao<=0; 
				else xiabiao<=xiabiao+1; 
				end if; 	
			end if; 	
		end if; 
	end process; 
	
end behave; 
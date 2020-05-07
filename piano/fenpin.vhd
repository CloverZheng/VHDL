library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_arith.all; 
use ieee.std_logic_unsigned.all; 

entity fenpin is 
port(clk:in std_logic; --50MHz 时钟
     tone:in integer range 0 to 100000; --输入分频系数
     buzz:out std_logic); --驱动扬声器发声
end; 

architecture behave of fenpin is 
    signal clk_data: std_logic; 
    signal i: integer range 0 to 65540; 
begin 
yinpin:process(clk) --根据输入的分频系数分频
    begin 
        if clk'event and clk = '1' then 
            if i = tone then
                i <= 0; 
                clk_data <= not clk_data; 
            else 
                i <= i+1; 
            end if; 
        end if; 
    end process yinpin;--f=1/(2*(tone+1))*f0 
buzz <= clk_data; 
end;
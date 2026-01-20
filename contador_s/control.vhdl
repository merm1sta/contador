library ieee;
use ieee.std_logic_1164.all;

entity control is
    port(
        q : in std_logic_vector(2 downto 0);    -- entrada do contador
        j, k : out std_logic_vector(2 downto 0)  -- saídas J e K para os flip-flops
    );
end control;

architecture ctrl of control is
begin
    -- com base na extração da tabela de transições do contador síncrono de 3 bits (DVK de Ji e Ki)
    -- lógica para o bit menos significativo (q(0))
    j(0) <= '1';  
    k(0) <= '1';  

    -- lógica para o bit do meio (q(1))
    j(1) <= q(0);  
    k(1) <= q(0);  

    -- lógica para o bit mais significativo (q(2))
    j(2) <= q(1) and q(0);  
    k(2) <= q(1) and q(0);  
end architecture ctrl;
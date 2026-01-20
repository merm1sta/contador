library ieee;
use ieee.std_logic_1164.all;

entity tb_contador is
 -- entidade vazia
end tb_contador;

architecture test of tb_contador is
    constant CLK_PERIOD : time := 20 ns;

    component contador is
        port(
            clock : in std_logic;
            reset : in std_logic;
            pr : in std_logic;
            q : out std_logic_vector(2 downto 0)
        );
    end component;

    signal sclk : std_logic := '0';
    signal sreset, spr : std_logic;
    signal sq : std_logic_vector(2 downto 0);

begin
    -- instanciando o contador
    u_contador : contador port map(sclk, sreset, spr, sq);

    tbp : process
    begin
        -- desativação do preset
        spr <= '1';
        sreset <= '0';
        wait for CLK_PERIOD;

        -- 8 vezes o CLK_PERIOD pra contar de 0 a 7 (8 valores)
        sreset <= '1';
        wait for 8 * CLK_PERIOD;

        sreset <= '0';
        wait for CLK_PERIOD;

        sreset <= '1';
        wait for 2 * CLK_PERIOD;
        wait;
    end process tbp;

    clock : process
    begin
        sclk <= not (sclk);
        wait for CLK_PERIOD/2;
    end process clock;

end architecture;
library ieee;
use ieee.std_logic_1164.all;

-- com base no módulo do contador síncrono de 3 bits (especificado no problema)
entity contador is
    port(
        clock : in std_logic;
        reset : in std_logic;
        pr : in std_logic; 
        q : out std_logic_vector(2 downto 0) -- 3 bits para contar de 0 a 7
    );
end contador;

architecture counting of contador is
    --usando os flip-flops JK como componentes do contador
    component ffjk is
        port(
            j, k : in std_logic;
            clock : in std_logic;
            pr, cl : in std_logic;
            q, nq : out std_logic
        );
    end component ffjk;

    -- contralador de entradas e saídas JK
    component control is
        port(
            q : in std_logic_vector(2 downto 0);    -- saída do flip-flop é a entrada do controlador
            j, k : out std_logic_vector(2 downto 0)        -- entradas J e K é a saída do controlador
        );
    end component control;

    signal sq, snq : std_logic_vector(2 downto 0); -- sinais internos para as saídas dos flip-flops
    signal sj, sk : std_logic_vector(2 downto 0);   -- sinais internos para as entradas J e K

begin
    -- instanciando o controlador
    u_control: control port map(sq, sj, sk);

    -- instanciando os FFJK's
    -- reset substitui o clear (cl) dos FFJK's, pois na descrição do problema o reset leva à "000"
    u_ffjk0 : ffjk port map(sj(0), sk(0), clock, pr, reset, sq(0), snq(0));
    u_ffjk1 : ffjk port map(sj(1), sk(1), clock, pr, reset, sq(1), snq(1));
    u_ffjk2 : ffjk port map(sj(2), sk(2), clock, pr, reset, sq(2), snq(2));

    q <= sq;
end architecture;


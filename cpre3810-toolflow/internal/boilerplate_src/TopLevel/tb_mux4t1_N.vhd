library ieee;
use ieee.std_logic_1164.all;

entity tb_mux4t1_N is
end tb_mux4t1_N;

architecture Behavioral of tb_mux4t1_N is

  -- Parameters
  constant N : integer := 32;

  -- Signals to connect to the mux
  signal sel  : std_logic_vector(1 downto 0);
  signal D0   : std_logic_vector(N-1 downto 0);
  signal D1   : std_logic_vector(N-1 downto 0);
  signal D2   : std_logic_vector(N-1 downto 0);
  signal D3   : std_logic_vector(N-1 downto 0);
  signal O    : std_logic_vector(N-1 downto 0);

begin

  -- Instantiate the mux
  DUT: entity work.mux4t1_N
    generic map (N => N)
    port map (
      i_sel => sel,
      i_D0  => D0,
      i_D1  => D1,
      i_D2  => D2,
      i_D3  => D3,
      o_O   => O
    );

  -- Stimulus process
  TEST: process
  begin
    -- Initialize inputs
    D0 <= (others => '0'); D0(0) <= '1';  -- 0x01
    D1 <= (others => '0'); D1(1) <= '1';  -- 0x02
    D2 <= (others => '0'); D2(2) <= '1';  -- 0x04
    D3 <= (others => '0'); D3(3) <= '1';  -- 0x08

    sel <= "00"; wait for 10 ns;  -- Select D0
    sel <= "01"; wait for 10 ns;  -- Select D1
    sel <= "10"; wait for 10 ns;  -- Select D2
    sel <= "11"; wait for 10 ns;  -- Select D3
    sel <= "00"; wait for 10 ns;  -- Back to D0

    -- End simulation
    wait;
  end process;

end Behavioral;


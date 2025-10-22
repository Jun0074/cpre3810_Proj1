library IEEE;
use IEEE.std_logic_1164.all;

entity ones_complementor_N is
  generic(N : integer := 8);
  port(i_X : in std_logic_vector(N-1 downto 0);
       o_Y : out std_logic_vector(N-1 downto 0));
end ones_complementor_N;

architecture structural of ones_complementor_N is
  component invg
    port(i_A : in std_logic;
         o_F : out std_logic);
  end component;

begin
  GenInvs: for i in 0 to N-1 generate
    INVX: invg
      port map(
        i_A => i_X(i),
        o_F => o_Y(i)
      );
  end generate GenInvs;
end structural;
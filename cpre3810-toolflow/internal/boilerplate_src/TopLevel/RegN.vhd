library IEEE;
use IEEE.std_logic_1164.all;

entity RegN is
generic(N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);
       o_Q          : out std_logic_vector(N-1 downto 0));

end RegN;

architecture structural of RegN is
component dffg is

  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic;     -- Data value input
       o_Q          : out std_logic);   -- Data value output

end component;

begin
Ndffg_Reg: for i in 0 to N-1 generate
   dffg_N: dffg 
	port map(
              i_CLK      => i_CLK,  
               i_RST     =>  i_RST, 
 		i_WE    =>   i_WE,
              i_D     => i_D(i),  
              o_Q      => o_Q(i)); 
  end generate Ndffg_Reg;
  
end structural;
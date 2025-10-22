library IEEE;
use IEEE.std_logic_1164.all;

entity ripple_adder_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_X          : in std_logic_vector(N-1 downto 0);
       i_Y         : in std_logic_vector(N-1 downto 0);
       i_C         : in std_logic;
       o_S          : out std_logic_vector(N-1 downto 0);
       o_C	   : out std_logic);

end ripple_adder_N;

architecture structural of ripple_adder_N is

  component full_adder is
  port(i_X          : in std_logic;
       i_Y         : in std_logic;
       i_C         : in std_logic;
       o_S          : out std_logic;
       o_C	   : out std_logic);
  end component;

  signal carry : std_logic_vector(N downto 0);

begin

  -- Initialize the first carry
  carry(0) <= i_C;

  -- Instantiate N mux instances.
  G_NBit_full_adder: for i in 0 to N-1 generate
    ADDERI: full_adder port map(
              i_X      => i_X(i),      
              i_Y     => i_Y(i),  
              i_C     => carry(i),  
              o_S      => o_S(i),
	      o_C => carry(i+1));
  end generate G_NBit_full_adder;

  -- Assign the last carry for the output of the ripple adder
  o_C <= carry(N);
  
end structural;
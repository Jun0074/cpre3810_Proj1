library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder_subtractor_N is
  generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
  port(i_A          : in std_logic_vector(N-1 downto 0);
       i_B         : in std_logic_vector(N-1 downto 0);
       o_S          : out std_logic_vector(N-1 downto 0);
       o_C	   : out std_logic;
       n_Add_Sub	: in std_logic);

end adder_subtractor_N;

architecture structure of adder_subtractor_N is


   -- N bit Invert Gate
   component ones_complementor_N is
       generic (N : integer := 8);
       port (i_X : in  std_logic_vector(N-1 downto 0);
             o_Y : out std_logic_vector(N-1 downto 0));

   end component;

   -- 2 : 1 Mux
   component mux2t1_N is
	generic (N : integer := 8);
        port(i_S          : in std_logic;
             i_D0         : in std_logic_vector(N-1 downto 0);
             i_D1         : in std_logic_vector(N-1 downto 0);
             o_O          : out std_logic_vector(N-1 downto 0));

   end component;

   -- Ripple Adder
   component ripple_adder_N is
	generic(N : integer := 16); -- Generic of type integer for input/output data width. Default value is 32.
        port(i_X          : in std_logic_vector(N-1 downto 0);
             i_Y         : in std_logic_vector(N-1 downto 0);
             i_C         : in std_logic;
             o_S          : out std_logic_vector(N-1 downto 0);
             o_C	   : out std_logic);

   end component;

   -- Output of Mux (Either inverted or non inverted A
   signal s_mux_output : std_logic_vector(N-1 downto 0);
   signal s_invert_B : std_logic_vector(N-1 downto 0);

begin

-- Invert B
Inverter: ones_complementor_N
   generic map (N => N)
   port map (i_X => i_B,
        o_Y => s_invert_B);

-- Based on if we are adding or subtracting, select the correct B
mux: mux2t1_N
   generic map (N => N)
   port MAP(i_S => n_Add_Sub,
        i_D0 => i_B,
	i_D1 => s_invert_B,
	o_O => s_mux_output);

-- Put inputs into adder
Adder: ripple_adder_N
   generic map (N => N)
   port map (i_X => i_A,
        i_Y => s_mux_output,
	i_C => n_Add_Sub,
	o_S => o_S,
	o_C => o_C);

end structure;
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux2t1 is
  port(i_S          : in std_logic;
       i_D0         : in std_logic;
       i_D1         : in std_logic;
       o_O          : out std_logic);

end mux2t1;

architecture structure of mux2t1 is
   
   -- Invert Gate
   component invg is
	port(i_A          : in std_logic;
       	     o_F          : out std_logic);

   end component;

   -- 2 Input And Gate
   component andg2 is
	port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);

   end component;

   -- 2 Input OR Gate
   component org2 is
	port(i_A          : in std_logic;
             i_B          : in std_logic;
             o_F          : out std_logic);

   end component;

   -- Signal Carrying output of And Gate of I_S and I_D0
   signal s_D0_S : std_logic;
   
   -- Signal Carrying output of And Gate of I_S' and I_D1
   signal s_D1_S : std_logic;

   -- Signal Carrying output of Invert gat of I_S
   signal s_invert_S : std_logic;

begin


-- Start Applying Invert Gate
g_invg1: invg
    port MAP(i_A => i_S,
             o_F => s_invert_S);

-- Apply And Gates
g_andD0: andg2
   port MAP(i_A => i_D0,
        i_B => s_invert_S,
        o_F => s_D0_S);

g_andD1: andg2
   port MAP(i_A => i_D1,
        i_B => i_S,
        o_F => s_D1_S);

-- Apply the OR Gate
g_or: org2
   port MAP(i_A => s_D0_S,
        i_B => s_D1_S,
        o_F => o_O);

end structure;
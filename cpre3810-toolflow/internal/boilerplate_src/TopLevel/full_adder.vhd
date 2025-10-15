library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity full_adder is
  port(i_X          : in std_logic;
       i_Y         : in std_logic;
       i_C         : in std_logic;
       o_S          : out std_logic;
       o_C	   : out std_logic);

end full_adder;

architecture structure of full_adder is
   
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

   --- Inverted Signals
   signal s_nX : std_logic;
   signal s_nY : std_logic;
   signal s_nC : std_logic;

   -- Signals used for Sum Calculation

   -- X'YC'
   signal s_nX_Y : std_logic;
   signal s_nX_Y_nC : std_logic;
   
   -- X'Y'C
   signal s_nX_nY : std_logic;
   signal s_nX_nY_C : std_logic;

   -- XYC (Used for both)
   signal s_X_Y : std_logic;
   signal s_X_Y_C : std_logic;
   
   -- XY'C'
   signal s_X_nY : std_logic;
   signal s_X_nY_nC : std_logic;

   -- First Or Signals (Sum)
   signal s_nX_Y_nC_OR_nX_nY_C : std_logic;
   signal s_X_Y_C_OR_X_nY_nC : std_logic;

   -- Signals Used for Carry Calculation

   -- Signal i_X & i_Y are defined before
   signal s_X_C : std_logic;
   signal s_Y_C : std_logic;

   -- First Or Signals (Carry)
   signal s_X_Y_OR_X_C : std_logic;

begin



-- 1. Start Applying Invert Gates
g_invg1: invg
    port MAP(i_A => i_X,
             o_F => s_nX);

g_invg2: invg
    port MAP(i_A => i_Y,
             o_F => s_nY);

g_invg3: invg
    port MAP(i_A => i_C,
             o_F => s_nC);



-- 2. Apply first round of and gates

-- Sum Calculation

-- X'Y
g_and1: andg2
   port MAP(i_A => s_nX,
        i_B => i_Y,
        o_F => s_nX_Y);

-- X'Y'
g_and2: andg2
   port MAP(i_A => s_nX,
        i_B => s_nY,
        o_F => s_nX_nY);

-- XY (Used for both)
g_and3: andg2
   port MAP(i_A => i_X,
        i_B => i_Y,
        o_F => s_X_Y);

-- XY'
g_and4: andg2
   port MAP(i_A => i_X,
        i_B => s_nY,
        o_F => s_X_nY);

-- Carry Calculation

-- XC
g_and5: andg2
   port MAP(i_A => i_X,
        i_B => i_C,
        o_F => s_X_C);

-- YC
g_and6: andg2
   port MAP(i_A => i_Y,
        i_B => i_C,
        o_F => s_Y_C);


-- 3. Do Second Round of And Gates

-- X'YC'
g_and7: andg2
   port MAP(i_A => s_nX_Y,
        i_B => s_nC,
        o_F => s_nX_Y_nC);

-- X'Y'C
g_and8: andg2
   port MAP(i_A => s_nX_nY,
        i_B => i_C,
        o_F => s_nX_nY_C);

-- XYC
g_and9: andg2
   port MAP(i_A => s_X_Y,
        i_B => i_C,
        o_F => s_X_Y_C);

-- XY'C'
g_and10: andg2
   port MAP(i_A => s_X_nY,
        i_B => s_nC,
        o_F => s_X_nY_nC);

-- 4. Do First round of Or Gates

-- Sum Calculation

g_or1: org2
   port MAP(i_A => s_nX_Y_nC,
        i_B => s_nX_nY_C,
        o_F => s_nX_Y_nC_OR_nX_nY_C);

g_or2: org2
   port MAP(i_A => s_X_Y_C,
        i_B => s_X_nY_nC,
        o_F => s_X_Y_C_OR_X_nY_nC);

-- Carry Calculation

g_or3: org2
   port MAP(i_A => s_X_Y,
        i_B => s_X_C,
        o_F => s_X_Y_OR_X_C);

-- 5. Calculate Outputs

-- Sum Output
g_or4: org2
   port MAP(i_A => s_nX_Y_nC_OR_nX_nY_C,
        i_B => s_X_Y_C_OR_X_nY_nC,
        o_F => o_S);

-- Carry Output
g_or5: org2
   port MAP(i_A => s_X_Y_OR_X_C,
        i_B => s_Y_C,
        o_F => o_C);

end structure;
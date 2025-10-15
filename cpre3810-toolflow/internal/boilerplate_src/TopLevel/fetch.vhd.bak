library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fetch is
  generic(N : integer := 32);
  port(
    i_clk : in std_logic;
    i_rst : in std_logic; -- Active-high reset
    i_PCsrc : in std_logic;
    i_imm : in std_logic_vector(N-1 downto 0); -- Immediate Input
    o_PC  : out std_logic_vector(N-1 downto 0)
  );
end fetch;

architecture structure of fetch is

  -- Internal PC register
  signal s_PC_current   : std_logic_vector(N-1 downto 0) := (others => '0'); -- Current PC Counter
  signal s_PC_next      : std_logic_vector(N-1 downto 0);  -- Next PC Counter
  signal s_PC_plus_4	: std_logic_vector(N-1 downto 0);  -- PC + 4
  signal s_carry_plus_4 : std_logic; -- Carry of PC + 4
  signal s_PC_plus_imm  : std_logic_vector(N-1 downto 0);  -- PC + Imm
  signal s_carry_plus_imm : std_logic; -- Carry of PC + Imm

  -- ALU
  component adder_subtractor_n
    generic(N : integer := 32);
    port(
      i_A       : in std_logic_vector(N-1 downto 0);
      i_B       : in std_logic_vector(N-1 downto 0);
      o_S       : out std_logic_vector(N-1 downto 0);
      o_C       : out std_logic;
      n_Add_Sub : in std_logic
    );
  end component;

  -- MUX 2:1 N bit
  component mux2t1_N
    generic(N : integer := 32);
    port(i_S          : in std_logic;
         i_D0         : in std_logic_vector(N-1 downto 0);
         i_D1         : in std_logic_vector(N-1 downto 0);
         o_O          : out std_logic_vector(N-1 downto 0));

  end component;

begin

  -- PC + 4
  ADD4: adder_subtractor_n
    generic map(N => N)
    port map(
      i_A       => s_PC_current,	-- Current PC
      i_B       => std_logic_vector(to_unsigned(4, N)), -- + 4
      o_S       => s_PC_plus_4,		-- s_PC_plus_4 = s_PC_current + 4
      o_C       => s_carry_plus_4,
      n_Add_Sub => '0'	-- Set to Add mode
    );

  ADD_IMM: adder_subtractor_n
    generic map(N => N)
    port map(
      i_A       => s_PC_current,	-- Current PC
      i_B       => i_imm,		-- Immediate input
      o_S       => s_PC_plus_imm,	-- s_PC_plus_imm = s_PC_current + i_imm
      o_C       => s_carry_plus_imm,
      n_Add_Sub => '0'	-- Set to Add mode
    );

  -- Select either PC + 4 (0) or PC + Imm (1)
  SEL_PC: mux2t1_N
    generic map(N => N)
    port map(
      i_S	=> i_PCsrc,
      i_D0      => s_PC_plus_4,
      i_D1      => s_PC_plus_imm,
      o_O       => s_PC_next
    );

  -- Sequential update (register)
  process(i_clk, i_rst)
  begin
    if (i_rst = '1') then
      s_PC_current <= (others => '0');
    elsif rising_edge(i_clk) then
      s_PC_current <= s_PC_next;
    end if;
  end process;

  -- Output
  o_PC <= s_PC_current;

end structure;


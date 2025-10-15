library ieee;
use ieee.std_logic_1164.all;

entity RegFile is
  port (
    i_CLK : in  std_logic;
    i_RST : in  std_logic;
    i_WE  : in  std_logic;                          -- global write enable
    i_RD  : in  std_logic_vector(4 downto 0);       -- dest reg addr
    i_WD  : in  std_logic_vector(31 downto 0);      -- write data
    i_RS1 : in  std_logic_vector(4 downto 0);
    i_RS2 : in  std_logic_vector(4 downto 0);
    o_RS1 : out std_logic_vector(31 downto 0);
    o_RS2 : out std_logic_vector(31 downto 0)
  );
end entity RegFile;

architecture structural of RegFile is
-- register
  component RegN
    generic ( N : integer := 32 );
    port (
      i_CLK : in  std_logic;
      i_RST : in  std_logic;
      i_WE  : in  std_logic;
      i_D   : in  std_logic_vector(N-1 downto 0);
      o_Q   : out std_logic_vector(N-1 downto 0)
    );
  end component;
-- select register
  component decoder5to32
    port (
      i_D : in  std_logic_vector(4 downto 0);       
      o_Q : out std_logic_vector(31 downto 0)     
    );
  end component;
-- select output
  component mux32to1_32bit
    port (
      sel : in  std_logic_vector(4 downto 0);
      i_D : in  std_logic_vector(1023 downto 0);
      o_Q : out std_logic_vector(31 downto 0)
    );
  end component;

type reg_bank_t is array (31 downto 0) of std_logic_vector(31 downto 0);

  signal s_dec  : std_logic_vector(31 downto 0);     -- one-hot from decoder
  signal s_we   : std_logic_vector(31 downto 0);     -- per-register WE (renamed)
  signal s_q    : reg_bank_t;                        -- each register's Q
  signal s_flat : std_logic_vector(1023 downto 0);   -- concat Qs to muxes

begin
  -- decoder: write-destination selection
  dec: decoder5to32
    port map (
      i_D => i_RD,     -- 5-bit address in
      o_Q => s_dec     -- one-hot out
    );

  -- gate with global i_WE to form W for each register
  s_we <= s_dec and (31 downto 0 => i_WE);

  -- x0 = constant zero
  s_q(0) <= (others => '0');

  -- x1..x31 storage
  gen_regs: for i in 1 to 31 generate
    u_reg: RegN
      generic map (N => 32)
      port map (
        i_CLK => i_CLK,
        i_RST => i_RST,
        i_WE  => s_we(i),
        i_D   => i_WD,
        o_Q   => s_q(i)
      );
  end generate;

-- Converts the array of 32 buses (s_q) into one giant 1024-bit vector (s_flat). Each register?s 32-bit Q output occupies a slice of s_flat.
  gen_flat: for i in 0 to 31 generate
    s_flat((i*32)+31 downto i*32) <= s_q(i);
  end generate;

  -- dual read ports
  mux1: mux32to1_32bit
    port map ( sel => i_RS1, i_D => s_flat, o_Q => o_RS1 );

  mux2: mux32to1_32bit
    port map ( sel => i_RS2, i_D => s_flat, o_Q => o_RS2 );
end architecture;

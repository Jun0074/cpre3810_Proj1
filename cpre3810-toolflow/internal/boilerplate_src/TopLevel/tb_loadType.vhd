library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_loadType is
end entity;

architecture sim of tb_loadType is
  -- DUT ports
  signal s_word     : std_logic_vector(31 downto 0);
  signal s_addr_low : std_logic_vector(1 downto 0);
  signal s_ltype    : std_logic_vector(2 downto 0);
  signal s_data     : std_logic_vector(31 downto 0);

  -- LType encodings
  constant LT_LW  : std_logic_vector(2 downto 0) := "000";
  constant LT_LH  : std_logic_vector(2 downto 0) := "001";
  constant LT_LB  : std_logic_vector(2 downto 0) := "010";
  constant LT_LBU : std_logic_vector(2 downto 0) := "011";
  constant LT_LHU : std_logic_vector(2 downto 0) := "100";
begin
  -- DUT
  u_dut: entity work.loadType(rtl)
    port map(
      i_word     => s_word,
      i_addr_low => s_addr_low,
      i_LType    => s_ltype,
      o_data     => s_data
    );

  -- Start test
  stimulus: process
  begin
    -- Default
    s_word <= (others => '0');
    s_addr_low <= "00";
    s_ltype <= LT_LW;
    wait for 10 ns;

    ----------------------------------------------------------------
    -- 1. LW (full word, addr_low ignored for this module)
    ----------------------------------------------------------------
    s_word <= x"DEADBEEF"; s_ltype <= LT_LW; s_addr_low <= "00"; -- expect: DEADBEEF
    wait for 10 ns;
    s_word <= x"01234567"; s_ltype <= LT_LW; s_addr_low <= "11"; -- expect: 01234567
    wait for 10 ns;

    ----------------------------------------------------------------
    -- 2. LBU on 0x11223344 (little-endian byte select b0..b3)
    --    addr=00->0x44, 01->0x33, 10->0x22, 11->0x11
    ----------------------------------------------------------------
    s_word <= x"11223344"; s_ltype <= LT_LBU;
    s_addr_low <= "00";  -- expect: 00000044
    wait for 10 ns;
    s_addr_low <= "01";  -- expect: 00000033
    wait for 10 ns;
    s_addr_low <= "10";  -- expect: 00000022
    wait for 10 ns;
    s_addr_low <= "11";  -- expect: 00000011
    wait for 10 ns;

    ----------------------------------------------------------------
    -- 3. LB with sign extension
    --    word = 0x807F8081 => b3=80, b2=7F, b1=80, b0=81
    ----------------------------------------------------------------
    s_word <= x"807F8081"; s_ltype <= LT_LB;
    s_addr_low <= "00";  -- b0=0x81 -> FFFFFF81
    wait for 10 ns;
    s_addr_low <= "01";  -- b1=0x80 -> FFFFFF80
    wait for 10 ns;
    s_addr_low <= "10";  -- b2=0x7F -> 0000007F
    wait for 10 ns;
    s_addr_low <= "11";  -- b3=0x80 -> FFFFFF80
    wait for 10 ns;

    ----------------------------------------------------------------
    -- 4. LHU: low vs high half
    --    word = 0xA5B6C7D8 -> low = C7D8, high = A5B6
    ----------------------------------------------------------------
    s_word <= x"A5B6C7D8"; s_ltype <= LT_LHU;
    s_addr_low <= "00";  -- expect: 0000C7D8
    wait for 10 ns;
    s_addr_low <= "10";  -- expect: 0000A5B6
    wait for 10 ns;

    ----------------------------------------------------------------
    -- 5. LH: sign extension on halfwords
    --    word = 0x7FFF8001 -> low=8001 (neg), high=7FFF (pos)
    ----------------------------------------------------------------
    s_word <= x"7FFF8001"; s_ltype <= LT_LH;
    s_addr_low <= "00";  -- expect: FFFF8001
    wait for 10 ns;
    s_addr_low <= "10";  -- expect: 00007FFF
    wait for 10 ns;

    wait for 20 ns;
    wait;
  end process;
end architecture;

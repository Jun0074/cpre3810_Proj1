-- tb_alu.vhd
-- Testbench for ALU
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end entity;

architecture sim of tb_alu is
  -- DUT ports
  signal i_A      : std_logic_vector(31 downto 0) := (others => '0');
  signal i_B      : std_logic_vector(31 downto 0) := (others => '0');
  signal i_ALUOp  : std_logic_vector(3 downto 0)  := (others => '0');
  signal o_Y      : std_logic_vector(31 downto 0);
  signal o_Zero   : std_logic;
  signal o_LT     : std_logic;
  signal o_LTU    : std_logic;
  signal o_Ovfl   : std_logic;

  constant T : time := 20 ns;

  -- ALUOp encodings (match your ALU.vhd)
  constant ALU_AND  : std_logic_vector(3 downto 0) := "0000";
  constant ALU_OR   : std_logic_vector(3 downto 0) := "0001";
  constant ALU_ADD  : std_logic_vector(3 downto 0) := "0010";
  constant ALU_SUB  : std_logic_vector(3 downto 0) := "0011";
  constant ALU_XOR  : std_logic_vector(3 downto 0) := "0100";
  constant ALU_SLT  : std_logic_vector(3 downto 0) := "0111";
  constant ALU_SLTU : std_logic_vector(3 downto 0) := "1000";
  constant ALU_SLL  : std_logic_vector(3 downto 0) := "1001";
  constant ALU_SRL  : std_logic_vector(3 downto 0) := "1010";
  constant ALU_SRA  : std_logic_vector(3 downto 0) := "1011";

begin
  -- Device Under Test (DUT)
  DUT: entity work.ALU
    port map(
      i_A     => i_A,
      i_B     => i_B,
      i_ALUOp => i_ALUOp,
      o_Y     => o_Y,
      o_Zero  => o_Zero,
      o_LT    => o_LT,
      o_LTU   => o_LTU,
      o_Ovfl  => o_Ovfl
    );

  -- Stimulus process
  process
  begin
    -- AND operation
    i_A <= x"F0F0F0F0"; i_B <= x"0F0F0F0F"; i_ALUOp <= ALU_AND;  -- expected Y=00000000, Zero=1
    wait for T;

    -- OR operation
    i_ALUOp <= ALU_OR;                                          -- expected Y=FFFFFFFF, Zero=0
    wait for T;

    -- XOR operation
    i_ALUOp <= ALU_XOR;                                         -- expected Y=FFFFFFFF
    wait for T;

    -- ADD operation (normal case)
    i_A <= x"00000001"; i_B <= x"00000002"; i_ALUOp <= ALU_ADD; -- expected Y=00000003, Ovfl=0
    wait for T;

    -- ADD overflow: 7FFFFFFF + 1 = 80000000 (Overflow = 1)
    i_A <= x"7FFFFFFF"; i_B <= x"00000001"; i_ALUOp <= ALU_ADD; -- expected Y=80000000, Ovfl=1
    wait for T;

    -- SUB operation (equal: 12345678 - 12345678 = 0)
    i_A <= x"12345678"; i_B <= x"12345678"; i_ALUOp <= ALU_SUB; -- expected Y=00000000, Zero=1
    wait for T;

    -- SUB overflow: 80000000 - 1 = 7FFFFFFF (Overflow = 1)
    i_A <= x"80000000"; i_B <= x"00000001"; i_ALUOp <= ALU_SUB; -- expected Y=7FFFFFFF, Ovfl=1
    wait for T;

    -- SLT signed: 80000000 < 00000001 (signed) => expected Y=00000001
    i_A <= x"80000000"; i_B <= x"00000001"; i_ALUOp <= ALU_SLT; -- expected Y=00000001
    wait for T;

    -- SLTU unsigned: 80000000 > 00000001 (unsigned) => expected Y=00000000
    i_ALUOp <= ALU_SLTU;                                        -- expected Y=00000000
    wait for T;

    -- SLL: 00000001 << 31 = 80000000
    i_A <= x"00000001"; i_B <= x"0000001F"; i_ALUOp <= ALU_SLL; -- expected Y=80000000
    wait for T;

    -- SRL: 80000000 >> 31 (logical) = 00000001
    i_A <= x"80000000"; i_B <= x"0000001F"; i_ALUOp <= ALU_SRL; -- expected Y=00000001
    wait for T;

    -- SRA: 80000000 >>> 31 (arith) = FFFFFFFF
    i_ALUOp <= ALU_SRA;                                         -- expected Y=FFFFFFFF
    wait for T;

    -- Done
    wait;
  end process;
end architecture;


-- ALU.vhd
-- Consumes ALUOp(3:0) directly from control_unit bits[17:14].
-- Supports: AND, OR, XOR, ADD, SUB, SLT, SLTU, SLL, SRL, SRA
-- Provides branch compare flags for: beq/bne (Zero), blt/bge (LT), bltu/bgeu (LTU)
-- Structural 32-bit BarrelShifter inside ALU below
--------------------------------------------------------------------------------------
library ieee;                           
use ieee.std_logic_1164.all;               
use ieee.numeric_std.all;    
               
entity ALU is
  port(
    i_A       : in  std_logic_vector(31 downto 0); -- operand A (rs1 or PC)
    i_B       : in  std_logic_vector(31 downto 0); -- operand B (rs2 or Imm)
    i_ALUOp   : in  std_logic_vector(3 downto 0);  -- 4-bit op from control
    o_Y       : out std_logic_vector(31 downto 0); -- result
    o_Zero    : out std_logic;                     -- result == 0
    o_LT      : out std_logic;                     -- A < B (signed)
    o_LTU     : out std_logic;                     -- A < B (unsigned)
    o_Ovfl    : out std_logic                      -- overflow (ADD/SUB)
  );
end entity;

architecture rtl of ALU is

--ALUOp encodings (match control spreadsheet)
  constant ALU_AND  : std_logic_vector(3 downto 0) := "0000"; -- and/andi
  constant ALU_OR   : std_logic_vector(3 downto 0) := "0001"; -- or/ori
  constant ALU_ADD  : std_logic_vector(3 downto 0) := "0010"; -- add/addi/lw/sw/auipc/jal/jalr addr
  constant ALU_SUB  : std_logic_vector(3 downto 0) := "0011"; -- sub + beq/bne compare
  constant ALU_XOR  : std_logic_vector(3 downto 0) := "0100"; -- xor/xori
  constant ALU_SLT  : std_logic_vector(3 downto 0) := "0111"; -- slt/slti  (signed)
  constant ALU_SLTU : std_logic_vector(3 downto 0) := "1000"; -- sltu/sltiu(unsigned)
  constant ALU_SLL  : std_logic_vector(3 downto 0) := "1001"; -- sll/slli
  constant ALU_SRL  : std_logic_vector(3 downto 0) := "1010"; -- srl/srli
  constant ALU_SRA  : std_logic_vector(3 downto 0) := "1011"; -- sra/srai

--typed views for math/flags 
  signal A_s, B_s : signed(31 downto 0);               -- signed view
  signal A_u, B_u : unsigned(31 downto 0);             -- unsigned view
  signal shamt    : std_logic_vector(4 downto 0);      -- shift amt = B[4:0]
  signal res      : std_logic_vector(31 downto 0);     -- result bus
  signal ov_add   : std_logic;           -- add overflow
  signal ov_sub   : std_logic;           -- sub overflow

  -- ---- barrel shifter I/O ----
  signal sh_right : std_logic;            -- 0=left, 1=right
  signal sh_arith : std_logic;            -- right: 1=arith
  signal sh_out   : std_logic_vector(31 downto 0);      -- shift result

  -- BarrelShifter Component
  component BarrelShifter32
    port(
      i_D     : in  std_logic_vector(31 downto 0); -- data to shift
      i_SA    : in  std_logic_vector(4 downto 0);  -- shift amount
      i_Right : in  std_logic;                     -- 0=left, 1=right
      i_Arith : in  std_logic;                     -- right: 1=arithmetic
      o_Y     : out std_logic_vector(31 downto 0)  -- shifted result
    );
  end component;


begin
  -- map input buses to numeric types
  A_s   <= signed(i_A);                                 -- signed A
  B_s   <= signed(i_B);                                 -- signed B
  A_u   <= unsigned(i_A);                               -- unsigned A
  B_u   <= unsigned(i_B);                               -- unsigned B
  shamt <= i_B(4 downto 0);                             -- shamt from B

  -- shifter mode from ALUOp
  sh_right <= '0' when i_ALUOp = ALU_SLL else '1';      -- left only for SLL
  sh_arith <= '1' when i_ALUOp = ALU_SRA else '0';      -- arith only for SRA

  -- structural barrel shifter (always shifts A by B[4:0])
  u_sh: BarrelShifter32
    port map(
      i_D     => i_A,                                   -- data in = A
      i_SA    => shamt,                                 -- amount = B[4:0]
      i_Right => sh_right,                              -- direction
      i_Arith => sh_arith,                              -- arithmetic?
      o_Y     => sh_out                                 -- shifted out
    );

  -- main combinational ALU
  process(i_A, i_B, i_ALUOp, A_s, B_s, A_u, B_u, sh_out)
    variable sum  : signed(31 downto 0);               -- A+B
    variable diff : signed(31 downto 0);               -- A-B
  begin
    sum  := A_s + B_s;                                 -- precompute add
    diff := A_s - B_s;                                 -- precompute sub

    case i_ALUOp is                         -- select op
      when ALU_AND   => res <= i_A and i_B;             -- AND
      when ALU_OR    => res <= i_A or  i_B;             -- OR
      when ALU_XOR   => res <= i_A xor i_B;             -- XOR
      when ALU_ADD   => res <= std_logic_vector(sum);   -- ADD
      when ALU_SUB   => res <= std_logic_vector(diff);  -- SUB
      when ALU_SLL   => res <= sh_out;                  -- SLL (A << B[4:0])
      when ALU_SRL   => res <= sh_out;                  -- SRL (A >> B[4:0])
      when ALU_SRA   => res <= sh_out;                  -- SRA (A >>> B[4:0])
      when ALU_SLT   =>                                  -- SLT (signed)
        if A_s < B_s then
          res <= (31 downto 1 => '0') & '1';           -- set to 1
        else
          res <= (others => '0');                      -- set to 0
        end if;
      when ALU_SLTU  =>                                  -- SLTU (unsigned)
        if A_u < B_u then
          res <= (31 downto 1 => '0') & '1';           -- set to 1
        else
          res <= (others => '0');                      -- set to 0
        end if;
      when others    => res <= (others => '0');          -- safe default
    end case;

    -- flags driven from selected result / operands
    o_Zero <= '1' when res = x"00000000" else '0';      -- Zero flag
    o_LT   <= '1' when A_s < B_s else '0';              -- signed-compare flag
    o_LTU  <= '1' when A_u < B_u else '0';              -- unsigned-compare flag

    -- overflow per 2's-comp rules (ADD/SUB)
    ov_add <= '1' when (i_ALUOp = ALU_ADD) and
                      ((A_s(31) = B_s(31)) and (sum(31)  /= A_s(31))) else '0';
    ov_sub <= '1' when (i_ALUOp = ALU_SUB) and
                      ((A_s(31) /= B_s(31)) and (diff(31) /= A_s(31))) else '0';
  end process;

  -- connect result/overflow to outputs
  o_Y    <= res;                -- result out
  o_Ovfl <= ov_add or ov_sub;   -- overflow out

end architecture;

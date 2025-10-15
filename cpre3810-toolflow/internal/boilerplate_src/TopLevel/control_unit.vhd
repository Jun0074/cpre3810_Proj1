library IEEE;
use IEEE.std_logic_1164.all;

-- ============================================================
-- entity
entity control_unit is
port(
i_opcode  : in  std_logic_vector(6 downto 0); -- opcode[6:0]
i_funct3  : in  std_logic_vector(2 downto 0); -- funct3[2:0]
i_funct7  : in  std_logic_vector(6 downto 0); -- funct7[6:0]
o_Ctrl_Unt: out std_logic_vector(19 downto 0) -- packed control (see format banner)
);
end control_unit;

-- ============================================================
-- architecture
architecture dataflow of control_unit is

signal s_RTYPE     : std_logic_vector(19 downto 0);
signal s_OPIMM     : std_logic_vector(19 downto 0);
signal s_SHIFT_001 : std_logic_vector(19 downto 0);
signal s_SHIFT_101 : std_logic_vector(19 downto 0);
signal s_LOAD      : std_logic_vector(19 downto 0);
signal s_STORE     : std_logic_vector(19 downto 0);
signal s_BRANCH    : std_logic_vector(19 downto 0);
signal s_JAL       : std_logic_vector(19 downto 0);
signal s_JALR      : std_logic_vector(19 downto 0);
signal s_LUI       : std_logic_vector(19 downto 0);
signal s_AUIPC     : std_logic_vector(19 downto 0);
signal s_HALT      : std_logic_vector(19 downto 0);
signal s_NOP       : std_logic_vector(19 downto 0);
signal s_fun10     : std_logic_vector(9 downto 0);

-- ========= Opcodes =========
constant OPC_RTYPE  : std_logic_vector(6 downto 0) := "0110011";
constant OPC_ITYPE  : std_logic_vector(6 downto 0) := "0010011";
constant OPC_LOAD   : std_logic_vector(6 downto 0) := "0000011";
constant OPC_STORE  : std_logic_vector(6 downto 0) := "0100011";
constant OPC_BRANCH : std_logic_vector(6 downto 0) := "1100011";
constant OPC_JAL    : std_logic_vector(6 downto 0) := "1101111";
constant OPC_JALR   : std_logic_vector(6 downto 0) := "1100111";
constant OPC_LUI    : std_logic_vector(6 downto 0) := "0110111";
constant OPC_AUIPC  : std_logic_vector(6 downto 0) := "0010111";
constant OPC_SYSTEM : std_logic_vector(6 downto 0) := "1110011"; -- use as HALT/WFI

-- ========= Bit-field format banner (MSB..LSB) =========
-- [19]    [18]     [17:14]     [13:11]     [10:9]   [8]   [7]   [6]  [5]  [4]   [3:1]     [0]
-- ALUSrc  ALUSrcA  ALUOp(4)    ImmType(3)  Result   MWr   RWr  MRd  Jump Brch loadType(3) halt
-- Encodings:
--   ImmType  : 000=I, 001=S, 010=B, 011=U, 100=J
--   ResultSrc: 00=ALU, 01=MEM, 10=PC+4, 11=ImmU(LUI)
--   loadType : 000=lw, 001=lh, 010=lb, 011=lbu, 100=lhu
-- NOTE: '-' denotes don't-care for synthesis.
-----------------------------------------------------------------

begin

s_fun10 <= i_funct7 & i_funct3;

-- ============================================================
-- R-TYPE
-- ============================================================
with s_fun10 select s_RTYPE <=
"000010---0001000---0" when "0000000000", -- add
"000011---0001000---0" when "0100000000", -- sub
"000000---0001000---0" when "0000000111", -- and
"000001---0001000---0" when "0000000110", -- or
"000100---0001000---0" when "0000000100", -- xor
"000111---0001000---0" when "0000000010", -- slt
"001000---0001000---0" when "0000000011", -- sltu
"001001---0001000---0" when "0000000001", -- sll
"001010---0001000---0" when "0000000101", -- srl
"001011---0001000---0" when "0100000101", -- sra
"----------0000000000" when others;


-- ============================================================
-- I-TYPE ALU (OP-IMM)
-- ============================================================
with i_funct7 select s_SHIFT_001 <=
"1010010000001000---0" when "0000000", -- slli
"----------0000000000" when others;


with i_funct7 select s_SHIFT_101 <=
"1010100000001000---0" when "0000000", -- srli
"1010110000001000---0" when "0100000", -- srai
"----------0000000000" when others;


with i_funct3 select s_OPIMM <=
"1000100000001000---0" when "000", -- addi
s_SHIFT_001           when "001", -- slli
"1001110000001000---0" when "010", -- slti
"1010000000001000---0" when "011", -- sltiu
"1001000000001000---0" when "100", -- xori
s_SHIFT_101           when "101", -- srli/srai
"1000010000001000---0" when "110", -- ori
"1000000000001000---0" when "111", -- andi
"----------0000000000" when others;


-- ============================================================
-- LOADS
-- ============================================================
with i_funct3 select s_LOAD <=
"10001000001011000100" when "000", -- lb
"10001000001011000010" when "001", -- lh
"10001000001011000000" when "010", -- lw
"10001000001011000110" when "100", -- lbu
"10001000001011000100" when "101", -- lhu
"----------0000000000" when others;


-- ============================================================
-- STORE
-- ============================================================
--s_STORE <= "100010001--100000---0"; -- sw
s_STORE <= "100010001-100000---0";


-- ============================================================
-- BRANCHES
-- ============================================================
with i_funct3 select s_BRANCH <=
"000011010--00001---0" when "000", -- beq
"000011010--00001---0" when "001", -- bne
"000111010--00001---0" when "100", -- blt
"000111010--00001---0" when "101", -- bge
"001000010--00001---0" when "110", -- bltu
"001000010--00001---0" when "111", -- bgeu
"----------0000000000" when others;


-- ============================================================
-- JUMPS + U-TYPE
-- ============================================================
s_JAL   <= "-100101001001010---0"; -- jal
s_JALR  <= "1000100001001010---0"; -- jalr
s_LUI   <= "--" & "----" & "011" & "11" & "01000" & "---" & "0"; -- lui
s_AUIPC <= "1100100110001000---0"; -- auipc

-- ============================================================
-- HALT + NOP
-- ============================================================
s_HALT  <= "--" & "----" & "---" & "--" & "00000" & "---" & "1";
s_NOP   <= "--" & "----" & "---" & "--" & "00000" & "---" & "0";

-- ============================================================
-- TOP-LEVEL OPCODE SELECT
-- ============================================================
with i_opcode select o_Ctrl_Unt <=
s_RTYPE  when OPC_RTYPE,   -- R-type
s_OPIMM  when OPC_ITYPE,   -- I-type ALU
s_LOAD   when OPC_LOAD,    -- lb/lh/lw/lbu/lhu
s_STORE  when OPC_STORE,   -- sw
s_BRANCH when OPC_BRANCH,  -- beq/bne/blt/bge/bltu/bgeu
s_JAL    when OPC_JAL,     -- jal
s_JALR   when OPC_JALR,    -- jalr
s_LUI    when OPC_LUI,     -- lui
s_AUIPC  when OPC_AUIPC,   -- auipc
s_HALT   when OPC_SYSTEM,  -- halt
s_NOP    when others;

end dataflow;


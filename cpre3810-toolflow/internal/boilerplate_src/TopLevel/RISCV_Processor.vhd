-------------------------------------------------------------------------
-- Henry Duwe
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- RISCV_Processor.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains a skeleton of a RISCV_Processor  
-- implementation.

-- 01/29/2019 by H3::Design created.
-------------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.RISCV_types.all;

entity RISCV_Processor is
  generic(N : integer := DATA_WIDTH);
  port(iCLK            : in std_logic;
       iRST            : in std_logic;
       iInstLd         : in std_logic;
       iInstAddr       : in std_logic_vector(N-1 downto 0);
       iInstExt        : in std_logic_vector(N-1 downto 0);
       oALUOut         : out std_logic_vector(N-1 downto 0)); -- TODO: Hook this up to the output of the ALU. It is important for synthesis that you have this output that can effectively be impacted by all other components so they are not optimized away.

end  RISCV_Processor;


architecture structure of RISCV_Processor is
	
  -- Required data memory signals
  signal s_DMemWr       : std_logic; -- TODO: use this signal as the final active high data memory write enable signal
  signal s_DMemAddr     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory address input
  signal s_DMemData     : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input
  signal s_DMemOut      : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the data memory output
 
  -- Required register file signals 
  signal s_RegWr        : std_logic; -- TODO: use this signal as the final active high write enable input to the register file
  signal s_RegWrAddr    : std_logic_vector(4 downto 0); -- TODO: use this signal as the final destination register address input
  signal s_RegWrData    : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the final data memory data input

  -- Required instruction memory signals
  signal s_IMemAddr     : std_logic_vector(N-1 downto 0); -- Do not assign this signal, assign to s_NextInstAddr instead
  signal s_NextInstAddr : std_logic_vector(N-1 downto 0); -- TODO: use this signal as your intended final instruction memory address input.
  signal s_Inst         : std_logic_vector(N-1 downto 0); -- TODO: use this signal as the instruction signal 

  -- Required halt signal -- for simulation
  signal s_Halt         : std_logic;  -- TODO: this signal indicates to the simulation that intended program execution has completed. (Opcode: 01 0100)

  -- Required overflow signal -- for overflow exception detection
  signal s_Ovfl         : std_logic;  -- TODO: this signal indicates an overflow exception would have been initiated

  component mem is
    generic(ADDR_WIDTH : integer;
            DATA_WIDTH : integer);
    port(
          clk          : in std_logic;
          addr         : in std_logic_vector((ADDR_WIDTH-1) downto 0);
          data         : in std_logic_vector((DATA_WIDTH-1) downto 0);
          we           : in std_logic := '1';
          q            : out std_logic_vector((DATA_WIDTH -1) downto 0));
    end component;

-- TODO: You may add any additional signals or components your implementation 
--       requires below this comment

-- Register file read buses
signal s_RS1Data  : std_logic_vector(N-1 downto 0);
signal s_RS2Data  : std_logic_vector(N-1 downto 0);

-- ALU inputs/flags
signal s_ALUResult : std_logic_vector(N-1 downto 0);  -- ALU result (tie to oALUOut later)
signal s_ALU_A    : std_logic_vector(N-1 downto 0);
signal s_ALU_B    : std_logic_vector(N-1 downto 0);
signal s_Zero     : std_logic;
signal s_LT       : std_logic;
signal s_LTU      : std_logic;

-- PC select (branch/jump)
signal s_PCsrc    : std_logic;
signal s_NewPC    : std_logic_vector(N-1 downto 0);

-- Branch/jump glue
signal s_BrTaken    : std_logic;
signal s_BrTarget   : std_logic_vector(N-1 downto 0);  -- PC + immB
signal s_JumpTarget : std_logic_vector(N-1 downto 0);  -- JAL/JALR target
signal s_isJALR     : std_logic;                       -- opcode check
  
 -- signal of the control
    signal s_Ctrl        : std_logic_vector(19 downto 0);
    signal s_ALUSrc, s_ALUSrcA, s_MemWrite, s_RegWrite, s_MemRead, s_Jump, s_Branch : std_logic;
    signal s_ALUOp       : std_logic_vector(3 downto 0);
    signal s_ImmType     : std_logic_vector(2 downto 0);
    signal s_ResultSrc   : std_logic_vector(1 downto 0);
    signal s_loadType    : std_logic_vector(2 downto 0);

-- read-path extension result for loadType
    signal s_LoadExt : std_logic_vector(31 downto 0);
-- Write-back / immediate / pc+4
    signal s_PCplus4   : std_logic_vector(N-1 downto 0);
    signal s_ImmExt    : std_logic_vector(N-1 downto 0); -- from ImmGen (placeholder)

--control
-- ========= Bit-field format banner (MSB..LSB) =========
-- [19]    [18]     [17:14]     [13:11]     [10:9]   [8]   [7]   [6]  [5]  [4]   [3:1]     [0]
-- ALUSrc  ALUSrcA  ALUOp(4)    ImmType(3)  Result   MWr   RWr  MRd  Jump Brch loadType(3) halt
-- Encodings:
--   ImmType  : 000=I, 001=S, 010=B, 011=U, 100=J
--   ResultSrc: 00=ALU, 01=MEM, 10=PC+4, 11=ImmU(LUI)
--   loadType : 000=lw, 001=lh, 010=lb, 011=lbu, 100=lhu
-- NOTE: '-' denotes don't-care for synthesis.
-----------------------------------------------------------------
-- declaration
--ALU
component ALU is
  port(
    i_A       : in  std_logic_vector(31 downto 0);
    i_B       : in  std_logic_vector(31 downto 0);
    i_ALUOp   : in  std_logic_vector(3 downto 0);
    o_Y       : out std_logic_vector(31 downto 0);
    o_Zero    : out std_logic;
    o_LT      : out std_logic;
    o_LTU     : out std_logic;
    o_Ovfl    : out std_logic
  );
end component;

-- TODO: Immediate generator (outputs I/S/B/U/J immediates per s_ImmType)

-- control unit
component control_unit is
  port(
    i_opcode   : in  std_logic_vector(6 downto 0);
    i_funct3   : in  std_logic_vector(2 downto 0);
    i_funct7   : in  std_logic_vector(6 downto 0);
    o_Ctrl_Unt : out std_logic_vector(19 downto 0)
  );
end component;

-- fetch
component fetch is
  generic(N : integer := 32);
  port(
    i_clk : in std_logic;
    i_rst : in std_logic; -- Active-high reset
    i_PCsrc : in std_logic;
    i_newPC : in std_logic_vector(N-1 downto 0); -- Immediate Input
    o_PC  : out std_logic_vector(N-1 downto 0)
  );
end component;

-- LoadType: 000=lw, 001=lh, 010=lb, 011=lbu, 100=lhu
component loadType is
  port(
    i_word     : in  std_logic_vector(31 downto 0); -- DMEM 32-bit read
    i_addr_low : in  std_logic_vector(1 downto 0);  -- address(1 downto 0)
    i_LType    : in  std_logic_vector(2 downto 0);  -- s_Ctrl(3 downto 1)
    o_data     : out std_logic_vector(31 downto 0)  -- extended to 32-bit
  );
end component;

-- Register
component RegFile is
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
end component;




begin

  -- TODO: This is required to be your final input to your instruction memory. This provides a feasible method to externally load the memory module which means that the synthesis tool must assume it knows nothing about the values stored in the instruction memory. If this is not included, much, if not all of the design is optimized out because the synthesis tool will believe the memory to be all zeros.
  with iInstLd select
    s_IMemAddr <= s_NextInstAddr when '0',
      iInstAddr when others;

  -- fetch (PC)
FETCH_PC: fetch
  generic map(N => N)
  port map(
    i_clk   => iCLK,
    i_rst   => iRST,
    i_PCsrc => s_PCsrc,   -- PC source select: 0 = PC+4, 1 = new branch/jump target
    i_newPC => s_NewPC,   -- Next PC input (from ALU result for branch/jump)
    o_PC    => s_NextInstAddr   -- Output current PC value to instruction memory
  );

  -- Control Unit
    CONTROL: control_unit
    port map(
      i_opcode   => s_Inst(6 downto 0),       -- opcode[6:0]
      i_funct3   => s_Inst(14 downto 12),     -- funct3[2:0]
      i_funct7   => s_Inst(31 downto 25),     -- funct7[6:0]
      o_Ctrl_Unt => s_Ctrl                    -- packed 20-bit control bus
    );

      -- Unpack of 20-bit Ctrl
      s_ALUSrc   <= s_Ctrl(19);
      s_ALUSrcA  <= s_Ctrl(18);
      s_ALUOp    <= s_Ctrl(17 downto 14);
      s_ImmType  <= s_Ctrl(13 downto 11);
      s_ResultSrc<= s_Ctrl(10 downto 9);
      s_MemWrite <= s_Ctrl(8);
      s_RegWrite <= s_Ctrl(7);
      s_MemRead  <= s_Ctrl(6);
      s_Jump     <= s_Ctrl(5);
      s_Branch   <= s_Ctrl(4);
      s_LoadType <= s_Ctrl(3 downto 1);
      s_Halt     <= s_Ctrl(0);


  -- Register file
  u_RegFile: RegFile
    port map(
      i_CLK => iCLK,
      i_RST => iRST,
      i_WE  => s_RegWrite,
      i_RD  => s_Inst(11 downto 7),  -- rd
      i_WD  => s_RegWrData,          -- from write-back mux
      i_RS1 => s_Inst(19 downto 15), -- rs1
      i_RS2 => s_Inst(24 downto 20), -- rs2
      o_RS1 => s_RS1Data,
      o_RS2 => s_RS2Data
      );

  -- Instruction Memory
  IMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_IMemAddr(11 downto 2),
             data => iInstExt,
             we   => iInstLd,
             q    => s_Inst);
  
  -- Data Memory
  DMem: mem
    generic map(ADDR_WIDTH => ADDR_WIDTH,
                DATA_WIDTH => N)
    port map(clk  => iCLK,
             addr => s_DMemAddr(11 downto 2),
             data => s_DMemData,
             we   => s_DMemWr,
             q    => s_DMemOut);

  -- TODO: Ensure that s_Ovfl is connected to the overflow output of your ALU

  -- TODO: Implement the rest of your processor below this comment! 
    
    -- ALU Input MUX 1, operand A: 0=RS1, 1=PC
    s_ALU_A <= s_RS1Data when s_ALUSrcA='0' else s_NextInstAddr;

    -- ALU Input MUX 2, operand B: 0=RS2, 1=Imm
    s_ALU_B <= s_RS2Data when s_ALUSrc='0' else s_ImmExt;

    u_ALU: ALU
  	port map(
   	 i_A       => s_ALU_A,
   	 i_B       => s_ALU_B,
   	 i_ALUOp   => s_ALUOp,        -- control bits[17:14]
  	 o_Y       => s_ALUResult,
   	 o_Zero    => s_Zero,
   	 o_LT      => s_LT,
   	 o_LTU     => s_LTU,
    	 o_Ovfl    => s_Ovfl
 	 );

	-- keep ALU result observable for synthesis
	oALUOut <= s_ALUResult;
	-- TODO: IMM GENERATOR

	-- Branch decision from ALU flags + funct3
	process(s_Branch, s_Inst, s_Zero, s_LT, s_LTU)
	begin
  	if s_Branch='1' then
   	   case s_Inst(14 downto 12) is
     		 when "000" => s_BrTaken <= s_Zero;        -- beq
     		 when "001" => s_BrTaken <= not s_Zero;    -- bne
     		 when "100" => s_BrTaken <= s_LT;          -- blt  (signed)
      		 when "101" => s_BrTaken <= not s_LT;      -- bge  (signed)
     		 when "110" => s_BrTaken <= s_LTU;         -- bltu (unsigned)
      		 when "111" => s_BrTaken <= not s_LTU;     -- bgeu (unsigned)
     		 when others => s_BrTaken <= '0';
    		end case;
  	   else
     		s_BrTaken <= '0';
  	end if;
	end process;

-- Targets
s_BrTarget <= std_logic_vector(unsigned(s_NextInstAddr) + unsigned(s_ImmExt));  -- PC + immB

s_isJALR   <= '1' when s_Inst(6 downto 0) = "1100111" else '0';                 -- jalr opcode
s_JumpTarget <= (s_ALUResult and x"FFFFFFFE") when s_isJALR='1'                 -- jalr: clear bit0
                else s_ALUResult;                                               -- jal: ALU computed PC+immJ

-- Final PC select
s_PCsrc <= s_BrTaken or s_Jump;    -- 1 => take branch or jump
s_NewPC <= s_BrTarget when s_BrTaken='1' else s_JumpTarget;

	s_DMemWr   <= s_MemWrite;  -- control => DMEM write enable
	s_RegWr    <= s_RegWrite;  -- control => RegFile write enable
	s_DMemAddr <= s_ALUResult;  -- ALU result drives DMEM address
	s_DMemData <= s_RS2Data; 
	s_PCplus4 <= std_logic_vector(unsigned(s_NextInstAddr) + 4);

  -- LoadType: extend DMEM read according to loadType (000 lw, 001 lh, 010 lb, 011 lbu, 100 lhu)
  u_LoadType: loadType
    port map(
      i_word     => s_DMemOut,                -- 32-bit word from data memory
      i_addr_low => s_DMemAddr(1 downto 0),   -- byte offset from address
      i_LType    => s_loadType,               -- s_Ctrl(3 downto 1)
      o_data     => s_LoadExt                -- extended load result
    );
  
  -- write-back mux (ResultSrc: 00=ALU, 01=MEM, 10=PC+4, 11=ImmU)
  with s_ResultSrc select
    s_RegWrData <= s_ALUResult when "00",
                   s_LoadExt   when "01",
                   s_PCplus4   when "10",
                   s_ImmExt    when others;

-- TODO: Ensure that s_Halt is connected to an output control signal produced from decoding the Halt instruction (Opcode: 01 0100)

end structure;


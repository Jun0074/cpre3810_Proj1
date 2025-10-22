-- ============================================================
-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;

-- ============================================================
-- entity
entity tb_control_unit is
end tb_control_unit;

-- ============================================================
-- architecture
architecture behavior of tb_control_unit is

signal i_opcode   : std_logic_vector(6 downto 0);
signal i_funct3   : std_logic_vector(2 downto 0);
signal i_funct7   : std_logic_vector(6 downto 0);
signal o_Ctrl_Unt : std_logic_vector(19 downto 0);

constant clk_period : time := 20 ns;

begin

UUT: entity work.control_unit
port map(
i_opcode   => i_opcode,
i_funct3   => i_funct3,
i_funct7   => i_funct7,
o_Ctrl_Unt => o_Ctrl_Unt
);

stim_proc: process
begin

report "===== CONTROL UNIT TEST START =====";

-- R-type ADD
i_opcode <= "0110011";
i_funct3 <= "000";
i_funct7 <= "0000000";
wait for clk_period;
report "R-type ADD  => " & to_string(o_Ctrl_Unt);

-- R-type SUB
i_opcode <= "0110011";
i_funct3 <= "000";
i_funct7 <= "0100000";
wait for clk_period;
report "R-type SUB  => " & to_string(o_Ctrl_Unt);

-- I-type ADDI
i_opcode <= "0010011";
i_funct3 <= "000";
i_funct7 <= "0000000";
wait for clk_period;
report "I-type ADDI => " & to_string(o_Ctrl_Unt);

-- LOAD LW
i_opcode <= "0000011";
i_funct3 <= "010";
i_funct7 <= "0000000";
wait for clk_period;
report "LOAD LW     => " & to_string(o_Ctrl_Unt);

-- STORE SW
i_opcode <= "0100011";
i_funct3 <= "010";
i_funct7 <= "0000000";
wait for clk_period;
report "STORE SW    => " & to_string(o_Ctrl_Unt);

-- BRANCH BEQ
i_opcode <= "1100011";
i_funct3 <= "000";
i_funct7 <= "0000000";
wait for clk_period;
report "BRANCH BEQ  => " & to_string(o_Ctrl_Unt);

-- JAL
i_opcode <= "1101111";
i_funct3 <= "000";
i_funct7 <= "0000000";
wait for clk_period;
report "JAL         => " & to_string(o_Ctrl_Unt);

-- HALT
i_opcode <= "1110011";
i_funct3 <= "000";
i_funct7 <= "0000000";
wait for clk_period;
report "HALT        => " & to_string(o_Ctrl_Unt);

report "===== CONTROL UNIT TEST END =====";
wait;

end process;

end behavior;


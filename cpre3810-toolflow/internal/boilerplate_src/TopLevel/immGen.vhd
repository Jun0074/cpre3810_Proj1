library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity immGen is
  port(
    i_instr   : in  std_logic_vector(31 downto 0);
    i_immType : in  std_logic_vector(2 downto 0);  -- Instruction type selector
    o_imm     : out std_logic_vector(31 downto 0)
  );
end immGen;

architecture Behavioral of immGen is

  -- Raw immediate fields for each type
  signal s_imm_I : std_logic_vector(11 downto 0);
  signal s_imm_S : std_logic_vector(11 downto 0);
  signal s_imm_B : std_logic_vector(12 downto 0);
  signal s_imm_U : std_logic_vector(31 downto 0);
  signal s_imm_J : std_logic_vector(20 downto 0);

  -- Sign-extended outputs
  signal s_imm_I_ext : std_logic_vector(31 downto 0);
  signal s_imm_S_ext : std_logic_vector(31 downto 0);
  signal s_imm_B_ext : std_logic_vector(31 downto 0);
  signal s_imm_U_ext : std_logic_vector(31 downto 0);
  signal s_imm_J_ext : std_logic_vector(31 downto 0);

begin

  -- Extract raw immediates
  s_imm_I <= i_instr(31 downto 20);
  s_imm_S <= i_instr(31 downto 25) & i_instr(11 downto 7);
  s_imm_B <= i_instr(31) & i_instr(7) & i_instr(30 downto 25) & i_instr(11 downto 8) & "0"; -- LSB=0
  s_imm_U <= i_instr(31 downto 12) & (11 downto 0 => '0'); -- Upper immediate
  s_imm_J <= i_instr(31) & i_instr(19 downto 12) & i_instr(20) & i_instr(30 downto 21) & "0"; -- LSB=0

  -- Sign-extend each immediate using the sign extender component
  U1: entity work.sign_extenderNto32 generic map (N => 12) port map(i_data_in => s_imm_I, o_data_out => s_imm_I_ext);
  U2: entity work.sign_extenderNto32 generic map (N => 12) port map(i_data_in => s_imm_S, o_data_out => s_imm_S_ext);
  U3: entity work.sign_extenderNto32 generic map (N => 13) port map(i_data_in => s_imm_B, o_data_out => s_imm_B_ext);
  U4: entity work.sign_extenderNto32 generic map (N => 32) port map(i_data_in => s_imm_U, o_data_out => s_imm_U_ext);
  U5: entity work.sign_extenderNto32 generic map (N => 21) port map(i_data_in => s_imm_J, o_data_out => s_imm_J_ext);

  -- Select the correct sign-extended immediate
  process(i_immType, s_imm_I_ext, s_imm_S_ext, s_imm_B_ext, s_imm_U_ext, s_imm_J_ext)
  begin
    case i_immType is
      when "000" => o_imm <= s_imm_I_ext;  -- I-type
      when "001" => o_imm <= s_imm_S_ext;  -- S-type
      when "010" => o_imm <= s_imm_B_ext;  -- B-type
      when "011" => o_imm <= s_imm_U_ext;  -- U-type
      when "100" => o_imm <= s_imm_J_ext;  -- J-type
      when others => o_imm <= (others => '0');
    end case;
  end process;

end Behavioral;


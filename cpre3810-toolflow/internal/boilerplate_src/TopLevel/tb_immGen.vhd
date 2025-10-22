library ieee;
use ieee.std_logic_1164.all;

entity tb_immGen is
end tb_immGen;

architecture sim of tb_immGen is

    -- DUT ports
    signal i_instr   : std_logic_vector(31 downto 0);
    signal i_immType : std_logic_vector(2 downto 0);
    signal o_imm     : std_logic_vector(31 downto 0);

begin

    -- Instantiate DUT
    DUT: entity work.immGen
        port map(
            i_instr   => i_instr,
            i_immType => i_immType,
            o_imm     => o_imm
        );

    -- Stimulus
    TEST: process
    begin
        ------------------------------------------------
        -- I-TYPE EXAMPLE: addi x1,x2, -5 (imm = FFF...FFB)
        ------------------------------------------------
        i_instr   <= x"FFF10113";  -- binary immediate = 111111111111
        i_immType <= "000";        -- I-type
        wait for 10 ns;

        ------------------------------------------------
        -- S-TYPE EXAMPLE: sw x5, 20(x2)
        ------------------------------------------------
        i_instr   <= x"01412023";  -- imm bits come from [31:25] & [11:7]
        i_immType <= "001";
        wait for 10 ns;

        ------------------------------------------------
        -- B-TYPE EXAMPLE: beq x1,x2, offset
        ------------------------------------------------
        i_instr   <= x"FE010AE3";  -- some valid B-type encoding
        i_immType <= "010";
        wait for 10 ns;

        ------------------------------------------------
        -- U-TYPE EXAMPLE: lui x3, 0xABCDE000
        ------------------------------------------------
        i_instr   <= x"ABCDE137";
        i_immType <= "011";
        wait for 10 ns;

        ------------------------------------------------
        -- J-TYPE EXAMPLE: jal x1, offset
        ------------------------------------------------
        i_instr   <= x"004002EF";
        i_immType <= "100";
        wait for 10 ns;

        -- Done
        wait;
    end process;

end sim;

library ieee;
use ieee.std_logic_1164.all;

entity mux32to1_32bit is
  port (
    sel  : in  std_logic_vector(4 downto 0);        -- 5-bit selector
    i_D  : in  std_logic_vector(32*32-1 downto 0);  -- 32 inputs, each 32 bits wide (flattened)
    o_Q  : out std_logic_vector(31 downto 0)        -- 1 output, 32 bits
  );
end entity mux32to1_32bit;

architecture dataflow of mux32to1_32bit is
begin
  process(sel, i_D)
  begin
    case sel is
      when "00000" => o_Q <= i_D(31 downto 0);
      when "00001" => o_Q <= i_D(63 downto 32);
      when "00010" => o_Q <= i_D(95 downto 64);
      when "00011" => o_Q <= i_D(127 downto 96);
      when "00100" => o_Q <= i_D(159 downto 128);
      when "00101" => o_Q <= i_D(191 downto 160);
      when "00110" => o_Q <= i_D(223 downto 192);
      when "00111" => o_Q <= i_D(255 downto 224);
      when "01000" => o_Q <= i_D(287 downto 256);
      when "01001" => o_Q <= i_D(319 downto 288);
      when "01010" => o_Q <= i_D(351 downto 320);
      when "01011" => o_Q <= i_D(383 downto 352);
      when "01100" => o_Q <= i_D(415 downto 384);
      when "01101" => o_Q <= i_D(447 downto 416);
      when "01110" => o_Q <= i_D(479 downto 448);
      when "01111" => o_Q <= i_D(511 downto 480);
      when "10000" => o_Q <= i_D(543 downto 512);
      when "10001" => o_Q <= i_D(575 downto 544);
      when "10010" => o_Q <= i_D(607 downto 576);
      when "10011" => o_Q <= i_D(639 downto 608);
      when "10100" => o_Q <= i_D(671 downto 640);
      when "10101" => o_Q <= i_D(703 downto 672);
      when "10110" => o_Q <= i_D(735 downto 704);
      when "10111" => o_Q <= i_D(767 downto 736);
      when "11000" => o_Q <= i_D(799 downto 768);
      when "11001" => o_Q <= i_D(831 downto 800);
      when "11010" => o_Q <= i_D(863 downto 832);
      when "11011" => o_Q <= i_D(895 downto 864);
      when "11100" => o_Q <= i_D(927 downto 896);
      when "11101" => o_Q <= i_D(959 downto 928);
      when "11110" => o_Q <= i_D(991 downto 960);
      when "11111" => o_Q <= i_D(1023 downto 992);
      when others  => o_Q <= (others => '0');
    end case;
  end process;
end architecture dataflow;


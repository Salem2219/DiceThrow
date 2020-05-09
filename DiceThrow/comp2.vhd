library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity comp2 is
    port (
    j, f : in std_logic_vector(3 downto 0);
    y : out std_logic);
end comp2;

architecture rtl of comp2 is
signal jminusf, minus1 : unsigned(3 downto 0);
begin
    jminusf <= unsigned(j) - unsigned(f);
    minus1 <= jminusf - 1;
    y <= '1' when std_logic_vector(minus1) = "1111" else '0';
end rtl;

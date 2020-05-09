library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity toplevel is
    port (clk, rst, start : in std_logic;
    f, d, s : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
end toplevel;

architecture rtl of toplevel is
component dp is
     port (clk, rst, wr, i_ld, j_ld, sel : in std_logic;
    f, d, s: in std_logic_vector(3 downto 0);
    x : out std_logic_vector(1 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component ctrl is
    port(clk,rst, start: in std_logic;
        x : in std_logic_vector(1 downto 0);
        wr, i_ld, j_ld, sel: out std_logic);
end component;
signal wr, sel, i_ld, j_ld : std_logic;
signal x :  std_logic_vector(1 downto 0);
begin
    datapath : dp port map (clk, rst, wr, i_ld, j_ld, sel, f, d, s, x, y);
    control : ctrl port map (clk, rst, start, x, wr, i_ld, j_ld, sel);
end rtl;
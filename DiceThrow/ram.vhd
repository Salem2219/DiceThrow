library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity ram is
port(clk, rst, wr, x : in std_logic;
i, j, f, d, s : in std_logic_vector(3 downto 0);
y : out std_logic_vector(7 downto 0));
end ram;
architecture rtl of ram is
component adder8 is
    port (a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;
component sub4 is
    port (a, b : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(3 downto 0));
end component;
component mux8 is
    port (s : in std_logic;
    a, b : in std_logic_vector(7 downto 0);
    y : out std_logic_vector(7 downto 0));
end component;

type ram_type is array (0 to 15, 0 to 15) of
std_logic_vector(7 downto 0);
signal mem: ram_type := (others => (others =>(others => '0') )) ;
signal jminus1, iminus1, jminusf, jminusfminus1 : std_logic_vector(3 downto 0);
signal mem1, mem2, mem3, mem4, mem1plusmem2, memij : std_logic_vector(7 downto 0);
begin
u1 : sub4 port map (j, "0001", jminus1);
u2 : sub4 port map (i, "0001", iminus1);
u3 : sub4 port map (j, f, jminusf);
u4 : sub4 port map (jminusf, "0001", jminusfminus1);
u5 : adder8 port map (mem1, mem2, mem1plusmem2);
u6 : adder8 port map (mem1plusmem2, mem3, mem4);
u7 : mux8 port map (x, mem4, mem1plusmem2, memij);
mem1 <= mem(conv_integer(unsigned(i)), conv_integer(unsigned(jminus1)));
mem2 <= mem(conv_integer(unsigned(iminus1)), conv_integer(unsigned(jminus1)));
mem3 <= mem(conv_integer(unsigned(iminus1)), conv_integer(unsigned(jminusfminus1)));
process(clk)
begin
if (rst = '1') then
mem(0, 0) <= "00000001";
else
if (rising_edge(clk)) then
if (wr = '1') then
mem(conv_integer(unsigned(i)), conv_integer(unsigned(j))) <= memij ;
end if;
end if;
end if;
end process;
y <= mem(conv_integer(unsigned(d)), conv_integer(unsigned(s)));
end rtl;
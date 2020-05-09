library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity tb is
end tb ;

architecture behav of tb is
  constant clockperiod: time:= 0.1 ns;
  signal clk: std_logic:='0';
  signal rst,start: std_logic;
  signal f, d, s : std_logic_vector(3 downto 0);
  signal y1, y2, y3, y4, y5 : std_logic_vector (7 downto 0);
  component toplevel
     port (clk, rst, start : in std_logic;
    f, d, s : in std_logic_vector(3 downto 0);
    y : out std_logic_vector(7 downto 0));
  end component ;
  begin
    clk <= not clk after clockperiod /2;
    rst <= '1' , '0' after 0.1 ns;
    start <= '0' , '1' after 0.1 ns, '0' after 0.5 ns;
    dut1: toplevel port map(clk,rst,start, "0100", "0010", "0001",  y1); -- findWays(4, 2, 1)
    dut2: toplevel port map(clk,rst,start,"0010", "0010", "0011",  y2); -- findWays(2, 2, 3)
    dut3: toplevel port map(clk,rst,start,"0110", "0011", "1000",  y3); -- findWays(6, 3, 8)
    dut4: toplevel port map(clk,rst,start,"0100", "0010", "0101",  y4); -- findWays(4, 2, 5)
    dut5: toplevel port map(clk,rst,start,"0100", "0011", "0101",  y5); -- findWays(4, 3, 5)
  end behav;
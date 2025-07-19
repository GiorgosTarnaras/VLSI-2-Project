library ieee;
use ieee.std_logic_1164.all;

entity gray_cell is 
	port(
		g1   : in  std_logic; -- p_i_k
		p1   : in  std_logic; -- g_i_k
		g0   : in  std_logic; -- g_(k-1)_j
		g2   : out std_logic -- g_i_j
	);
end gray_cell;

architecture my_arch of gray_cell is
	begin
		g2 <= g1 OR ( p1 AND g0 );

end my_arch;
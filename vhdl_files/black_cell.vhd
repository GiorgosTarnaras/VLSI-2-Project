library ieee;
use ieee.std_logic_1164.all;

entity black_cell is
	port(
		g1   : in std_logic; -- p_(k-1)_j
		p1   : in std_logic; -- g_(k-1)_j
		g0   : in std_logic; -- p_i_k
		p0   : in std_logic; -- g_i_k
		g2   : out std_logic; --g_i_j
		p2   : out std_logic  --p_i_j
	);
end black_cell;

architecture my_arch of black_cell is
	begin
		g2 <= g1 OR ( p1 AND g0 );
		p2 <= p1 AND p0;

end my_arch;
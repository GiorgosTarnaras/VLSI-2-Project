library ieee;
use ieee.std_logic_1164.all;

entity sum_logic is
	generic ( m : integer := 32 );
	port(
		P, C  : in  std_logic_vector( m-1 downto 0 );
		G_last: in  std_logic;
		S	  : out std_logic_vector( m-1 downto 0 );
		Cout  : out std_logic
	);
end sum_logic;

architecture my_arch of sum_logic is
	begin
		generate_label:
		for i in 0 to m-1 generate
			S(i) <= C(i) XOR P(i);
		end generate;
		
		Cout <= ( P(m-1) AND C(m-1) ) OR G_last;		
			
end my_arch;
library ieee;
use ieee.std_logic_1164.all;

entity pg_calculation is
	generic ( m : integer := 32 );
	port(
		A, B : in  std_logic_vector( m-1 downto 0 );
		P, G : out std_logic_vector( m-1 downto 0 )
	);
end pg_calculation;

architecture my_arch of pg_calculation is
	begin
		generate_label:
		for i in 0 to m-1 generate
			P(i) <= A(i) XOR B(i);
			G(i) <= A(i) AND B(i);
		end generate;
			
end my_arch;
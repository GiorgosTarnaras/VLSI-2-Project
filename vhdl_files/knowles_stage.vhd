library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity knowles_stage is
	generic( 
		k  : integer := 32;
		gn : integer := 1 --gray cell number
	);
	port(
		P_in, G_in   : in  std_logic_vector( k-1 downto 0 );
		P_out, G_out : out std_logic_vector( k-1 downto 0 )
	);
end knowles_stage;

architecture my_arch of knowles_stage is

	component black_cell is
		port(
			g1   : in std_logic; -- p_(k-1)_j
			p1   : in std_logic; -- g_(k-1)_j
			g0   : in std_logic; -- p_i_k
			p0   : in std_logic; -- g_i_k
			g2   : out std_logic; --g_i_j
			p2   : out std_logic  --p_i_j
		);
	end component;

	component gray_cell is 
		port(
			g1   : in  std_logic; -- p_i_k
			p1   : in  std_logic; -- g_i_k
			g0   : in  std_logic; -- g_(k-1)_j
			g2   : out std_logic -- g_i_j
		);
	end component;

	begin
	
		generate_buffer_label:
		for j in 0 to gn-1 generate
			P_out(j) <= P_in(j);
			G_out(j) <= G_in(j);
		end generate;
		
		generate_gray_label:
		for j in gn to 2*gn-1 generate
			gray_j : gray_cell port map( G_in(j), P_in(j), G_in(j-gn), G_out(j) );
			P_out(j) <= P_in(j);
		end generate;
		
		generate_black_label:
		for j in 2*gn to k-1 generate
			black_j : black_cell port map( G_in(j), P_in(j), G_in(j-gn), P_in(j-gn), G_out(j), P_out(j) );
		end generate;
			
end my_arch;
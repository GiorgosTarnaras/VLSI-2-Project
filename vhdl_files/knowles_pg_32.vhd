library ieee;
use ieee.std_logic_1164.all;

entity knowles_pg_32 is
	port(
		P, G  : in  std_logic_vector( 31 downto 0 );
		G_0	  : out std_logic_vector( 31 downto 0 )
	);
end knowles_pg_32;

architecture my_arch of knowles_pg_32 is

	component knowles_stage is
		generic( 
			k  : integer := 32;
			gn : integer := 1 --gray cell number
		);
		port(
			P_in, G_in   : in  std_logic_vector( k-1 downto 0 );
			P_out, G_out : out std_logic_vector( k-1 downto 0 )
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

	signal P1, P2, P3, P4, G1, G2, G3, G4 : std_logic_vector( 31 downto 0 );

	begin
		
		-- stages
		stage_0 : knowles_stage generic map(32, 1) port map( P, G, P1, G1 );
		stage_1 : knowles_stage generic map(32, 2) port map( P1, G1, P2, G2 );
		stage_2 : knowles_stage generic map(32, 4) port map( P2, G2, P3, G3 );
		stage_3 : knowles_stage generic map(32, 8) port map( P3, G3, P4, G4 );
		
		-- last stage buffers
		generate_buffer_label:
		for j in 0 to 15 generate
			G_0(j) <= G4(j);
		end generate;
		
		-- last stage gray cells
		generate_gray_label:
		for j in 0 to 7 generate
			gray_even : gray_cell port map( G4(16+2*j), P4(16+2*j), G4(2*j+1), G_0(16+ 2*j) );
			gray_odd  : gray_cell port map( G4(16+2*j+1), P4(16+2*j+1), G4(2*j+1), G_0(16+ 2*j+1) );
		end generate;	
			
end my_arch;
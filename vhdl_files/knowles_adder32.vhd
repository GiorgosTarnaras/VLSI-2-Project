library ieee;
use ieee.std_logic_1164.all;

entity knowles_adder32 is
	port(
		A, B  : in  std_logic_vector( 31 downto 0 );
		Cin   : in std_logic;
		S	  : out std_logic_vector( 31 downto 0 );
		Cout  : out std_logic
	);
end knowles_adder32;

architecture my_arch of knowles_adder32 is

	component pg_calculation is
		generic ( m : integer := 32 );
		port(
			A, B : in  std_logic_vector( m-1 downto 0 );
			P, G : out std_logic_vector( m-1 downto 0 )
		);
	end component;
	
	component knowles_pg_32 is
		port(
			P, G  : in  std_logic_vector( 31 downto 0 );
			G_0	  : out std_logic_vector( 31 downto 0 )
		);
	end component;
	
	component sum_logic is
		generic ( m : integer := 32 );
		port(
			P, C  : in  std_logic_vector( m-1 downto 0 );
			G_last: in  std_logic;
			S	  : out std_logic_vector( m-1 downto 0 );
			Cout  : out std_logic
		);
	end component;
	
	signal P_int, G_int : std_logic_vector( 32 downto 0 );
	signal G_0_int : std_logic_vector( 31 downto 0 );
	
	begin
		P_int(0) <= '0';
		G_int(0) <= Cin;
		pg_calc :  pg_calculation generic map(32) port map(A, B, P_int(32 downto 1), G_int(32 downto 1) );
		pg_logic : knowles_pg_32 port map( P_int(31 downto 0), G_int(31 downto 0), G_0_int );
		sum : sum_logic generic map(32) port map( G_0_int, P_int(32 downto 1), G_int(32), S, Cout );
			
end my_arch;
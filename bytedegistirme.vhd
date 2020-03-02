library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bytedegistirme is port 
(
	metin_giris : in STD_LOGIC_VECTOR (127 downto 0);
	skutusucikis : out STD_LOGIC_VECTOR (127 downto 0)
);
end bytedegistirme;

architecture Behavioral of bytedegistirme is

	component skutusu is port 
	(
		byte : 		in STD_LOGIC_VECTOR(7 downto 0);
		bytecikis : out STD_LOGIC_VECTOR(7 downto 0)
	); 
	end component;

	begin

	s1 : skutusu port map 
	(
		metin_giris(127 downto 120),
		skutusucikis(127 downto 120)
	); 
	s2 : skutusu port map 
	(
		metin_giris(119 downto 112),
		skutusucikis(119 downto 112)
	); 
	s3 : skutusu port map 
	(
		metin_giris(111 downto 104),
		skutusucikis(111 downto 104)
	); 
	s4 : skutusu port map 
	(
		metin_giris(103 downto 96),
		skutusucikis(103 downto 96)
	); 
	s5 : skutusu port map 
		(metin_giris(95 downto 88),
		skutusucikis(95 downto 88)
	); 
	s6 : skutusu port map 
	(
		metin_giris(87 downto 80),
		skutusucikis(87 downto 80)
	); 
	s7 : skutusu port map 
	(
		metin_giris(79 downto 72),
		skutusucikis(79 downto 72)
	); 
	s8 : skutusu port map 
	(
		metin_giris(71 downto 64),
		skutusucikis(71 downto 64)
	); 
	s9 : skutusu port map 
	(
		metin_giris(63 downto 56),
		skutusucikis(63 downto 56)
	); 
	s10 : skutusu port map 
	(
		metin_giris(55 downto 48),
		skutusucikis(55 downto 48)
	); 
	s11 : skutusu port map 
	(
		metin_giris(47 downto 40),
		skutusucikis(47 downto 40)
	); 
	s12 : skutusu port map 
	(
		metin_giris(39 downto 32),
		skutusucikis(39 downto 32)
	); 
	s13 : skutusu port map 
	(
		metin_giris(31 downto 24),
		skutusucikis(31 downto 24)
	); 
	s14 : skutusu port map 
	(
		metin_giris(23 downto 16),
		skutusucikis(23 downto 16)
	); 
	s15 : skutusu port map 
	(
		metin_giris(15 downto 8),
		skutusucikis(15 downto 8)
	); 
	s16 : skutusu port map 
	(
		metin_giris(7 downto 0),
		skutusucikis(7 downto 0)
	);

end Behavioral;
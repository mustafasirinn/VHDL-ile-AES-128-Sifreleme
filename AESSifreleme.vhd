library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AESSifreleme is Port
(
	metin: in STD_LOGIC_VECTOR(127 downto 0);
	anahtar: in STD_LOGIC_VECTOR(127 downto 0);
	adimanahtari: in STD_LOGIC_VECTOR(127 downto 0);
	sifrelimetin: out STD_LOGIC_VECTOR (127 downto 0)
);
end AESSifreleme;

architecture birtur of AESSifreleme is
	
	component anahtarekleme Port
	(	
		giris1: in STD_LOGIC_VECTOR(127 downto 0);
		giris2: in STD_LOGIC_VECTOR(127 downto 0);
		sonuc: out STD_LOGIC_VECTOR(127 downto 0)
	);
	end component;
	
	component bytedegistirme Port
	(
		metin_giris: in STD_LOGIC_VECTOR(127 downto 0);
		skutusucikis: out STD_LOGIC_VECTOR(127 downto 0)
	);
	end component;
	
	component satirkaydirma Port 
	( 
		satirgiris : in  STD_LOGIC_VECTOR (127 downto 0);
		kaydirilmis : out  STD_LOGIC_VECTOR (127 downto 0)
	);
	end component;
	
	component sutunkarma Port 
	( 
		sutunkgiris : in  STD_LOGIC_VECTOR (127 downto 0);
		sutunkcikis : out  STD_LOGIC_VECTOR (127 downto 0)
	);
	end component;

	signal baslangic, skutusinyal, satirksinyal, sifrelisinyal, sutunksinyal: STD_LOGIC_VECTOR (127 downto 0);
	
	begin

		adim1: anahtarekleme port map (metin, anahtar, baslangic);
		adim2: bytedegistirme port map (baslangic, skutusinyal);
		adim3: satirkaydirma port map (skutusinyal, satirksinyal);
		adim4: sutunkarma port map (satirksinyal, sutunksinyal);
		adim5: anahtarekleme port map (sutunksinyal, adimanahtari, sifrelisinyal);
		sifrelimetin <= sifrelisinyal;
		
end birtur;	

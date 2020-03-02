library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity anahtarekleme is port
(	
	giris1: in STD_LOGIC_VECTOR(127 downto 0);
	giris2: in STD_LOGIC_VECTOR(127 downto 0);
	sonuc: out STD_LOGIC_VECTOR(127 downto 0)
);
end anahtarekleme;

architecture islem of anahtarekleme is
 begin
	sonuc <= giris1 XOR giris2;
end islem;
 
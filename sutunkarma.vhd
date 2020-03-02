library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sutunkarma is Port 
( 
	sutunkgiris : in  STD_LOGIC_VECTOR (127 downto 0);
	sutunkcikis : out  STD_LOGIC_VECTOR (127 downto 0)
);
end sutunkarma;

architecture Behavioral of sutunkarma is
	
	signal p0,p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15: STD_LOGIC_VECTOR(7 downto 0);

	component sutunislem is Port 
	( 
		i1,i2,i3,i4: in STD_LOGIC_VECTOR (7 downto 0);
		islemcikti : out  STD_LOGIC_VECTOR (7 downto 0)
	);
	end component;
 
	begin

		k1:sutunislem port map(sutunkgiris(127 downto 120),sutunkgiris(119 downto 112),sutunkgiris(111 downto 104),sutunkgiris(103 downto 96),p0);
		k2:sutunislem port map(sutunkgiris(119 downto 112),sutunkgiris(111 downto 104),sutunkgiris(103 downto 96),sutunkgiris(127 downto 120),p1);
		k3:sutunislem port map(sutunkgiris(111 downto 104),sutunkgiris(103 downto 96),sutunkgiris(127 downto 120),sutunkgiris(119 downto 112),p2);
		k4:sutunislem port map(sutunkgiris(103 downto 96),sutunkgiris(127 downto 120),sutunkgiris(119 downto 112),sutunkgiris(111 downto 104),p3);

		k5:sutunislem port map(sutunkgiris(95 downto 88),sutunkgiris(87 downto 80),sutunkgiris(79 downto 72),sutunkgiris(71 downto 64),p4);
		k6:sutunislem port map(sutunkgiris(87 downto 80),sutunkgiris(79 downto 72),sutunkgiris(71 downto 64),sutunkgiris(95 downto 88),p5);
		k7:sutunislem port map(sutunkgiris(79 downto 72),sutunkgiris(71 downto 64),sutunkgiris(95 downto 88),sutunkgiris(87 downto 80),p6);
		k8:sutunislem port map(sutunkgiris(71 downto 64),sutunkgiris(95 downto 88),sutunkgiris(87 downto 80),sutunkgiris(79 downto 72),p7);

		k9:sutunislem port map(sutunkgiris(63 downto 56),sutunkgiris(55 downto 48),sutunkgiris(47 downto 40),sutunkgiris(39 downto 32),p8);
		k10:sutunislem port map(sutunkgiris(55 downto 48),sutunkgiris(47 downto 40),sutunkgiris(39 downto 32),sutunkgiris(63 downto 56),p9);
		k11:sutunislem port map(sutunkgiris(47 downto 40),sutunkgiris(39 downto 32),sutunkgiris(63 downto 56),sutunkgiris(55 downto 48),p10);
		k12:sutunislem port map(sutunkgiris(39 downto 32),sutunkgiris(63 downto 56),sutunkgiris(55 downto 48),sutunkgiris(47 downto 40),p11);

		k13:sutunislem port map(sutunkgiris(31 downto 24),sutunkgiris(23 downto 16),sutunkgiris(15 downto 8),sutunkgiris(7 downto 0),p12);
		k14:sutunislem port map(sutunkgiris(23 downto 16),sutunkgiris(15 downto 8),sutunkgiris(7 downto 0),sutunkgiris(31 downto 24),p13);
		k15:sutunislem port map(sutunkgiris(15 downto 8),sutunkgiris(7 downto 0),sutunkgiris(31 downto 24),sutunkgiris(23 downto 16),p14);
		k16:sutunislem port map(sutunkgiris(7 downto 0),sutunkgiris(31 downto 24),sutunkgiris(23 downto 16),sutunkgiris(15 downto 8),p15);

		sutunkcikis <=p0&p1&p2&p3&p4&p5&p6&p7&p8&p9&p10&p11&p12&p13&p14&p15;

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sutunislem is Port 
(
	i1,i2,i3,i4: in STD_LOGIC_VECTOR (7 downto 0);
	islemcikti : out  STD_LOGIC_VECTOR (7 downto 0)
);
end sutunislem;

architecture Behavioral of sutunislem is

	begin

		islemcikti(7)<=i1(6) XOR i2(6) XOR i2(7) XOR i3(7) XOR i4(7);
		islemcikti(6)<=i1(5) XOR i2(5) XOR i2(6) XOR i3(6) XOR i4(6);
		islemcikti(5)<=i1(4) XOR i2(4) XOR i2(5) XOR i3(5) XOR i4(5);
		islemcikti(4)<=i1(3) XOR i1(7) XOR i2(3) XOR i2(4) XOR i2(7) XOR i3(4) XOR i4(4);

		islemcikti(3)<=i1(2) XOR i1(7) XOR i2(2) XOR i2(3) XOR i2(7) XOR i3(3) XOR i4(3);
		islemcikti(2)<=i1(1) XOR i2(1) XOR i2(2) XOR i3(2) XOR i4(2);
		islemcikti(1)<=i1(0) XOR i1(7) XOR i2(0) XOR i2(1) XOR i2(7) XOR i3(1) XOR i4(1);
		islemcikti(0)<=i1(7) XOR i2(7) XOR i2(0) XOR i3(0) XOR i4(0);

end Behavioral;
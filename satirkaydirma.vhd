library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity satirkaydirma is Port 
( 
	satirgiris : in  STD_LOGIC_VECTOR (127 downto 0);
   kaydirilmis : out  STD_LOGIC_VECTOR (127 downto 0)
);
end satirkaydirma;

architecture Behavioral of satirkaydirma is

	signal s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15:STD_LOGIC_VECTOR(7 downto 0);

	begin
		s15<=satirgiris(7 downto 0);	 
		s11<=satirgiris(39 downto 32);		 
		s7<=satirgiris(71 downto 64);		 
		s3<=satirgiris(103 downto 96);	
			 
		s14<=satirgiris(15 downto 8);
		s10<=satirgiris(47 downto 40);
		s6<=satirgiris(79 downto 72);	
		s2<=satirgiris(111 downto 104);
			
		s13<=satirgiris(23 downto 16);	
		s9<=satirgiris(55 downto 48);	
		s5<=satirgiris(87 downto 80);	
		s1<=satirgiris(119 downto 112);	

		s12<=satirgiris(31 downto 24);	
		s8<=satirgiris(63 downto 56);	
		s4<=satirgiris(95 downto 88);	
		s0<=satirgiris(127 downto 120);	

		kaydirilmis<=s0&s5&s10&s15&s4&s9&s14&s3&s8&s13&s2&s7&s12&s1&s6&s11;	

end Behavioral;
Library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity multiplexer2X1 is
port(	A, B : in std_logic_vector(15 downto 0);
	sel : std_logic;
	C : out std_logic_vector(15 downto 0));
end multiplexer2X1;
architecture structural of multiplexer2X1 is
begin
process(A, B)
	begin
	if (sel = '0') then
	C <= B;
	else C <= A;
	end if;
end process;
end structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use WORK.ADD_OVERLOAD.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

entity phase_generator is
 port(	--fin : in std_logic_vector(7 downto 0) := (others => '1');
 	--fc : in std_logic_vector(7 downto 0):= (others => '1');
 	clk : in std_logic;
 	pR : inout std_logic_vector(23 downto 0) := (others => '0'));
end phase_generator;

architecture structural of phase_generator is
begin
clock_process : process(clk)
 	variable pR_buff : std_logic_vector(23 downto 0);
 	variable pI_integer : integer := 2097152;
 	variable pI_vector : std_logic_vector(23 downto 0) :=
	std_logic_vector(to_unsigned(pI_integer, 24));
 	begin
 	pR_buff := pR;
 	if rising_edge(clk) then
 		pR <= pI_vector + pR_buff;
 	end if;
 	if (to_integer(unsigned('0'&pR)) = 2**24) then
 		pR <= (others => '0');
 	end if;
end process;
end structural;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity ask_modulator is
port(	clk : in std_logic;
 	message : in std_logic;
 	ask_amp : inout std_logic_vector(15 downto 0));
end ask_modulator;

architecture Behavioral of ask_modulator is

procedure output_ask_file (amp : in integer) is
	file ask_wave_file: text open append_mode is "C:\modeltech64_2020.4\examples\lvdund\result_files\ask_wave_file.xls";
	variable print : line;
	begin
	write(print, amp);
	writeline(ask_wave_file, print);
	file_close(ask_wave_file);
end output_ask_file;
component dds_entity
port(	--f0 : in integer;
	--fc : in integer;
	clk : in std_logic;
	sine_wave_amp : inout std_logic_vector(15 downto 0));
end component;
component multiplexer2X1
port(	A, B : in std_logic_vector(15 downto 0);
	sel : std_logic;
	C : out std_logic_vector(15 downto 0));
end component;
signal osc1 : std_logic_vector(15 downto 0);
signal trigger : bit := '0';

begin
DDS1 : dds_entity port map (clk, osc1);
mux : multiplexer2X1 port map (osc1, (others => '0'), message, ask_amp);
process(clk)
	begin
	if (rising_edge(clk)) then
	trigger <= not trigger;
	end if;
	end process;
process(trigger)
	begin
	output_ask_file(to_integer(signed(ask_amp)));
end process;

end Behavioral;

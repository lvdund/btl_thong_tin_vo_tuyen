library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use STD.TEXTIO.ALL;

entity PtWC is
port(	pR : in std_logic_vector(23 downto 0);
	sine_wave : inout std_logic_vector(15 downto 0) := (others => 'U'));
end PtWC;

architecture sine_wave_builder of PtWC is

type table is array (0 to 255) of integer;
signal addr : integer := 0;
alias addr_vector : std_logic_vector(7 downto 0) is pR(23 downto 16);

procedure table_fill (look_up_var : inout table) is
	file LOOK_UP_TABLE : text open read_mode is "C:\modeltech64_2020.4\examples\lvdund\result_files\LOOK_UP_TABLE.txt";
	variable buff : line;
	begin
	while(not (endfile(LOOK_UP_TABLE))) loop
		for i in 0 to 255 loop
		readline(LOOK_UP_TABLE, buff);
		read(buff, look_up_var(i));
		end loop;
	end loop;
	file_close(LOOK_UP_TABLE);
end table_fill;

procedure output_sine_file (amp : in integer) is
	file sine_wave_file : text open append_mode is "C:\modeltech64_2020.4\examples\lvdund\result_files\sine_wave_file.xls";
	variable print : line;
	begin
	write(print, amp);
	writeline(sine_wave_file, print);
	file_close(sine_wave_file);
end output_sine_file;

begin
fill_table : process(pR)
	variable look_up : table;
	begin
	table_fill(look_up);
	addr <= to_integer(unsigned(addr_vector));
	sine_wave <= std_logic_vector(to_signed(look_up(addr), 16));
	output_sine_file(to_integer(signed(sine_wave)));
end process;
end sine_wave_builder;

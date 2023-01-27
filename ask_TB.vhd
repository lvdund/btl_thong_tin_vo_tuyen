library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ask_TB is
-- Port ( );
end ask_TB;

architecture Behavioral of ask_TB is

-- signal for DUT
signal clk : std_logic;
signal message : std_logic;
signal ask_amp : std_logic_vector(15 downto 0);
-- component declaration for DUT
component ask_modulator is
port(
	clk : in std_logic;
	message : in std_logic;
	ask_amp : inout std_logic_vector(15 downto 0)
);
end component;
constant clk_period : time := 4 ns;

begin
-- clock generation process
-- Clock process definitions( clock with 50% duty cycle is generated here.
clk_process :process
	begin
	clk <= '0';
	wait for clk_period/2; --for 0.01 ns signal is '0'.
	clk <= '1';
	wait for clk_period/2; --for next 0.01 ns signal is '1'.
end process;
-- port map the DUT: Design Under Test
DUT : ask_modulator port map
(clk => clk, message => message, ask_amp => ask_amp );
-- stimulus process
stimulus: process
	begin
	--wait for clk_period/2;
	message <='0';
	wait for clk_period*16;
	message <='1';
	wait for clk_period*16;
	message <='0';
	wait for clk_period*32;
	message <='1';
	wait for clk_period*16;
	message <='0';
	wait for clk_period*32;
	message <='1';
	wait for clk_period*32;
	message <='0';
	wait for clk_period*32;
	message <='1';
	wait for clk_period*16;
	message <= '0';
	wait for clk_period*48;
end process;
end Behavioral;

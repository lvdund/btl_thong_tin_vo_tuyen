library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dds_entity is
 port(	--f0 : in std_logic_vector(7 downto 0) := (others => '1');
 	--fc : in std_logic_vector(7 downto 0) := (others => '1');
 	clk : in std_logic;
 	sine_wave_amp : inout std_logic_vector(15 downto 0));
end dds_entity;

architecture implementation of dds_entity is
 	signal pR_connect : std_logic_vector(23 downto 0) := (others => '0');
 	component phase_generator
 	port(	--fin : in std_logic_vector(7 downto 0) := (others => '1');
 		--fc : in std_logic_vector(7 downto 0) := (others => '1');
 		clk : in std_logic;
 		pR : inout std_logic_vector(23 downto 0));
 	end component;
 	component PtWC
 		port(pR : in std_logic_vector(23 downto 0);
 		sine_wave : inout std_logic_vector(15 downto 0));
 	end component;
begin
 	PG_instance : phase_generator port map (clk, pR_connect);
 	PtWC_instance : PtWC port map (pR_connect, sine_wave_amp);
end implementation;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

package add_overload is
 	function "+" (a, b : std_logic_vector) return std_logic_vector;
end add_overload;

package body add_overload is
 	function "+" (a, b : std_logic_vector) return std_logic_vector is
 		variable c: std_logic := '0';
 		variable sum : std_logic_vector(a'length-1 downto 0);
 		begin
 		for i in sum'reverse_range loop
 			sum(i) := (a(i) xor b(i)) xor (c);
 			c := ((c) and (a(i) xor b(i))) or (a(i) and b(i));
 		end loop;
 		return(sum);
 	end "+";
end add_overload;


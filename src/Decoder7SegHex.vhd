library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Decoder7SegHex is
    port (
        --this is what actually goes to the seven segment displays
        --0 turns on a segment, 1 turns it off
        out_7seg: out std_logic_vector(6 downto 0);
        --A hexadecimal digit to display
        in_val: in unsigned(3 downto 0)
    );
end entity Decoder7SegHex;
-- 

architecture Decoder7SegHex_RTL of Decoder7SegHex is

--this is where 1 represents a lit segment
signal output : std_logic_vector(6 downto 0);

begin

--so we need to invert for the final output
out_7seg <= not output;

process (in_val) is
begin
    case to_integer(in_val) is
        when 0      => output <= "0111111";
        when 1      => output <= "0000110";
		  --fill this out as necessary
        when others => output <= "1000000";
    end case;
end process;

end architecture Decoder7SegHex_RTL;

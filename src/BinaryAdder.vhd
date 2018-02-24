
--Stuff to include
library IEEE;
--for std_logic and std_logic_vector types
use IEEE.std_logic_1164.all;
--for signed and unsigned types
use IEEE.numeric_std.all;


--This declares the inputs and outputs of an entity
entity BinaryAdder is
    port (
        --switches. 0 is down, 1 is up
        SW:   in  std_logic_vector(9 downto 0);
        
        --buttons. 0 is pressed, 1 is released
        KEY:  in  std_logic_vector(3 downto 0);
        
        --red LEDs. 1 is lit, 0 is unlit
        LEDR: out std_logic_vector(9 downto 0);
        
        --hex displays. 0 is lit, 1 is unlit
        HEX0: out std_logic_vector(6 downto 0);
        HEX1: out std_logic_vector(6 downto 0);
        HEX2: out std_logic_vector(6 downto 0);
        HEX3: out std_logic_vector(6 downto 0);
        HEX4: out std_logic_vector(6 downto 0);
        HEX5: out std_logic_vector(6 downto 0) --Note how there is no ; on the last one!
    );
end entity BinaryAdder;

--the architecture name has to be unique, so it is common to append something
--to the name of the entity it is for
architecture BinaryAdder_RTL of BinaryAdder is
    
    --before instantiating another entity it has to be
    --declared like this with all the inputs and outputs
    --it's like declaring a function prototype in C
    --If you change the inputs and outputs in the entity file
    --you have to change this to match
    component Decoder7SegHex is
        port (
            in_val: in unsigned(3 downto 0);
            out_7seg: out std_logic_vector(6 downto 0)
        );
    end component;
    
    --these declares an intermediate signal that doesn't get
    --exposed to outside
    
    --Assign binary numbers to this and it shows up on the hex display
    signal out_0    : unsigned(7 downto 0);
    
    --This is used as a register to store a number you enter
    signal a       : unsigned(7 downto 0);


begin
    --LEDs displaying the inversion of the switches
    --putting (a downto b) takes a "slice" of a logic vector or unsigned
    --signal
    --You can write quick combinatorial logic like this
    LEDR(7 downto 0) <= not SW(7 downto 0);

    
    --this is also combinatorial logic, so it all happens instantaneously
    --you can't assign something based on its present value
    --you have to imclude all the input values in the sensititvity list
    --in this case the sensitivity list is just a
    process (a) is
    begin
        --a(0) gets bit 0 of a. '1' and '0' are logic literal values 
        --and a single = is used for equality
        if (a(0) = '1') then --a is odd
            out_0 <= a + a;
        else --a is even
            out_0 <= a + 1;
        end if;
    end process;
    
    --this is a clocked process that saves the switches into
    --a when key(0) is released
    --only include the clock signal after process
    process (KEY(0)) is
    begin
        if rising_edge(KEY(0)) then
            a <= unsigned(SW(7 downto 0));
        end if;
    end process;
    
    --instantiating two Decoder7SegHex, each taking one half of out_0
    --and outputting to a different hex display
    display_0 : Decoder7SegHex port map (
        in_val => out_0(3 downto 0), --note how this one uses , instead of ;!
        out_7seg => HEX0
    );
    display_1 : Decoder7SegHex port map (
        in_val => out_0(7 downto 4),
        out_7seg => HEX1
    );

end architecture BinaryAdder_RTL;

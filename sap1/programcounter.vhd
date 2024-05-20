library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is 
    port(
        clock: in std_logic;
        incrementPc: in std_logic; 
        clear: in std_logic;
        pcEnable: in std_logic; 
        addr: out std_logic_vector(3 downto 0)
    );
end PC;

architecture Behavioral of PC is
    signal addr_int: std_logic_vector(3 downto 0) := (others => '0');
    
begin
    process(clock, clear)
    variable current_addr: unsigned(3 downto 0) := (others => '0');
    begin
        if clear = '1' then
            addr_int <= "0000";
            current_addr := "0000";
        elsif rising_edge(clock) then
            if incrementPc = '1' then
                current_addr := current_addr + 1;
            end if;
        end if;
        addr_int <= std_logic_vector(current_addr);
    end process;
    addr <= addr_int when pcEnable = '1' else (others => 'Z');
end Behavioral;
entity ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity memoryaddressregister is
    port (
        clock : in std_logic;
        loadMem: in std_logic;
        addr_in: in std_logic_vector(3 downto 0);
        addr_out: out std_logic_vector(3 downto 0);
    );
end memoryaddressregister;

architecture behavioral of memoryaddressregister is 
    signal addr_out_int: std_logic_vector(3 downto 0) := "0000";
begin 
    process(clock)
    begin
        if rising_edge(clock) then
            if loadMem = '1' then
                addr_out_int <= addr_in;
            end if;
        end if;
    end process;

    addr_out <= addr_out_int;
end behavioral;

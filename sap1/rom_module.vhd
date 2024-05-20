library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- simple ram must be programmed before use
entity rom_module is
    port(
        clk : in std_logic;
        ce : in std_logic;
        addr : in std_logic_vector(3 downto 0);
        data_out : out std_logic_vector(7 downto 0)
    );
end entity rom_module;

architecture behavioral of rom_module is
    type ram_type is array(0 to 15) of std_logic_vector(7 downto 0);
    -- put your binary code here
    signal ram : ram_type := (
        x"00", x"01", x"02", x"03",
        x"04", x"05", x"06", x"07",
        x"08", x"09", x"0A", x"0B",
        x"0C", x"0D", x"0E", x"0F"
    );
    begin
        process(clk)
        begin
            if rising_edge(clk) then
                if ce = '1' then
                    data_out <= ram(to_integer(unsigned(addr)));
                end if;
            end if;
        end process;
end architecture behavioral;
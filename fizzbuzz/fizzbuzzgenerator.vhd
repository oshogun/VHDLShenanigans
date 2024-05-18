library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FizzBuzzGenerator is
    port(
        clk : in std_logic;
        rst : in std_logic;
        ready: in std_logic; -- receiver is ready to receive data
        isFizz : out std_logic;
        isBuzz : out std_logic;
        isNumber : out std_logic;
        number : out unsigned(6 downto 0)); --7 bits for 0-100
end entity FizzBuzzGenerator;

architecture behavioral of FizzBuzzGenerator is
    signal counter : unsigned(6 downto 0) := (others => '0');
    signal isFizzSignal : std_logic := '0';
    signal isBuzzSignal : std_logic := '0';
    signal isNumberSignal : std_logic := '0';
begin
    process(clk)
    variable currentCounter : unsigned(6 downto 0) := (others => '0');
    begin
        if rising_edge(clk) then
            if rst = '1' then
                currentCounter := (others => '0');
                counter <= (others => '0');
                isFizzSignal <= '0';
                isBuzzSignal <= '0';
                isNumberSignal <= '0';
            elsif ready = '1' then
                currentCounter := currentCounter + 1;
                if currentCounter > 100 then
                    currentCounter := "0000001";
                end if;
                counter <= currentCounter;
                isFizzSignal <= '0';
                isBuzzSignal <= '0';
                isNumberSignal <= '0';
                if currentCounter mod 3 = 0 then
                    isFizzSignal <= '1';
                end if;
                if currentCounter mod 5 = 0 then
                    isBuzzSignal <= '1';
                end if;
                if isFizzSignal = '0' and isBuzzSignal = '0' then
                    isNumberSignal <= '1';
                end if;
            elsif ready = '0' then -- wait until ready and don't change state
                isFizzSignal <= isFizzSignal;
                isBuzzSignal <= isBuzzSignal;
                isNumberSignal <= isNumberSignal;
            end if;
        end if;
    end process;
    isFizz <= isFizzSignal;
    isBuzz <= isBuzzSignal;
    isNumber <= isNumberSignal;
    number <= counter;
end architecture behavioral;    
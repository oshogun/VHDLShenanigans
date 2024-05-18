library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FizzBuzzSystem is
    Port (
        clk : in std_logic;
        rst : in std_logic
    );
end FizzBuzzSystem;

architecture Behavioral of FizzBuzzSystem is
    signal ready : std_logic;
    signal counter : unsigned(6 downto 0);
    signal isFizzSignal : std_logic;
    signal isBuzzSignal : std_logic;
    signal isNumberSignal : std_logic;
    signal serialOut : std_logic_vector(7 downto 0);
begin
    FizzBuzzGen: entity work.FizzBuzzGenerator
        port map (
            clk => clk,
            rst => rst,
            ready => ready,
            number => counter,
            isFizz => isFizzSignal,
            isBuzz => isBuzzSignal,
            isNumber => isNumberSignal
        );

    AsciiGen: entity work.AsciiGenerator
        port map (
            clk => clk,
            reset => rst,
            isFizz => isFizzSignal,
            isBuzz => isBuzzSignal,
            number => counter,
            serialOut => serialOut,
            ready => ready
        );
end Behavioral;
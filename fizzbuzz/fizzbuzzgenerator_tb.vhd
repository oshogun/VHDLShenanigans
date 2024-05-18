library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FizzBuzzSystem_tb is
end FizzBuzzSystem_tb;

architecture behavior of FizzBuzzSystem_tb is
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';

    -- 50 ns period
    constant clk_period : time := 50 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.FizzBuzzSystem
        port map (
            clk => clk,
            rst => rst
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- hold reset state for 100 ns.
        wait for 100 ns;  
        rst <= '0'; 

        -- insert stimulus here 
        wait;
    end process;

end behavior;
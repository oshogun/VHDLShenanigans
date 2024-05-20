library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity testbench is
end testbench;

architecture behavior of testbench is 

    -- Component Declaration for the Unit Under Test (UUT)
    component rom_module
    port(
         clk : in  std_logic;
         ce : in  std_logic;
         addr : in  std_logic_vector(3 downto 0);
         data_out : out  std_logic_vector(7 downto 0)
        );
    end component;

   --Inputs
   signal clk : std_logic := '0';
   signal ce : std_logic := '0';
   signal addr : std_logic_vector(3 downto 0) := (others => '0');

    --Outputs
   signal data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
   uut: rom_module port map (
          clk => clk,
          ce => ce,
          addr => addr,
          data_out => data_out
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

      ce <= '1';  -- enable chip
      addr <= "0000"; -- read address 0
      wait for clk_period;
      
      addr <= "0001"; -- read address 1
      wait for clk_period;
      
      addr <= "0010"; -- read address 2
      wait for clk_period;
      
      addr <= "0011"; -- read address 3
      wait for clk_period;
      
      -- insert additional test vectors here
      
      -- done
      wait;
   end process;

end;
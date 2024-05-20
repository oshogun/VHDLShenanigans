library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC_testbench is
end PC_testbench;

architecture behavior of PC_testbench is 

    -- Component Declaration for the Unit Under Test (UUT)
    component PC
    port(
         clock : in  std_logic;
         incrementPc : in  std_logic;
         clear : in  std_logic;
         pcEnable : in  std_logic;
         addr : out  std_logic_vector(3 downto 0)
        );
    end component;

   --Inputs
   signal clock : std_logic := '0';
   signal incrementPc : std_logic := '0';
   signal clear : std_logic := '0';
   signal pcEnable : std_logic := '0';

    --Outputs
   signal addr : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
   uut: PC port map (
          clock => clock,
          incrementPc => incrementPc,
          clear => clear,
          pcEnable => pcEnable,
          addr => addr
        );

    -- Clock process definitions
   clock_process :process
   begin
        clock <= '0';
        wait for clock_period/2;
        clock <= '1';
        wait for clock_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      clear <= '1';  -- clear PC
      wait for clock_period;
      
      clear <= '0';  -- release clear
      pcEnable <= '1';  -- enable PC
      incrementPc <= '1'; -- increment PC
      wait for clock_period;
      
      incrementPc <= '0'; -- stop incrementing PC
      wait for clock_period;

      incrementPc <= '1'; -- increment PC
      wait for clock_period;
      
      incrementPc <= '0'; -- stop incrementing PC
      wait for clock_period;

      incrementPc <= '1'; -- increment PC
      wait for clock_period;
      
      incrementPc <= '0'; -- stop incrementing PC
      wait for clock_period;
      incrementPc <= '1'; -- increment PC
      wait for clock_period;
      
      incrementPc <= '0'; -- stop incrementing PC
      wait for clock_period;
      incrementPc <= '1'; -- increment PC
      wait for clock_period;
      
      incrementPc <= '0'; -- stop incrementing PC
      wait for clock_period;
      incrementPc <= '1'; -- increment PC
      wait for clock_period;
      
      incrementPc <= '0'; -- stop incrementing PC
      wait for clock_period;
      incrementPc <= '1'; -- increment PC
      wait for clock_period;
      
      incrementPc <= '0'; -- stop incrementing PC
      wait for clock_period;

      
      -- insert additional test vectors here
      
      -- done
      wait;
   end process;

end;
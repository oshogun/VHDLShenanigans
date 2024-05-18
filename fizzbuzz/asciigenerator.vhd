library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AsciiGenerator is 
    Port (
        clk: in std_logic;
        reset: in std_logic;
        isFizz: in std_logic;
        isBuzz: in std_logic;
        number: in unsigned(6 downto 0);
        serialOut: out std_logic_vector(7 downto 0);
        ready: out std_logic
    );
end entity AsciiGenerator;

architecture Behavioral of AsciiGenerator is 
    type state_type is (IDLE, FIZZ, BUZZ, FIZZBUZZ, NUMBERIN, NEWLINE);
    type fizz_state is (F, I, Z1, Z2);
    type buzz_state is (B, U, Z1, Z2);
    type fizzbuzz_state is (F, I, Z1, Z2, B, U, Z3, Z4);
    type number_state is (HUNDREDS, TENS, ONES);
    signal state: state_type;
    signal fstate: fizz_state;
    signal bstate: buzz_state;
    signal fbstate: fizzbuzz_state;
    signal nstate: number_state;
    signal ascii_char: std_logic_vector(7 downto 0);
    signal numsignal: unsigned(6 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            state <= IDLE;
            fstate <= F;
            bstate <= B;
            fbstate <= F;
            nstate <= HUNDREDS;
            ascii_char <= "00000000";
            numsignal <= (others => '0');
            ready <= '0';
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    ready <= '0';
                    if isFizz = '1' then
                        state <= FIZZ;
                    elsif isBuzz = '1' then
                        state <= BUZZ;
                    elsif isFizz = '1' and isBuzz = '1' then
                        state <= FIZZBUZZ;
                    else
                        numsignal <= number;
                        state <= NUMBERIN;
                    end if;
                when FIZZ =>
                    case fstate is
                        when F =>
                            ascii_char <= "01000110"; -- F
                            fstate <= I;
                        when I =>
                            ascii_char <= "01001001"; -- I
                            fstate <= Z1;
                        when Z1 =>
                            ascii_char <= "01011010"; -- Z
                            fstate <= Z2;
                        when Z2 =>
                            ascii_char <= "01011010"; -- Z
                            fstate <= F;
                            state <= NEWLINE;
                    end case;
                when BUZZ =>
                    case bstate is
                        when B =>
                            ascii_char <= "01000010"; -- B
                            bstate <= U;
                        when U =>
                            ascii_char <= "01010101"; -- U
                            bstate <= Z1;
                        when Z1 =>
                            ascii_char <= "01011010"; -- Z
                            bstate <= Z2;
                        when Z2 =>
                            ascii_char <= "01011010"; -- Z
                            bstate <= B;
                            state <= NEWLINE;
                    end case;
                when FIZZBUZZ =>
                    case fbstate is
                        when F =>
                            ascii_char <= "01000110"; -- F
                            fbstate <= I;
                        when I =>
                            ascii_char <= "01001001"; -- I
                            fbstate <= Z1;
                        when Z1 =>
                            ascii_char <= "01011010"; -- Z
                            fbstate <= Z2;
                        when Z2 =>
                            ascii_char <= "01011010"; -- Z
                            fbstate <= B;
                        when B =>
                            ascii_char <= "01000010"; -- B
                            fbstate <= U;
                        when U =>
                            ascii_char <= "01010101"; -- U
                            fbstate <= Z3;
                        when Z3 =>
                            ascii_char <= "01011010"; -- Z
                            fbstate <= Z4;
                        when Z4 =>
                            ascii_char <= "01011010"; -- Z
                            fbstate <= F;
                            state <= NEWLINE;
                    end case;
                when NUMBERIN => 
                    case nstate is
                        when HUNDREDS =>
                            if numsignal >= 100 then
                                ascii_char <= std_logic_vector(to_unsigned(48 + to_integer(numsignal / 100), 8)); -- ASCII for hundreds digit
                                numsignal <= numsignal mod 100;
                                nstate <= TENS;
                            else
                                nstate <= TENS;
                            end if;
                        when TENS =>
                            if numsignal >= 10 then
                                ascii_char <= std_logic_vector(to_unsigned(48 + to_integer(numsignal / 10), 8)); -- ASCII for tens digit
                                numsignal <= numsignal mod 10;
                                nstate <= ONES;
                            else
                                nstate <= ONES;
                            end if;
                        when ONES =>
                            ascii_char <= std_logic_vector(to_unsigned(48 + to_integer(numsignal), 8)); -- ASCII for ones digit
                            nstate <= HUNDREDS;
                            state <= NEWLINE;
                    end case; 
                when NEWLINE =>
                    ascii_char <= "00001010"; -- Newline
                    ready <= '1'; -- ready to receive new number
                    state <= IDLE;
            end case;
            serialOut <= ascii_char;
        end if;
    end process;
end architecture Behavioral;
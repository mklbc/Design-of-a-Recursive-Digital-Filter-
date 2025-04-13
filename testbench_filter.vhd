-- Kütüphaneleri tanımlıyoruz
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Testbench entity tanımı
entity testbench_filter is
end testbench_filter;

architecture Behavioral of testbench_filter is
    -- Testbench sinyalleri
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '0';
    signal input_sig : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal output_sig: STD_LOGIC_VECTOR(7 downto 0);

    -- Component Declaration (filter_design)
    component filter_design
        Port (
            clk       : in  STD_LOGIC;
            reset     : in  STD_LOGIC;
            input_sig : in  STD_LOGIC_VECTOR(7 downto 0);
            output_sig: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

begin
    -- Unit Under Test (UUT)
    UUT: filter_design 
        port map (
            clk        => clk,
            reset      => reset,
            input_sig  => input_sig,
            output_sig => output_sig
        );

    -- Clock Process
    process
    begin
        while true loop
            clk <= not clk;
            wait for 10 ns;  -- 50 MHz saat frekansı
        end loop;
    end process;

    -- Stimulus Process
    process
    begin
        -- Reset işlemi
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Giriş değerlerini test et
        input_sig <= "00001010"; -- 10
        wait for 20 ns;

        input_sig <= "00010100"; -- 20
        wait for 20 ns;

        input_sig <= "00111110"; -- 62
        wait for 20 ns;

        input_sig <= "00000000"; -- 0
        wait for 20 ns;

        wait;
    end process;

end Behavioral;

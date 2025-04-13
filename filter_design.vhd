-- Kütüphaneleri tanımlıyoruz
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Sayısal işlemler için gerekli kütüphane

-- Entity tanımı
entity filter_design is
    Port (
        clk       : in  STD_LOGIC;                    -- Saat sinyali
        reset     : in  STD_LOGIC;                    -- Reset sinyali
        input_sig : in  STD_LOGIC_VECTOR(7 downto 0); -- 8 bit giriş sinyali
        output_sig: out STD_LOGIC_VECTOR(7 downto 0)  -- 8 bit çıkış sinyali
    );
end filter_design;

-- Mimari tanımı
architecture Behavioral of filter_design is
    signal a, b     : UNSIGNED(7 downto 0);           -- Giriş sinyalleri
    signal result   : UNSIGNED(15 downto 0);          -- Çarpım sonucu için geniş veri yolu
begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- Reset durumunda sıfırlama
            a <= (others => '0');
            b <= (others => '0');
            result <= (others => '0');
            output_sig <= (others => '0');
        elsif rising_edge(clk) then
            -- Giriş sinyalini UNSIGNED türüne dönüştür
            a <= UNSIGNED(input_sig);
            b <= to_unsigned(2, 8); -- Katsayı: 2'yi açıkça 8 bit UNSIGNED yap

            -- Filtreleme işlemi: a * b
            result <= a * b;

            -- Çıkışı 8 bite indirip output_sig'e ata
            output_sig <= STD_LOGIC_VECTOR(result(15 downto 8));
        end if;
    end process;

end Behavioral;

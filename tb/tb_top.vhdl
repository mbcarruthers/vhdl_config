library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std;

entity tb_top is
end entity;

architecture rtl of tb_top is
   signal set, reset, Q : std_logic := '0';
begin
   uut : entity work.top
      Port map(
         set   => set,
         reset => reset,
         Q     => Q
      );
   process                              
   begin
      report "VHDL working"; 
      wait for 25 ns; 
      for i in 0 to 7 loop
         set   <= '1';
         reset <= '0';
         wait for 10 ns;
         set   <= '1';
         reset <= '1';
         wait for 10 ns;
         set   <= '0';
         reset <= '1';
         wait for 10 ns;
         set   <= '0';
         reset <= '0';
         wait for 10 ns;
      end loop;
      wait;
   end process;
end architecture;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std;

entity top is
    Port(
        set   : in  std_logic;
        reset : in  std_logic;
        Q     : out std_logic
    );
end entity;

architecture rtl of top  is
begin
    Q <= set or not(reset or not Q); 
end architecture;

 

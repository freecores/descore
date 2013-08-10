----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:30:59 02/20/2013 
-- Design Name: 
-- Module Name:    des - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity des_loop is
	port(clk :  in std_logic;
		  rst : in std_logic;
		  mode : in std_logic; -- 0 encrypt, 1 decrypt
		  key_in : in std_logic_vector(63 downto 0);
		  blk_in : in std_logic_vector(63 downto 0);
		  blk_out : out std_logic_vector(63 downto 0));
end des_loop;

architecture Behavioral of des_loop is

	signal after_ip_s : std_logic_vector(63 downto 0);
	signal after_ip_minus_one_s : std_logic_vector(63 downto 0);
	signal after_f_s : std_logic_vector(31 downto 0);
	signal final_s : std_logic_vector(63 downto 0);

	component des_round is
		port(clk : in std_logic;
			  l_0 : in std_logic_vector(31 downto 0);
		     r_0 : in std_logic_vector(31 downto 0);
		     k_i : in std_logic_vector(47 downto 0);
		     l_1 : out std_logic_vector(31 downto 0);
		     r_1 : out std_logic_vector(31 downto 0));
	end component;

	component key_schedule is
		port(clk : in std_logic;
			  rst : in std_logic;
		     mode : in std_logic; -- 0 encrypt, 1 decrypt
	        key : in std_logic_vector(63 downto 0);
		     key_out : out std_logic_vector(47 downto 0));
	end component;

	signal key_s : std_logic_vector(47 downto 0);

	signal l_0_s : std_logic_vector(31 downto 0);
	signal l_1_s : std_logic_vector(31 downto 0);
	signal l_2_s : std_logic_vector(31 downto 0);
	signal l_3_s : std_logic_vector(31 downto 0);
	signal l_4_s : std_logic_vector(31 downto 0);
	signal l_5_s : std_logic_vector(31 downto 0);
	signal l_6_s : std_logic_vector(31 downto 0);
	signal l_7_s : std_logic_vector(31 downto 0);
	signal l_8_s : std_logic_vector(31 downto 0);
	signal l_9_s : std_logic_vector(31 downto 0);
	signal l_10_s : std_logic_vector(31 downto 0);
	signal l_11_s : std_logic_vector(31 downto 0);
	signal l_12_s : std_logic_vector(31 downto 0);
	signal l_13_s : std_logic_vector(31 downto 0);
	signal l_14_s : std_logic_vector(31 downto 0);
	signal l_15_s : std_logic_vector(31 downto 0);
	signal l_16_s : std_logic_vector(31 downto 0);

	signal r_0_s : std_logic_vector(31 downto 0);
	signal r_1_s : std_logic_vector(31 downto 0);
	signal r_2_s : std_logic_vector(31 downto 0);
	signal r_3_s : std_logic_vector(31 downto 0);
	signal r_4_s : std_logic_vector(31 downto 0);
	signal r_5_s : std_logic_vector(31 downto 0);
	signal r_6_s : std_logic_vector(31 downto 0);
	signal r_7_s : std_logic_vector(31 downto 0);
	signal r_8_s : std_logic_vector(31 downto 0);
	signal r_9_s : std_logic_vector(31 downto 0);
	signal r_10_s : std_logic_vector(31 downto 0);
	signal r_11_s : std_logic_vector(31 downto 0);
	signal r_12_s : std_logic_vector(31 downto 0);
	signal r_13_s : std_logic_vector(31 downto 0);
	signal r_14_s : std_logic_vector(31 downto 0);
	signal r_15_s : std_logic_vector(31 downto 0);
	signal r_16_s : std_logic_vector(31 downto 0);
	
	signal k_0_s : std_logic_vector(47 downto 0);
	signal k_1_s : std_logic_vector(47 downto 0);
	signal k_2_s : std_logic_vector(47 downto 0);
	signal k_3_s : std_logic_vector(47 downto 0);
	signal k_4_s : std_logic_vector(47 downto 0);
	signal k_5_s : std_logic_vector(47 downto 0);
	signal k_6_s : std_logic_vector(47 downto 0);
	signal k_7_s : std_logic_vector(47 downto 0);
	signal k_8_s : std_logic_vector(47 downto 0);
	signal k_9_s : std_logic_vector(47 downto 0);
	signal k_10_s : std_logic_vector(47 downto 0);
	signal k_11_s : std_logic_vector(47 downto 0);
	signal k_12_s : std_logic_vector(47 downto 0);
	signal k_13_s : std_logic_vector(47 downto 0);
	signal k_14_s : std_logic_vector(47 downto 0);
	signal k_15_s : std_logic_vector(47 downto 0);
	
	signal rst_s : std_logic;
	
begin

	pr_rst_delay : process(clk, rst)
	begin
		if rising_edge(clk) then
			rst_s <= rst;
		end if;
	end process;

--	k_0_s <= "101000001001001011000010000010101011000101000000";
--	k_1_s <= "101000000001001001010010010011000000000010101011";
--	k_2_s <= "001001000101101001010000000001100101100001001001";
--	k_3_s <= "000001100111000101010000000000101001000101110000";
--	k_4_s	<= "000011100100010101010001100000011000110100100000";
--	k_5_s <= "010011110100000100001001010010000000111000010000";
--	k_6_s <= "000010111000000110001001010110010100000000011100";
--	k_7_s <= "000110010000100010001011000000010101000010001000";
--	k_8_s <= "000110010000101010001000000110000010111010010000";
--	k_9_s <= "000100000011100010001100001110010100000000010001";
--	k_10_s <= "000100000010110001000100000000110110000000000010";
--	k_11_s <= "010000000110110000100100101001000010000100000100";
--	k_12_s <= "110000001010010100100100101000000000001011000110";
--	k_13_s <= "110000001000011000100011010101001000001010000011";
--	k_14_s <= "111000011001001000100010000101100000010001001001";
--	k_15_s <= "101000001001001000101010011000000001010010000110";
	
	-- IP

	pr_seq: process(clk, rst_s, blk_in)
	begin
		if rst_s = '1' then
			l_0_s <= blk_in(6) & blk_in(14) & blk_in(22) & blk_in(30) & blk_in(38) & blk_in(46) & blk_in(54)  & blk_in(62) &
							  blk_in(4) & blk_in(12) & blk_in(20) & blk_in(28) & blk_in(36) & blk_in(44) & blk_in(52)  & blk_in(60) &
							  blk_in(2) & blk_in(10) & blk_in(18) & blk_in(26) & blk_in(34) & blk_in(42) & blk_in(50)  & blk_in(58) &
							  blk_in(0) & blk_in(8)  & blk_in(16) & blk_in(24) & blk_in(32) & blk_in(40) & blk_in(48)  & blk_in(56);
							  
			r_0_s <= blk_in(7) & blk_in(15) & blk_in(23) & blk_in(31) & blk_in(39) & blk_in(47) & blk_in(55)  & blk_in(63) &
							  blk_in(5) & blk_in(13) & blk_in(21) & blk_in(29) & blk_in(37) & blk_in(45) & blk_in(53)  & blk_in(61) &
							  blk_in(3) & blk_in(11) & blk_in(19) & blk_in(27) & blk_in(35) & blk_in(43) & blk_in(51)  & blk_in(59) &
							  blk_in(1) & blk_in(9)  & blk_in(17) & blk_in(25) & blk_in(33) & blk_in(41) & blk_in(49)  & blk_in(57);		
		elsif rising_edge(clk) then
			l_0_s <= l_1_s;
			r_0_s <= r_1_s;
		end if;
	end process;

	DES_ROUND_0 :  des_round port map (clk, l_0_s, r_0_s, k_0_s, l_1_s, r_1_s);

	final_s <= r_1_s & l_1_s;

	blk_out  <=   final_s(24) & final_s(56) & final_s(16) & final_s(48) & final_s(8) & final_s(40) & final_s(0)  & final_s(32) &
					  final_s(25) & final_s(57) & final_s(17) & final_s(49) & final_s(9) & final_s(41) & final_s(1) & final_s(33) &
					  final_s(26) & final_s(58) & final_s(18) & final_s(50) & final_s(10) & final_s(42) & final_s(2) & final_s(34) &
					  final_s(27) & final_s(59) & final_s(19) & final_s(51) & final_s(11) & final_s(43) & final_s(3) & final_s(35) &
					  final_s(28) & final_s(60) & final_s(20) & final_s(52) & final_s(12) & final_s(44) & final_s(4)  & final_s(36) &
					  final_s(29) & final_s(61) & final_s(21) & final_s(53) & final_s(13) & final_s(45) & final_s(5) & final_s(37) &
					  final_s(30) & final_s(62) & final_s(22) & final_s(54) & final_s(14) & final_s(46) & final_s(6) & final_s(38) &
					  final_s(31) & final_s(63) & final_s(23) & final_s(55) & final_s(15) & final_s(47) & final_s(7) & final_s(39);

	KEY_SCHEDULE_0 : key_schedule port map (clk, rst, mode, key_in, k_0_s);

end Behavioral;


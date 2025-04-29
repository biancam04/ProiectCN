library verilog;
use verilog.vl_types.all;
entity shift_reg_lr is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        mode            : in     vl_logic_vector(1 downto 0);
        data_in         : in     vl_logic_vector(7 downto 0);
        shift_in_left   : in     vl_logic;
        shift_in_right  : in     vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0)
    );
end shift_reg_lr;

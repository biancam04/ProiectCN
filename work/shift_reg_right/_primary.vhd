library verilog;
use verilog.vl_types.all;
entity shift_reg_right is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        shift_en        : in     vl_logic;
        shift_in        : in     vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0)
    );
end shift_reg_right;

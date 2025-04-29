library verilog;
use verilog.vl_types.all;
entity shift_bit is
    port(
        clk             : in     vl_logic;
        load            : in     vl_logic;
        d_in            : in     vl_logic;
        shift_en        : in     vl_logic;
        shift_in        : in     vl_logic;
        d_out           : out    vl_logic
    );
end shift_bit;

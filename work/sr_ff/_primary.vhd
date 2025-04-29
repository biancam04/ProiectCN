library verilog;
use verilog.vl_types.all;
entity sr_ff is
    port(
        S               : in     vl_logic;
        R               : in     vl_logic;
        clk             : in     vl_logic;
        Q               : out    vl_logic
    );
end sr_ff;

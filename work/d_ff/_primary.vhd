library verilog;
use verilog.vl_types.all;
entity d_ff is
    port(
        clk             : in     vl_logic;
        d               : in     vl_logic;
        en              : in     vl_logic;
        rst             : in     vl_logic;
        o               : out    vl_logic
    );
end d_ff;

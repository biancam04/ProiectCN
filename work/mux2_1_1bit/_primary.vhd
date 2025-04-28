library verilog;
use verilog.vl_types.all;
entity mux2_1_1bit is
    port(
        d0              : in     vl_logic;
        d1              : in     vl_logic;
        sel             : in     vl_logic;
        y               : out    vl_logic
    );
end mux2_1_1bit;

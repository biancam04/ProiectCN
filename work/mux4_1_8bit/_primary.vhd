library verilog;
use verilog.vl_types.all;
entity mux4_1_8bit is
    port(
        d0              : in     vl_logic_vector(7 downto 0);
        d1              : in     vl_logic_vector(7 downto 0);
        d2              : in     vl_logic_vector(7 downto 0);
        d3              : in     vl_logic_vector(7 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        y               : out    vl_logic_vector(7 downto 0)
    );
end mux4_1_8bit;

library verilog;
use verilog.vl_types.all;
entity restoring_divider_datapath is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load            : in     vl_logic;
        dividend        : in     vl_logic_vector(7 downto 0);
        divisor         : in     vl_logic_vector(7 downto 0);
        quotient        : out    vl_logic_vector(7 downto 0);
        remainder       : out    vl_logic_vector(7 downto 0);
        done            : out    vl_logic
    );
end restoring_divider_datapath;

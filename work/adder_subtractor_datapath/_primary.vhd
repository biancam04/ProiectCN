library verilog;
use verilog.vl_types.all;
entity adder_subtractor_datapath is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        load            : in     vl_logic;
        inbus_a         : in     vl_logic_vector(7 downto 0);
        inbus_b         : in     vl_logic_vector(7 downto 0);
        sub             : in     vl_logic;
        outbus          : out    vl_logic_vector(7 downto 0)
    );
end adder_subtractor_datapath;

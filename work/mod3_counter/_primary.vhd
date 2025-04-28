library verilog;
use verilog.vl_types.all;
entity mod3_counter is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        begin_op        : in     vl_logic;
        state           : out    vl_logic_vector(2 downto 0)
    );
end mod3_counter;

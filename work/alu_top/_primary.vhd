library verilog;
use verilog.vl_types.all;
entity alu_top is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        opcode          : in     vl_logic_vector(1 downto 0);
        inbus_a         : in     vl_logic_vector(7 downto 0);
        inbus_b         : in     vl_logic_vector(7 downto 0);
        outbus          : out    vl_logic_vector(7 downto 0);
        done            : out    vl_logic
    );
end alu_top;

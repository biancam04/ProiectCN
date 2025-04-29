library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        op_codes        : in     vl_logic_vector(1 downto 0);
        valid           : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        o               : out    vl_logic_vector(7 downto 0);
        ready           : out    vl_logic
    );
end alu;

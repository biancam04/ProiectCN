library verilog;
use verilog.vl_types.all;
entity control_unit is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        start           : in     vl_logic;
        opcode          : in     vl_logic_vector(1 downto 0);
        Q0              : in     vl_logic;
        Q_1             : in     vl_logic;
        A7              : in     vl_logic;
        count           : in     vl_logic_vector(2 downto 0);
        control         : out    vl_logic_vector(10 downto 0);
        done            : out    vl_logic
    );
end control_unit;

library verilog;
use verilog.vl_types.all;
entity adder is
    port(
        x               : in     vl_logic_vector(7 downto 0);
        y               : in     vl_logic_vector(7 downto 0);
        ci              : in     vl_logic;
        en              : in     vl_logic;
        o               : out    vl_logic_vector(7 downto 0)
    );
end adder;

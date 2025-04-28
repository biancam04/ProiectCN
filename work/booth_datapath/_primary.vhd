library verilog;
use verilog.vl_types.all;
entity booth_datapath is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        inbus           : in     vl_logic_vector(7 downto 0);
        control         : in     vl_logic_vector(10 downto 0);
        outbus          : out    vl_logic_vector(7 downto 0);
        q0              : out    vl_logic;
        q_1             : out    vl_logic;
        count           : out    vl_logic_vector(2 downto 0)
    );
end booth_datapath;

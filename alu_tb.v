module alu_tb;

    // Testbench signals
    reg [15:0] in;             // 16-bit packed input: {A, B}
    reg [1:0] op_codes;
    reg valid;
    reg clk;
    reg rst;
    wire [7:0] o;
    wire ready;

    // Extract operands for display
    wire [7:0] in_a = in[15:8];
    wire [7:0] in_b = in[7:0];

    // Instantiate the DUT (Device Under Test)
    alu uut (
        .in(in),
        .op_codes(op_codes),
        .valid(valid),
        .clk(clk),
        .rst(rst),
        .o(o),
        .ready(ready)
    );

    // Clock generation: 10ns period
    always #5 clk = ~clk;

    initial begin
        $display("Starting ALU Testbench...");
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);

        // Initialize
        clk = 0;
        rst = 1;
        valid = 0;
        in = 16'd0;
        op_codes = 2'b00;

        // Reset pulse
        #10; rst = 0; #10;

        // === Test 1: ADD ===
        in = {8'd25, 8'd17}; // A = 25, B = 17
        op_codes = 2'b00;
        valid = 1;
        #10; valid = 0;
        wait (ready);
        $display("ADD: A = %d, B = %d ? Result = %d", in_a, in_b, o);
        #20;

        // === Test 2: SUB ===
        in = {8'd40, 8'd15};
        op_codes = 2'b01;
        valid = 1;
        #10; valid = 0;
        wait (ready);
        $display("SUB: A = %d, B = %d ? Result = %d", in_a, in_b, o);
        #20;

        // === Test 3: MUL ===
        in = {8'd5, 8'd3};
        op_codes = 2'b10;
        valid = 1;
        #10; valid = 0;
        wait (ready);
        $display("MUL: A = %d, B = %d ? Result = %d", in_a, in_b, o);
        #20;

        // === Test 4: DIV ===
        in = {8'd20, 8'd4};
        op_codes = 2'b11;
        valid = 1;
        #10; valid = 0;
        wait (ready);
        $display("DIV: A = %d, B = %d ? Result = %d", in_a, in_b, o);
        #20;

        $display("ALU test complete.");
        $finish;
    end

endmodule


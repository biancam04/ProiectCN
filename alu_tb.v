module alu_tb;

    // Testbench signals
    reg [7:0] in;
    reg [1:0] op_codes;
    reg valid;
    reg clk;
    reg rst;
    wire [7:0] o;
    wire ready;

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

    // Clock generation: 10ns period (100 MHz)
    always #5 clk = ~clk;

    initial begin
        $display("Starting ALU Testbench...");
        $dumpfile("alu_tb.vcd"); // optional if you use GTKWave
        $dumpvars(0, alu_tb);

        // Initialize signals
        clk = 0;
        rst = 1;
        valid = 0;
        in = 8'd0;
        op_codes = 2'b00; // ADD

        // Reset pulse
        #10;
        rst = 0;
        #10;

        // === Test 1: ADD ===
        in = 8'd5;         // load multiplicand (for future use)
        op_codes = 2'b00;  // opcode 00 = add
        valid = 1;
        #10;
        valid = 0;

        wait (ready);
        $display("ADD result: %d", o);

        #20;

        // === Test 2: SUB ===
        in = 8'd10;
        op_codes = 2'b01;  // opcode 01 = sub
        valid = 1;
        #10;
        valid = 0;

        wait (ready);
        $display("SUB result: %d", o);

        #20;

        // === Test 3: MUL ===
        in = 8'd3;
        op_codes = 2'b10;  // opcode 10 = mul
        valid = 1;
        #10;
        valid = 0;

        wait (ready);
        $display("MUL result: %d", o);

        #20;

        // === Test 4: DIV ===
        in = 8'd15;
        op_codes = 2'b11;  // opcode 11 = div
        valid = 1;
        #10;
        valid = 0;

        wait (ready);
        $display("DIV result: %d", o);

    end

endmodule


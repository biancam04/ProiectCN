module alu_top_tb;

    // Inputs
    reg clk;
    reg reset;
    reg start;
    reg [1:0] opcode;
    reg [7:0] inbus_a;
    reg [7:0] inbus_b;

    // Outputs
    wire [7:0] outbus;
    wire done;

    // Instantiate the ALU Top
    alu_top uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .opcode(opcode),
        .inbus_a(inbus_a),
        .inbus_b(inbus_b),
        .outbus(outbus),
        .done(done)
    );

    // Clock generation: 10ns period (100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        start = 0;
        opcode = 2'b00;
        inbus_a = 8'd0;
        inbus_b = 8'd0;
        
        // Hold reset for a while
        #20;
        reset = 0;

        // === Test 1: ADD ===
        #10;
        opcode = 2'b00;    // ADD
        inbus_a = 8'd15;   // 15
        inbus_b = 8'd10;   // +10
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("ADD Test: 15 + 10 = %d (outbus=%d)", 15+10, outbus);

        // === Test 2: SUB ===
        #50;
        opcode = 2'b01;    // SUB
        inbus_a = 8'd20;   // 20
        inbus_b = 8'd8;    // -8
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("SUB Test: 20 - 8 = %d (outbus=%d)", 20-8, outbus);

        // === Test 3: MUL ===
        #50;
        opcode = 2'b10;    // MUL
        inbus_a = 8'd5;    // 5
        inbus_b = 8'd6;    // x6
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("MUL Test: 5 * 6 = %d (outbus=%d)", 5*6, outbus);

        // === Test 4: DIV ===
        #50;
        opcode = 2'b11;    // DIV
        inbus_a = 8'd25;   // 25
        inbus_b = 8'd5;    // ÷5
        start = 1;
        #10;
        start = 0;
        wait(done);
        $display("DIV Test: 25 / 5 = %d (outbus=%d)", 25/5, outbus);

        // Finish simulation
        #100;
        $finish;
    end

endmodule

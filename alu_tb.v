`timescale 1ns/1ps

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

    // Instantiate ALU Top
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

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 100MHz clock, period 10ns
    end

    // Stimulus
    initial begin
        // Initial values
        reset = 1;
        start = 0;
        opcode = 2'b00;
        inbus_a = 8'd0;
        inbus_b = 8'd0;

        // Hold reset
        #10;
        reset = 0;
        #10;

        // ====================
        // TEST 1: ADDITION
        // 15 + 10 = 25
        // ====================
        inbus_a = 8'd15;
        inbus_b = 8'd10;
        opcode = 2'b00;  // ADD
        #10 start_pulse();
        wait (done);
        #10;

        // ====================
        // TEST 2: SUBTRACTION
        // 25 - 10 = 15
        // ====================
        inbus_a = 8'd25;
        inbus_b = 8'd10;
        opcode = 2'b01;  // SUB
        #10 start_pulse();
        wait (done);
        #10;

        // ====================
        // TEST 3: MULTIPLICATION
        // 5 * 6 = 30
        // ====================
        inbus_a = 8'd0;  // Booth uses only inbus_b
        inbus_b = 8'd6;  // Multiplier
        opcode = 2'b10;  // MUL
        #10 start_pulse();
        wait (done);
        #10;

        // ====================
        // TEST 4: DIVISION
        // 30 / 5 = 6
        // ====================
        inbus_a = 8'd30;  // Dividend
        inbus_b = 8'd5;   // Divisor
        opcode = 2'b11;  // DIV
        #10 start_pulse();
        wait (done);
        #10;

        // End simulation
        $stop;
    end

    // Start pulse procedure
    task start_pulse;
    begin
        start = 1;
        #10;
        start = 0;
    end
    endtask

endmodule




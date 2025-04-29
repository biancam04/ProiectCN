module alu_top (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [1:0] opcode,     // 00: add, 01: sub, 10: mul, 11: div
    input wire [7:0] inbus_a,     // Operand A
    input wire [7:0] inbus_b,     // Operand B
    output wire [7:0] outbus,     // ALU result output
    output wire done              // Operation finished flag
);

    // Internal wires
    wire [10:0] control;
    wire [7:0] addsub_out;
    wire [15:0] booth_out;
    wire [7:0] div_quotient;
    wire [7:0] div_remainder;
    wire [7:0] alu_out_mux;
    wire booth_done;
    wire CU_done;

    wire booth_Q0, booth_Q_1;
    wire booth_count;
    wire div_count;
    wire [7:0] div_A; // For A7
    wire div_A7;
    
    // Select count signal depending on operation
    wire count_mux;
    assign count_mux = (opcode == 2'b10) ? booth_count : div_count;
    // Select A7 signal (only needed for division)
    assign div_A7 = div_A[7];

    // Control Unit instantiation
    control_unit CU (
        .clk(clk),
        .reset(reset),
        .start(start),
        .opcode(opcode),
        .Q0(booth_Q0),
        .Q_1(booth_Q_1),
        .A7(div_A7),
        .count(count_mux),
        .control(control),
        .done(CU_done)
    );

    // Adder/Subtractor Datapath instantiation
    adder_subtractor_datapath ADD_SUB (
        .clk(clk),
        .reset(reset),
        .load(control[0]),
        .inbus_a(inbus_a),
        .inbus_b(inbus_b),
        .sub(opcode[0]),
        .outbus(addsub_out)
    );

    // Booth Multiplier Datapath instantiation
    booth_datapath BOOTH (
        .clk(clk),
        .reset(reset),
        .start(start),
        .multiplicand(inbus_b),
        .multiplier(inbus_a),
        .product(booth_out),
        .done(booth_done),
        .count(booth_count),
        .Q0(booth_Q0),
        .Q_1(booth_Q_1)
    );

    // Restoring Divider Datapath instantiation
    restoring_divider_datapath DIVIDER (
        .clk(clk),
        .reset(reset),
        .load(control[0]),
        .dividend(inbus_a),
        .divisor(inbus_b),
        .quotient(div_quotient),
        .remainder(div_remainder),
        .done(), // divider done not needed separately
        .count(div_count),
        .A(div_A) // New output A (to get A[7] for A7)
    );

    // Output MUX
    mux4_1_8bit OUTMUX (
        .d0(addsub_out),
        .d1(addsub_out),
        .d2(booth_out[7:0]),
        .d3(div_quotient),
        .sel(opcode),
        .y(alu_out_mux)
    );

    assign outbus = alu_out_mux;

    // Select proper done flag depending on operation
    assign done = (opcode == 2'b10) ? booth_done : CU_done;

endmodule

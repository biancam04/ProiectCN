// Top-level ALU module (Updated)
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

    // Control Unit instantiation
    control_unit CU (
        .clk(clk),
        .reset(reset),
        .start(start),
        .opcode(opcode),
        .Q0(1'b0),     // No longer used
        .Q_1(1'b0),    // No longer used
        .A7(1'b0),     // No longer used
        .count(3'b000),
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
        .done(booth_done)
    );

    // Restoring Divider Datapath instantiation
    restoring_divider_datapath DIVIDER (
        .clk(clk),
        .reset(reset),
        .load(control[0]),
        .dividend(inbus_a),
        .divisor(inbus_b),
        .quotient(div_quotient),
        .remainder(div_remainder)
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

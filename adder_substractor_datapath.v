module adder_subtractor_datapath (
    input wire clk,
    input wire reset,
    input wire load,
    input wire [7:0] inbus_a,
    input wire [7:0] inbus_b,
    input wire sub,
    output wire [7:0] outbus
);
    wire [7:0] operand_b;
    wire [7:0] sum;

    assign operand_b = sub ? (~inbus_b + 1) : inbus_b;

    adder_8bit adder (
        .a(inbus_a),
        .b(operand_b),
        .sum(sum)
    );

    register_8bit reg_out (
        .clk(clk),
        .reset(reset),
        .load(load),
        .d(sum),
        .q(outbus)
    );
endmodule
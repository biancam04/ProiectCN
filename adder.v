module adder (
    input  wire [7:0] x,    // First operand
    input  wire [7:0] y,    // Second operand
    input  wire       ci,   // Carry-in
    input  wire       en,   // Enable signal
    output reg  [7:0] o    // Sum output
);

    wire [7:0] sum_wire;
    wire [7:0] carry;

    // Instantiate full adders
    full_adder FA0 (.a(x[0]), .b(y[0]), .cin(ci),         .sum(sum_wire[0]), .cout(carry[0]));
    full_adder FA1 (.a(x[1]), .b(y[1]), .cin(carry[0]),   .sum(sum_wire[1]), .cout(carry[1]));
    full_adder FA2 (.a(x[2]), .b(y[2]), .cin(carry[1]),   .sum(sum_wire[2]), .cout(carry[2]));
    full_adder FA3 (.a(x[3]), .b(y[3]), .cin(carry[2]),   .sum(sum_wire[3]), .cout(carry[3]));
    full_adder FA4 (.a(x[4]), .b(y[4]), .cin(carry[3]),   .sum(sum_wire[4]), .cout(carry[4]));
    full_adder FA5 (.a(x[5]), .b(y[5]), .cin(carry[4]),   .sum(sum_wire[5]), .cout(carry[5]));
    full_adder FA6 (.a(x[6]), .b(y[6]), .cin(carry[5]),   .sum(sum_wire[6]), .cout(carry[6]));
    full_adder FA7 (.a(x[7]), .b(y[7]), .cin(carry[6]),   .sum(sum_wire[7]), .cout(carry[7]));

    // Conditional update
    always @(*) begin
        if (en) begin
            o  = sum_wire;
        end
    end

endmodule

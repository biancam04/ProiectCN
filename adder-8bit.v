module adder_8bit (
    input wire [7:0] a,
    input wire [7:0] b,
    output wire [7:0] sum
);
    assign sum = a + b;
endmodule
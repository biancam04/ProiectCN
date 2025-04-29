module d_ff (
    input wire clk,
    input wire d,
    input wire en,
    input wire rst,
    output reg o
);
    always @(posedge clk) begin
        if (rst)
            o <= 1'b0;
        else if (en)
            o <= d;
    end
endmodule

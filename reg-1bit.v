 module register_1bit (
    input wire clk,
    input wire reset,
    input wire load,
    input wire d,
    output reg q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else if (load)
            q <= d;
    end
endmodule

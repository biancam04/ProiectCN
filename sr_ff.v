module sr_ff (
    input wire S,    // Set
    input wire R,    // Reset
    input wire clk,
    output reg Q
);
    always @(posedge clk) begin
        if (R)
            Q <= 0;
        else if (S)
            Q <= 1;
    end
endmodule


module counter (
    input  wire clk,     
    input  wire rst,   
    input  wire en,      
    output reg  [2:0] o 
);

    always @(posedge clk) begin
        if (rst)
            o <= 3'b000;
        else if (en)
            o <= o + 1;
    end

endmodule

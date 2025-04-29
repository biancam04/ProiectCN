module sr_ff (
    input wire S,    
    input wire R,    
    input wire clk,
  	input wire rst,
    output reg Q
);
  always @(posedge clk or posedge rst) begin
     	 if (R | rst)
            Q <= 0;
        else if (S)
            Q <= 1;
    end
endmodule


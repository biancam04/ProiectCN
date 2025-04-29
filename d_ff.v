module d_ff (
    input wire clk,
    input wire d,
    input wire en,
    input wire rst,
    output o
);
  	reg data;
  always @(posedge clk) begin
      if (rst)
            data <= 1'b0;
        else if (en)
            data <= d;
    end
  	assign o=data;
endmodule

module shift_register (
  input [7 : 0] parallelIn,
  input serialIn,
  input lshift,
  input rshift,
  input load,
  input rst,
  input en,
  input clk,
  output reg serialOut,
  output reg [7 : 0] parallelOut,
);
  
  wire [7 : 0] outFlipFlop;
  
  genvar i;
  
  generate
    
    for(i = 0;i < 8;i = i + 1) begin : FlipFlop
      wire d = (load) ? parallelIn[i] : 
      (rshift & ~lshift) ? ((i == 7) ? serialIn : outFlipFlop[i + 1]) : //Rshift
      (lshift & ~rshift) ? ((i == 0) ? serialIn : outFlipFlop[i - 1]) : //Lshit	  
      outFlipFlop[i]; 
      
      d_ff FFD(.clk(clk), .rst(rst), .en(en), .d(d), .o(outFlipFlop[i]));
      
    end
    
  endgenerate
  
  assign serialOut = (lshift) ? outFlipFlop[7] : ((rshift) ? outFlipFlop[0] : 0);
  assign parallelOut = outFlipFlop;
  
endmodule

  
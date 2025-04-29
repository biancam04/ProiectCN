module complement(
  input [7 : 0] in,
  input en,
  output reg [7 : 0] out
);

  assign out = en ? ~in : in;
 
endmodule


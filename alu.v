module alu (
  input wire [15:0] in,
  input wire [1:0] op_codes,
  input wire valid,
  input wire clk,
  input wire rst,
  output reg [7:0] o,
  output wire ready
);

  wire [7:0] in_a, in_b;
  
  assign in_a=in[15:8];
  assign in_b=in[7:0];
  
  wire [10:0] c;

  wire [7:0] q, m, a;
  wire [7:0] outAdder, complementedM;
  wire [7:0] muxAdderIn, muxQInput, muxAInput, inputQ;
  wire muxQ_1, muxASerialIn, muxQSerialIn;

  wire q_1_out;
  wire [2:0] count;
  wire aSerialOut, qSerialOut;

  // Q[-1] 
  d_ff Q_minus_one_ff (
    .clk(clk),
    .d(muxQ_1),
    .en(c[2] | c[6]),
    .rst(rst),
    .o(q_1_out)
  );

 	// A register
	shift_register reg_A (
    .clk(clk),
      .rst(rst | c[0]),
    .en(c[3] | c[6] | c[7] ),           
    .load(c[3] ),                       
    .lshift(c[7]),                            
    .rshift(c[6]),                            
    .serialIn(q[0]),                          
    .parallelIn(outAdder),                   
    .serialOut(aSerialOut),
    .parallelOut(a)
	);
  
  mux2_1_8bit muxsum (.d0(in_a), .d1(outAdder), .sel(c[4]), .y(inputQ));

	// Q register
	shift_register reg_Q (
    .clk(clk),
    .rst(rst),
    .en(valid | c[4] | c[6]),                 
    .load(valid | c[4]),                      
    .lshift(1'b0),                           
    .rshift(c[6]),                            
    .serialIn(a[0]),                          
    .parallelIn(inputQ),                      
    .serialOut(qSerialOut),
    .parallelOut(q)
	);

	// M register
	shift_register reg_M (
    .clk(clk),
    .rst(rst),
    .en(c[1]),                                
    .load(c[1]),
    .lshift(1'b0),
    .rshift(1'b0),
    .serialIn(1'b0),
    .parallelIn(in_b),
    .serialOut(),                             
    .parallelOut(m)
	);


  // Complement M
  complement complementM(
    .in(m),
    .en(c[5]),
    .out(complementedM)
  );

  // Muxes
  mux2_1_8bit mux_adder_in (
    .d0(a), .d1(q), .sel(c[4]), .y(muxAdderIn)
  );


  mux2_1_8bit mux_q_input (
    .d0(in),
    .d1(outAdder),
    .sel(c[4]),
    .y(muxQInput)
  );

  mux2_1_8bit mux_a_input (
    .d0(8'd0),
    .d1(outAdder),
    .sel(c[3]),
    .y(muxAInput)
  );

  mux2_1_1bit mux_q_minus_one (
    .d0(1'b0),
    .d1(qSerialOut),
    .sel(c[6]),
    .y(muxQ_1)
  );

  
  mux2_1_1bit mux_serial_a (
    .d0(a[7]),
    .d1(qSerialOut),
    .sel(c[7]),
    .y(muxASerialIn)
  );

  mux2_1_1bit mux_serial_q (
    .d0(1'b0),
    .d1(aSerialOut),
    .sel(c[6]),
    .y(muxQSerialIn)
  );

  // Parallel Adder
  adder ALU_Adder (
    .x(muxAdderIn),
    .y(complementedM),
    .ci(c[5]),
    .en(c[3]|c[4]),
    .o(outAdder)
  );

  // Counter
  counter Count (
    .clk(clk),
    .rst(c[0]),
    .en(c[8]),
    .o(count)
  );

  // Control Unit
  control_unit Control (
    .clk(clk),
    .reset(rst),
    .start(valid),
    .Q0(q[0]),
    .Q_1(q_1_out),
    .A7(a[7]),
    .count((count[0]&count[1]&count[2])),
    .opcode(op_codes),
    .control(c),
    .done(ready)
  );

  // Output
  always @(*) begin
    if (c[10])
      o = q;
    else if(c[9])
      o = a;
  end


endmodule


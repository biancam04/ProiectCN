module control_unit (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [1:0] opcode,  
    input wire Q0,            
    input wire Q_1,           
    input wire A7,            
    input wire count,   
    output wire [10:0] control, 
    output wire done          
);

    wire [3:0] state;
    mod4_counter sequence_counter (
    .clk(clk),
    .reset(reset),
    .begin_op(start),
    .state(state)
    );

    wire theta0, theta1, theta2, theta3;
    assign theta0 = state[0];
    assign theta1 = state[1];
    assign theta2 = state[2];
    assign theta3 = state[3];

    wire q0, q1, q2;
    
    wire setter;
    
  sr_ff ff_q0 (.clk(clk), .rst(reset), .S(start), .R(theta3&q0), .Q(q0));
    mux4_1_1bit mux_sr (.d0(theta3&q1), .d1(theta3&q1) , .d2((theta3&q1)&count), .d3(theta3&q1), .sel(opcode), .y(setter));
  sr_ff ff_q1 (.clk(clk), .rst(reset), .S(theta3&q0), .R(setter), .Q(q1));
  sr_ff ff_q2 (.clk(clk), .rst(reset), .S(setter), .R(done), .Q(q2));

    // Control signals
    wire C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10;

    assign C0=theta0&q0;
    assign C1=theta1&q0;

    mux4_1_1bit mux_C2 (.d0(1'b0),   .d1(1'b0),   .d2(theta0&q0), .d3(1'b0),   .sel(opcode), .y(C2));
  mux4_1_1bit mux_C3 (.d0(1'b0),   .d1(1'b0),   .d2(theta0&q1&(((~Q0)&Q_1)|(Q0&(~Q_1)))),   .d3(theta1&q1&A7), .sel(opcode), .y(C3));
    mux4_1_1bit mux_C4 (.d0(q1&theta0), .d1(theta0&q1), .d2(1'b0), .d3(1'b0), .sel(opcode), .y(C4));
    mux4_1_1bit mux_C5 (.d0(1'b0),   .d1(theta0&q1),   .d2(theta0&q1&Q0&(~Q_1)), .d3(theta0&q1), .sel(opcode), .y(C5));
  mux4_1_1bit mux_C6 (.d0(1'b0),   .d1(1'b0),   .d2(((~count)&q1&theta1)|(q2&theta0)), .d3(1'b0), .sel(opcode), .y(C6));
    mux4_1_1bit mux_C7 (.d0(1'b0),   .d1(1'b0),   .d2(1'b0), .d3(q1&theta2), .sel(opcode), .y(C7));
  	mux4_1_1bit mux_C8 (.d0(1'b0),   .d1(1'b0),   .d2((~count)&q1&theta1), .d3(q1&theta3&(~count)), .sel(opcode), .y(C8));
    mux4_1_1bit mux_C9 (.d0(1'b0), .d1(1'b0), .d2(theta0&q2), .d3(theta0&q2), .sel(opcode), .y(C9));
    mux4_1_1bit mux_C10(.d0(theta0&q2), .d1(theta0&q2), .d2(theta1&q2), .d3(theta1&q2), .sel(opcode), .y(C10));

    assign control = {C10, C9, C8, C7, C6, C5, C4, C3, C2, C1, C0};

    
  	assign done = C10;
 
endmodule


module control_unit (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [1:0] opcode,  
    input wire Q0,            
    input wire Q_1,           
    input wire A7,            
    input wire [2:0] count,   // booth_count from booth_datapath
    output wire [10:0] control, 
    output wire done          
);

    // FSM sequence counter (3-bit one-hot)
    wire [2:0] state;
    mod3_counter sequence_counter (
        .clk(clk),
        .reset(reset),
        .begin_op(start),
        .state(state)
    );

    // Direct one-hot decoding
    wire q0, q1, q2;
    assign q0 = state[0];
    assign q1 = state[1];
    assign q2 = state[2];

    // Theta signals
    wire theta0, theta1, theta2, theta3;
    assign theta0 = q0; 
    assign theta1 = q1; 
    assign theta2 = q2; 
    assign theta3 = ((opcode == 2'b10) && (Q0 ^ Q_1)) ||  
                    ((opcode == 2'b11) && A7);

    // Control signals C0 - C10
    wire C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10;

    // Optimized muxes
    mux2_1_1bit mux_C0 (.d0(1'b0), .d1(theta0), .sel(~opcode[1] & ~opcode[0]), .y(C0));
    mux2_1_1bit mux_C1 (.d0(1'b0), .d1(theta0), .sel(~opcode[1] & opcode[0]),  .y(C1));

    mux4_1_1bit mux_C2 (.d0(1'b0),   .d1(1'b0),   .d2(theta0), .d3(1'b0),   .sel(opcode), .y(C2));
    mux4_1_1bit mux_C3 (.d0(1'b0),   .d1(1'b0),   .d2(1'b0),   .d3(theta0), .sel(opcode), .y(C3));
    mux4_1_1bit mux_C4 (.d0(theta1), .d1(theta1), .d2(theta3), .d3(theta3), .sel(opcode), .y(C4));
    mux4_1_1bit mux_C5 (.d0(1'b0),   .d1(1'b0),   .d2(theta1), .d3(theta1), .sel(opcode), .y(C5));
    mux4_1_1bit mux_C6 (.d0(1'b0),   .d1(1'b0),   .d2(theta1), .d3(theta1), .sel(opcode), .y(C6));
    mux4_1_1bit mux_C7 (.d0(1'b0),   .d1(1'b0),   .d2(theta1), .d3(theta1), .sel(opcode), .y(C7));
    mux4_1_1bit mux_C8 (.d0(1'b0),   .d1(1'b0),   .d2(theta1), .d3(theta1), .sel(opcode), .y(C8));
    mux4_1_1bit mux_C9 (.d0(theta2), .d1(theta2), .d2(theta2), .d3(theta2), .sel(opcode), .y(C9));
    mux4_1_1bit mux_C10(.d0(theta2), .d1(theta2), .d2(theta2), .d3(theta2), .sel(opcode), .y(C10));

    assign control = {C10, C9, C8, C7, C6, C5, C4, C3, C2, C1, C0};

    // Done logic
    assign done = (opcode == 2'b10) ? (count == 3'd7) : theta2;
    // - If operation is MUL (10), done only after 8 cycles (count reaches 7)
    // - Else (ADD, SUB, DIV), done when FSM reaches Q2

endmodule


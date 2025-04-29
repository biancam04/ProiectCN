module mod4_counter (
    input wire clk,
    input wire reset,
    input wire begin_op,
    output reg [3:0] state
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0001; 
        else if (begin_op)
            state <= 4'b0001; 
        else begin
            case (state)
                4'b0001: state <= 4'b0010; 
                4'b0010: state <= 4'b0100; 
                4'b0100: state <= 4'b1000; 
                4'b1000: state <= 4'b0001; 
                default: state <= 4'b0001; 
            endcase
        end
    end

endmodule


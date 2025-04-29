module mod4_counter (
    input wire clk,
    input wire reset,
    input wire begin_op,
    output reg [3:0] state
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 4'b0001; // Start at theta0
        else if (begin_op)
            state <= 4'b0001; // Reset to theta0 when operation begins
        else begin
            case (state)
                4'b0001: state <= 4'b0010; // theta0 ? theta1
                4'b0010: state <= 4'b0100; // theta1 ? theta2
                4'b0100: state <= 4'b1000; // theta2 ? theta3
                4'b1000: state <= 4'b0001; // theta3 ? theta0
                default: state <= 4'b0001; // Safety reset
            endcase
        end
    end

endmodule


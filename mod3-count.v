module mod3_counter (
    input wire clk,
    input wire reset,
    input wire begin_op,
    output reg [2:0] state
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 3'b001; // Initialize at Q0
        else if (begin_op)
            state <= 3'b001; // Reset to Q0 when start
        else begin
            case (state)
                3'b001: state <= 3'b010; // Q0 ? Q1
                3'b010: state <= 3'b100; // Q1 ? Q2
                3'b100: state <= 3'b001; // Q2 ? Q0
                default: state <= 3'b001; // Safety reset to Q0
            endcase
        end
    end

endmodule

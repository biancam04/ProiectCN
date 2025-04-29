module restoring_divider_datapath (
    input wire clk,
    input wire reset,
    input wire load,
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    output reg [7:0] quotient,
    output reg [7:0] remainder,
    output reg done
);

    reg [7:0] A;
    reg [7:0] Q;
    reg [7:0] M;
    reg [3:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 8'd0;
            Q <= 8'd0;
            M <= 8'd0;
            count <= 4'd0;
            quotient <= 8'd0;
            remainder <= 8'd0;
            done <= 0;
        end
        else if (load) begin
            A <= 8'd0;
            Q <= dividend;
            M <= divisor;
            count <= 4'd8; // 8 cycles
            done <= 0;
        end
        else if (count != 0) begin
            {A, Q} <= {A, Q} << 1;
            A <= A - M;
            if (A[7]) begin
                Q[0] <= 1'b0;
                A <= A + M;
            end else begin
                Q[0] <= 1'b1;
            end
            count <= count - 1;
            done <= 0;
        end
        else begin
            // Final output assignment when done
            quotient <= Q;
            remainder <= A;
            done <= 1;
        end
    end

endmodule

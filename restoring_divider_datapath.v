module restoring_divider_datapath (
    input wire clk,
    input wire reset,
    input wire load,
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    output wire [7:0] quotient,
    output wire [7:0] remainder
);
    reg [7:0] A;
    reg [7:0] Q;
    reg [7:0] M;
    reg [3:0] count;

    assign quotient = Q;
    assign remainder = A;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 8'd0;
            Q <= 8'd0;
            M <= 8'd0;
            count <= 4'd0;
        end else if (load) begin
            A <= 8'd0;
            Q <= dividend;
            M <= divisor;
            count <= 4'd8;
        end else if (count != 0) begin
            {A, Q} <= {A, Q} << 1;
            A <= A - M;
            if (A[7] == 1'b1) begin
                Q[0] <= 1'b0;
                A <= A + M;
            end else begin
                Q[0] <= 1'b1;
            end
            count <= count - 1;
        end
    end
endmodule

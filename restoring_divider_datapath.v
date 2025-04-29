module restoring_divider_datapath (
    input wire clk,
    input wire reset,
    input wire load,
    input wire [7:0] dividend,
    input wire [7:0] divisor,
    output reg [7:0] quotient,
    output reg [7:0] remainder,
    output reg done,
    output wire count,      // already ok
    output wire [7:0] A     // <<== add output A
);

    reg [7:0] A_reg;
    reg [7:0] Q;
    reg [7:0] M;
    reg [2:0] counter_internal;

    assign count = (counter_internal == 3'd7) ? 1'b1 : 1'b0;
    assign A = A_reg;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A_reg <= 8'd0;
            Q <= 8'd0;
            M <= 8'd0;
            counter_internal <= 3'd0;
            quotient <= 8'd0;
            remainder <= 8'd0;
            done <= 0;
        end
        else if (load) begin
            A_reg <= 8'd0;
            Q <= dividend;
            M <= divisor;
            counter_internal <= 3'd0;
            done <= 0;
        end
        else if (counter_internal < 3'd7) begin
            {A_reg, Q} <= {A_reg, Q} << 1;
            A_reg <= A_reg - M;
            if (A_reg[7]) begin
                Q[0] <= 1'b0;
                A_reg <= A_reg + M;
            end else begin
                Q[0] <= 1'b1;
            end
            counter_internal <= counter_internal + 1;
            done <= 0;
        end
        else begin
            quotient <= Q;
            remainder <= A_reg;
            done <= 1;
        end
    end

endmodule


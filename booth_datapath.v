module booth_datapath (
    input wire clk,
    input wire reset,
    input wire start,
    input wire [7:0] multiplicand,
    input wire [7:0] multiplier,
    output wire [15:0] product,
    output wire done,
    output wire count,      // already ok
    output wire Q0,         // expose Q[0]
    output wire Q_1         // <<== add output for Q_1 !!
);

    reg [7:0] A, Q, M;
    reg Q_1_reg;
    reg [2:0] counter_internal;
    reg busy;

    assign done = (counter_internal == 3'd7) && busy;
    assign count = (counter_internal == 3'd7) ? 1'b1 : 1'b0;
    assign Q0 = Q[0];
    assign Q_1 = Q_1_reg;
    assign product = {A, Q};

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 8'd0;
            Q <= 8'd0;
            M <= 8'd0;
            Q_1_reg <= 1'b0;
            counter_internal <= 3'd0;
            busy <= 1'b0;
        end
        else if (start) begin
            A <= 8'b0;
            Q <= multiplier;
            M <= multiplicand;
            Q_1_reg <= 1'b0;
            counter_internal <= 3'd0;
            busy <= 1'b1;
        end
        else if (busy) begin
            if ({Q[0], Q_1_reg} == 2'b01)
                A <= A + M;
            else if ({Q[0], Q_1_reg} == 2'b10)
                A <= A - M;

            {A, Q, Q_1_reg} <= {A[7], A, Q}; // Arithmetic right shift
            counter_internal <= counter_internal + 1;

            if (counter_internal == 3'd7)
                busy <= 1'b0;
        end
    end

endmodule

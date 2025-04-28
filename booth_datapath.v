module booth_datapath (
    input wire clk,
    input wire reset,
    input wire [7:0] inbus,
    input wire [10:0] control,
    output wire [7:0] outbus,
    output wire q0,
    output wire q_1,
    output wire [2:0] count
);
    reg [7:0] A, Q, M;
    reg Qm1; // Q-1
    reg [2:0] booth_count; // Booth iteration counter

    wire [7:0] adder_out;
    wire [7:0] complemented_m;

    assign complemented_m = ~M + 1;

    // Adder for A + M or A + (-M)
    assign adder_out = (control[4]) ? (A + complemented_m) : (A + M);

    // Expose current Q0 and Q-1
    assign q0 = Q[0];
    assign q_1 = Qm1;

    // Booth operation count
    assign count = booth_count;

    // Select output
    assign outbus = (control[9]) ? A : ((control[10]) ? Q : 8'b0);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 8'd0;
            Q <= 8'd0;
            M <= 8'd0;
            Qm1 <= 1'b0;
            booth_count <= 3'd0;
        end else begin
            // Control signals from external controller
            if (control[2]) begin
                M <= inbus;
            end
            if (control[1]) begin
                Q <= inbus;
            end
            if (control[0]) begin
                A <= adder_out;
            end
            if (control[3]) begin
                Qm1 <= Q[0];
            end
            if (control[7]) begin
                // Arithmetic shift right (A, Q, Q-1)
                {A, Q, Qm1} <= {A[7], A, Q};
            end
            if (control[8]) begin
                booth_count <= booth_count + 1;
            end
        end
    end

endmodule

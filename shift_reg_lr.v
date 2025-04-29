module shift_reg_lr (
    input wire clk,
    input wire [1:0] mode,      // 00: hold, 01: shift right, 10: shift left, 11: load
    input wire [7:0] data_in,   // for parallel load
    input wire shift_in_left,   // for right shift (goes into MSB)
    input wire shift_in_right,  // for left shift (goes into LSB)
    output wire [7:0] data_out
);

    wire [7:0] d;  // Input to each FF
    wire [7:0] q;  // Output of each FF

    assign data_out = q;

    // MUX logic for each bit (based on mode)
    assign d[0] = (mode == 2'b00) ? q[0] :                // Hold
                  (mode == 2'b01) ? q[1] :                // Shift right
                  (mode == 2'b10) ? shift_in_right :      // Shift left
                                   data_in[0];            // Load

    assign d[7] = (mode == 2'b00) ? q[7] :
                  (mode == 2'b01) ? shift_in_left :
                  (mode == 2'b10) ? q[6] :
                                   data_in[7];

    genvar i;
    generate
        for (i = 1; i < 7; i = i + 1) begin : shift_logic
            assign d[i] = (mode == 2'b00) ? q[i] :
                          (mode == 2'b01) ? q[i+1] :
                          (mode == 2'b10) ? q[i-1] :
                                           data_in[i];
        end
    endgenerate

    // D flip-flops
    genvar j;
    generate
        for (j = 0; j < 8; j = j + 1) begin : dffs
            d_ff ff (
                .clk(clk),
                .d(d[j]),
                .q(q[j])
            );
        end
    endgenerate

endmodule


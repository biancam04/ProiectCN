module testbench;

    reg [15:0] in; 
  	reg [1:0] op_codes;
    reg valid;
    reg clk;
    reg rst;
    wire [7:0] o;
    wire ready;

    wire [7:0] in_a = in[15:8];
    wire [7:0] in_b = in[7:0];

    alu uut (
        .in(in),
        .op_codes(op_codes),
        .valid(valid),
        .clk(clk),
        .rst(rst),
        .o(o),
        .ready(ready)
    );


    initial begin
      
      	$dumpfile("dump.vcd");
   		$dumpvars(0);
        $display("Starting ALU Testbench...");
      

        // Initialize
        clk = 0;
        rst = 1;
        valid = 0;
        in = 16'd0;
        op_codes = 2'b00;

        // Reset 
        #10; rst = 0; #10;

      /*
      
        // ADD
        in = {8'd25, 8'd17}; // A = 25, B = 17
        op_codes = 2'b00;
        valid = 1;
        #10; valid = 0;
        $display("ADD: A = %d, B = %d Result = %d", in_a, in_b, o);
        #20;
      
		
      	// SUB 
        in = {8'd40, 8'd15};
        op_codes = 2'b01;
        valid = 1;
        #10; valid = 0;
        $display("SUB: A = %d, B = %d Result = %d", in_a, in_b, o);
        #20;
        
        */
      
      

        // MUL 
        in = {8'd5, 8'd3};
        op_codes = 2'b10;
        valid = 1;
        #10; valid = 0;
        $display("MUL: A = %d, B = %d → Result = %d", in_a, in_b, o);
        #20;
      
      /*

        // DIV
        in = {8'd20, 8'd4};
        op_codes = 2'b11;
        valid = 1;
        #10; valid = 0;
        $display("DIV: A = %d, B = %d Result = %d", in_a, in_b, o);
        #20;
        */
 
    end

  	initial begin
    integer i;
    for(i = 0;i < 100;i = i + 1) begin
      clk = ~clk;
      #10;
    end
  end
  
endmodule
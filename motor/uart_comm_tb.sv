module uart_comm_tb();

  // Testbench signals
  logic clk;
  logic rst;
  logic [17:0] SW;
  logic neg_l;
  logic neg_r;
  logic valid;
  logic ready;
  logic uart_out;

  // Instantiate the uart_comm module
  uart_comm uut (
    .clk(clk),
    .SW(SW),
    .rst(rst),
	 .neg_l(neg_l),
	 .neg_r(neg_r),
    .valid(valid),
    .ready(ready),
    .uart_out(uart_out)
  );

  // Clock generation (50 MHz)
  initial begin
    clk = 0;
    forever #10 clk = ~clk;  // 50 MHz clock (20 ns period)
  end

  // Testbench procedure
  initial begin
    // Initialize signals
    rst = 1'b1;
    valid = 1'b1;
    SW = 18'b0;
	 neg_l = 0;
	 neg_r = 0;
    
    // Apply reset
    #50 rst = 1'b0;
    #10 

    // Test case 1: SW[2:0] = 000 (Both L and R set to 0.0)
    SW[2:0] = 3'b000;
    valid = 1'b1;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 2: SW[2:0] = 001 (L = 1.0, R = 1.0)
    SW[2:0] = 3'b001;
    valid = 1'b1;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 3: SW[2:0] = 010 (L = 1.0, R = 0.0)
    SW[2:0] = 3'b010;
    valid = 1'b1;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 4: SW[2:0] = 100 (L = 0.0, R = 1.0)
    SW[2:0] = 3'b100;
    valid = 1'b1;
    #20000;  // Wait for a few clock cycles to observe the behavior

	 // Test case 5: full speed reverse
	 neg_l = 1;
	 neg_r = 1;
    SW[2:0] = 3'b001;
    valid = 1'b1;
    #20000;  // Wait for a few clock cycles to observe the behavior

	 
    // Finish simulation
    $finish;
  end

  // Monitor the uart_out and ready signals
  initial begin
    $monitor("Time=%0t, SW=%b, uart_out=%b, ready=%b", $time, SW[2:0], uart_out, ready);
  end

endmodule

module uart_comm_tb();

  // Testbench signals
  logic clk;
  logic rst;
  logic [3:0]move_cmd;
  logic [3:0]speed_level;
  logic valid;
  logic ready;
  logic uart_out;

  // Instantiate the uart_comm module
  uart_comm uut (
    .clk(clk),
    .move_cmd(move_cmd),
    .rst(rst),
	 .speed_level(speed_level),
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
    rst = 1'b0;
    valid = 1'b1;
    speed_level = 2;
	 move_cmd = 0;
	 valid = 1'b1;
    
    // Apply reset
    #50 
	 
	 move_cmd = 4'b0001;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 2: SW[2:0] = 001 (L = 1.0, R = 1.0)
    move_cmd = 4'b0010;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 3: SW[2:0] = 010 (L = 1.0, R = 0.0)
    move_cmd = 4'b0011;
    #20000;  // Wait for a few clock cycles to observe the behavior
    

	 
    // Finish simulation
    $finish;
  end


endmodule

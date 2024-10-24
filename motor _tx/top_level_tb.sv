module top_level_tb();

  // Testbench signals
  logic        CLOCK_50;
  logic        reset;
  logic [17:0] SW;
  logic 	[5:0]	GPIO;

  // Instantiate the top_level module
  top_level uut (
    .CLOCK_50(CLOCK_50),
    .reset(reset),
    .SW(SW),
    .GPIO(GPIO)
  );

  // Clock generation (50 MHz)
  initial begin
    CLOCK_50 = 0;
    forever #10 CLOCK_50 = ~CLOCK_50;  // 50 MHz clock (20 ns period)
  end

  // Testbench procedure
  initial begin
    // Initialize signals
    reset = 1'b0;
    SW = 18'b0;
    
    // Test case 1: SW[2:0] = 000 (Both L and R set to 0.0)
    SW[2:0] = 3'b000;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 2: SW[2:0] = 001 (L = 1.0, R = 1.0)
    SW[2:0] = 3'b001;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 3: SW[2:0] = 010 (L = 1.0, R = 0.0)
    SW[2:0] = 3'b010;
    #20000;  // Wait for a few clock cycles to observe the behavior
    
    // Test case 4: SW[2:0] = 100 (L = 0.0, R = 1.0)
    SW[2:0] = 3'b100;
    #20000;  // Wait for a few clock cycles to observe the behavior

    // Finish simulation
    $finish;
  end


endmodule

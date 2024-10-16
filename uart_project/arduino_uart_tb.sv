module arduino_uart_tb;

  // Parameters
  parameter CLKS_PER_BIT = (50_000_000 / 115_200); // Clock cycles per UART bit
  parameter BITS_N = 8;

  // Inputs
  reg clk_50;
  reg reset;
  reg arduino_input;
  reg ready;

  // Outputs
  wire valid;
  wire [BITS_N-1:0] buffer;

  // Instantiate the DUT (Design Under Test)
  arduino_uart_buffer #(CLKS_PER_BIT, BITS_N) dut (
    .clk_50(clk_50),
    .reset(reset),
    .arduino_input(arduino_input),
    .ready(ready),
    .valid(valid),
    .arduino_command(buffer)
  );

  // Clock generation
  initial begin
    clk_50 = 0;
    forever #10 clk_50 = ~clk_50; // 50 MHz clock (period = 20 ns)
  end

  // Test input sequence
  initial begin
    // Initialize inputs
    reset = 1;
    arduino_input = 1;
    ready = 0;
    #100;
    
    // Release reset
    reset = 0;
    #100;

    // Start UART transmission with 'ready' high
	ready = 1;
	#20
    // Simulate sending a byte (for example, 8'b10101010)
    send_uart_byte(8'b10101010);

    // Wait for the transmission to complete
    #2000;

    // End of simulation
    $finish;
  end

  // Task to simulate UART transmission of 1 start bit, 8 data bits, and 1 stop bit
  task send_uart_byte(input [7:0] data);
    integer i;
    begin
      // Send start bit (0)
      arduino_input = 0;
      # (CLKS_PER_BIT * 20);

      // Send data bits (LSB first)
      for (i = BITS_N-1; i >=0; i = i - 1) begin
        arduino_input = data[i];
        # (CLKS_PER_BIT * 20);
      end

      // Send stop bit (1)
      arduino_input = 1;
      # (CLKS_PER_BIT * 20);
    end
  endtask

  // Monitor outputs
  initial begin
    $monitor("At time %0dns, buffer = %b, valid = %b", $time, buffer, valid);
  end

endmodule

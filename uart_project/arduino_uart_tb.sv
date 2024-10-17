module arduino_uart_tb;

  // Parameters for the UART module
  parameter CLKS_PER_BIT = (50_000_000 / 115_200);
  parameter DATA_BITS = 8;

  // Inputs
  reg clk_50;
  reg reset;
  reg arduino_input;
  reg ready = 1;

  // Outputs
  wire [DATA_BITS-1:0] arduino_data;
  wire valid;

  // Instantiate the UART RX module
  arduino_uart_buffer #(.CLKS_PER_BIT(CLKS_PER_BIT), .DATA_BITS(DATA_BITS)) uart_rx_inst (
    .clk_50(clk_50),
    .reset(reset),
    .arduino_input(arduino_input),
    .arduino_data(arduino_data),
    .valid(valid),
    .ready(ready)
  );

  // Clock generation
  always #10 clk_50 = ~clk_50; // 50 MHz clock

  // Task to simulate UART transmission
  task uart_send_byte;
    input [7:0] byte_data;
    integer i;
    begin
      // Start bit (logic low)
      arduino_input = 0;
      #(CLKS_PER_BIT * 20); // Wait for 1 bit period

      // Send 8 data bits (LSB first)
      for (i = 0; i < DATA_BITS; i = i + 1) begin
        arduino_input = byte_data[i];
        #(CLKS_PER_BIT * 20); // Wait for 1 bit period
      end

      // Stop bit (logic high)
      arduino_input = 1;
      #(CLKS_PER_BIT * 20); // Wait for 1 bit period
    end
  endtask

  initial begin
    // Initialize inputs
    clk_50 = 0;
    reset = 1;
    arduino_input = 1; // Idle state is high
    ready = 0;

    // Release reset after a few clock cycles
    #(CLKS_PER_BIT * 2);
    reset = 0;

    // Test Case 1: Send byte 0x55 (01010101)
    uart_send_byte(8'h55);

    // Wait for valid signal to go high
    wait(valid);
    #20;
    $display("Received data: 0x%h", arduino_data);
    if (arduino_data != 8'h55) begin
      $display("Test failed! Expected 0x55 but got 0x%h", arduino_data);
    end else begin
      $display("Test passed!");
    end

    // Test Case 2: Send byte 0xA3 (10100011)
    uart_send_byte(8'hA3);

    // Wait for valid signal to go high
    wait(valid);
    #20;
    $display("Received data: 0x%h", arduino_data);
    if (arduino_data != 8'hA3) begin
      $display("Test failed! Expected 0xA3 but got 0x%h", arduino_data);
    end else begin
      $display("Test passed!");
    end

    $finish;
  end

endmodule

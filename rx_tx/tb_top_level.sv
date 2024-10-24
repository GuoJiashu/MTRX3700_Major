`timescale 1ns/1ps

module tb_top_level;

// Clock and reset signals
reg CLOCK_50;
reg GPIO_3,GPIO_5;
wire [17:0] LEDR;
reg [3:0]KEY;

// Instantiate the top-level module
top_level uut (
    .CLOCK_50(CLOCK_50),
    .GPIO_3(GPIO_3),
	 .KEY(KEY),
	 .GPIO_5(GPIO_5),
    .LEDR(LEDR)
);

// Generate a clock signal (50 MHz)
always #10 CLOCK_50 = ~CLOCK_50;  // 50 MHz clock = 20 ns period

// UART RX timing (assuming 9600 baud rate: ~104.17 µs per bit)
parameter BIT_TIME = 8680;  // 104.167 µs in ps

// Test procedure
initial begin
    // Initialize signals
    CLOCK_50 = 0;
    GPIO_3 = 1;  // idle state, UART line is high (idle when no transmission)
	 GPIO_5 = 1;
    // Apply reset
    KEY[0] = 1'b0;  // reset is applied via GPIO_3
    #BIT_TIME;
    KEY[0] = 1'b1;  // release reset
    #BIT_TIME;

    // Simulate UART RX transmission on GPIO_3
    // Start bit (low)
    GPIO_3 = 1'b0;
    #(BIT_TIME);
    
    // Data bits (sending 8'hA5 = 10100101)
    GPIO_3 = 1'b1;  // Bit 0
    #(BIT_TIME);
    GPIO_3 = 1'b0;  // Bit 1
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 2
    #(BIT_TIME);
    GPIO_3 = 1'b0;  // Bit 3
    #(BIT_TIME);
    GPIO_3 = 1'b0;  // Bit 4
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 5
    #(BIT_TIME);
    GPIO_3 = 1'b0;  // Bit 6
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 7
    #(BIT_TIME);

    // Return to idle (high) - no stop bit
    GPIO_3 = 1'b1;
    #(BIT_TIME);
	 
	 GPIO_3 = 1'b0;
    #(BIT_TIME);
    
    // Data bits (sending 8'hA5 = 10100101)
    GPIO_3 = 1'b0;  // Bit 0
    #(BIT_TIME);
    GPIO_3 = 1'b0;  // Bit 1
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 2
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 3
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 4
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 5
    #(BIT_TIME);
    GPIO_3 = 1'b0;  // Bit 6
    #(BIT_TIME);
    GPIO_3 = 1'b1;  // Bit 7
    #(BIT_TIME);
    // Transmit data via GPIO[5] (uart_tx)
//    GPIO_5 = 1'b1;  // Trigger transmission
//    #50;
//    GPIO_5 = 1'b0;

    // Monitor the buffer values on LEDR[7:0]
    $monitor("At time %0t: LEDR = %b", $time, LEDR[7:0]);

    // Continue simulation for some time
    #(8*BIT_TIME);

    // Finish the simulation
    $finish;
end

endmodule

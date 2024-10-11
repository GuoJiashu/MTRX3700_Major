module top_level(
	input CLOCK_50,
	inout	[5:0] GPIO,
	
	output [17:0] LEDR
);

assign LEDR[7:0] = buffer;
logic reset, ready;
logic valid;
logic [7:0] buffer;


arduino_uart_buffer u_rx(
	.clk_50(CLOCK_50),
	.reset(reset),
	.arduino_input(GPIO[3]),
	.ready(ready),
	.valid(valid),
	.arduino_command(buffer)
);

uart_tx u_tx(
   .clk(CLOCK_50),
   .rst(reset),
   .data_tx(buffer),
   .uart_out(GPIO[5]),
   .valid(valid),            // Handshake protocol: valid (when `data_tx` is valid to be sent onto the UART).
   .ready(ready),      // Handshake protocol: ready (when this UART module is ready to send data).
	.baud_trigger()
 );

endmodule

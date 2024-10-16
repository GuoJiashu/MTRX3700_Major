module top_level(
	input CLOCK_50,
	input [3:0]KEY,
	inout [5:0]GPIO,

	output [17:0] LEDR
);


logic rx_ready,rx_valid;
//logic tx_ready,tx_valid;

logic [7:0] buffer;
assign LEDR[7:0] = buffer;

arduino_uart_buffer u_rx(
	.clk_50(CLOCK_50), 
	.reset(~KEY[0]), 
	.arduino_input(GPIO[3]),          // The RX pin
	.data_received(buffer), 
	.valid(rx_valid),       // handshake
	.ready(rx_ready)
);

uart_tx u_tx(
   .clk(CLOCK_50),
   .rst(~KEY[0]),
   .data_tx(buffer),
   .uart_out(GPIO[5]),
   .valid(rx_valid),            // Handshake protocol: valid (when `data_tx` is valid to be sent onto the UART).
   .ready(rx_ready),      // Handshake protocol: ready (when this UART module is ready to send data).
	.baud_trigger()
 );

endmodule

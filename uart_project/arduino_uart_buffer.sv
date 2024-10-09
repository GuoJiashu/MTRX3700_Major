module arduino_uart_buffer (
	input 				clk_50,
	input 				clk_arduino,
	input 				reset,
	input 	[8:0]		arduino_input,
	
	output	[8:0]	 	buffer
)

	logic [8:0] sync_message;
	logic 		read_req, empty, full;
	logic 		arduino_valid;
	
	assign arduino_valid = (arduino_input != 9'b0);
	assign read_req		= (!empty);
	
	async_fifo u_arduino_fifo ( .aclr(reset), .data(arduino_input), .rdclk(clk_50), .rdreq(read_req), .wrclk(clk_arduino)
										 .wrreq(arduino_valid),.q(sync_message), .rdempty(empty), .wrfull(full))
	
	
endmodule

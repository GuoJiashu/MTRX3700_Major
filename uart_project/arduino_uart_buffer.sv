module arduino_uart_buffer #(parameter CLKS_PER_BIT = (50_000_000/115_200), BITS_N = 8)(
	input 									clk_50,
	input 									reset,
	input 									arduino_input,
	input 									ready,
	output logic 							valid,
	output logic [BITS_N-1:0]	 	arduino_command
);

	integer clk_counter = CLKS_PER_BIT;
	logic [BITS_N-1:0]	input_buffer;
	logic [$clog2(BITS_N):0] bit_counter = BITS_N;
	logic valid_q0, valid_q1, valid_triggered;

	// Generate valid signal when full data is received
	always_ff @(posedge clk_50 or posedge reset) begin
		if (reset) begin
			valid <= 0;
		end
		else if ((bit_counter == BITS_N) && (clk_counter == CLKS_PER_BIT-1)) begin
			valid <= 1;
		end
		else if (ready) begin
			valid <= 0;
		end
	end

	// Detect valid rising edge
	always_ff @(posedge clk_50) begin
		valid_q0 <= valid;
		valid_q1 <= valid_q0;
	end
	assign valid_triggered = (valid_q1 == 0) && (valid_q0 == 1);

	// Main UART reception logic
	always_ff @(posedge clk_50 or posedge reset) begin
		if (reset) begin
			clk_counter <= CLKS_PER_BIT;
			bit_counter <= BITS_N;
			input_buffer <= 0;
		end
		else begin
			if (ready & valid_triggered) begin
				clk_counter <= 0;
				bit_counter <= 0;
			end
			else begin
				if (clk_counter == CLKS_PER_BIT-1) begin
					if (bit_counter <= BITS_N-1) begin
						bit_counter <= bit_counter + 1;
						clk_counter <= 0;
					end
					else begin
						bit_counter <= BITS_N;
						clk_counter <= CLKS_PER_BIT;
					end
				end
				else begin
					clk_counter <= clk_counter + 1;
					if (bit_counter <= BITS_N-1) input_buffer[BITS_N-1-bit_counter] <= arduino_input;
				end
			end
		end
	end

	// Output the received data
	always_ff @(posedge clk_50) begin
		if (valid && ready) begin
			arduino_command <= input_buffer;
		end
	end

endmodule

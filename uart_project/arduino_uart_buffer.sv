module arduino_uart_buffer #(parameter CLKS_PER_BIT = (50_000_000/115_200), DATA_BITS = 8)
(
	input  						clk_50, 
	input  						reset, 
	input  						arduino_input, //	rx pin for arduino
	output [DATA_BITS-1:0]  arduino_data,  //	8 bit data from GUI via arduino
	output 						valid,       	// handshake, valid data from arduino
	input  						ready				// handshake, ready to receive new command
);
   
  // Synchoronizer for uart input
	logic rx_q0, rx_q1;
	always @(posedge clk_50) begin
		rx_q0   <= arduino_input;
		rx_q1   <= rx_q0;
	end
   
	logic   [31:0]  			  clk_counts; 
	logic   [DATA_BITS-1:0]   input_buffer = 0, buffer_prev = 0;
	logic   [3:0]   			  bit_index;
	enum logic [2:0] {IDLE, START_BIT, WAIT, DATA_BIT, STOP_BIT, CLEANUP} state, next_state;

	always_comb begin
		case (state)
			IDLE:
				next_state = (rx_q1) ? IDLE : START_BIT;
			START_BIT:
				next_state = (clk_counts == CLKS_PER_BIT/2 -1) ? WAIT : START_BIT;
			WAIT:
				next_state = (clk_counts == CLKS_PER_BIT - 2) ? DATA_BIT : WAIT;
			DATA_BIT:
				next_state = (bit_index == DATA_BITS) ? STOP_BIT : DATA_BIT;
			STOP_BIT:
				next_state = (clk_counts == CLKS_PER_BIT -1) ? CLEANUP : STOP_BIT;
			CLEANUP:
				next_state = IDLE;
		endcase
  end
	
	//operation depending on current state
	always_ff @(posedge clk_50) begin
		if(reset) begin
			state <= IDLE;
			bit_index  <=  0; 
			clk_counts <= 0;
			buffer_prev <= 0;
			input_buffer <= 0;
		end
		else begin
			state <= next_state;
			if (state != IDLE) clk_counts  <=  (clk_counts == CLKS_PER_BIT-1) ? 0 : clk_counts + 1;
			else clk_counts <= 0;
		end
	
		if(state == IDLE) begin
			clk_counts <= 0;
			bit_index <=0;
			buffer_prev <= input_buffer;
		end
		else if (DATA_BIT) begin
			input_buffer[bit_index]  <=  rx_q1;
			bit_index  <=  (clk_counts == CLKS_PER_BIT-1) ? bit_index  +  1 : bit_index; 
		end
	end
	
	assign valid = (state == IDLE) ? 1 : 0;
	assign arduino_data = (valid && ready) ? input_buffer : buffer_prev; //update input data during at handshake
  
endmodule

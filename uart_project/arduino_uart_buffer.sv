module arduino_uart_buffer #(parameter CLKS_PRE_BITS = (50_000_000/115_200), DATA_BITS = 8)
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
	logic   [DATA_BITS-1:0]   input_buffer;
	logic   [2:0]   			  bit_index;
	enum logic [2:0] {IDLE, START_BIT, WAIT, DATA_BIT, STOP_BIT} state, next_state;
	
	//next state
	always_comb begin
		case (state)
			IDLE:
				next_state = (rx_q1) ? IDLE : START_BIT;
			START_BIT:
				next_state = (clk_counts == CLKS_PRE_BITS/2 -1) ? WAIT : START_BIT;
			WAIT:
				next_state = (clk_counts == CLKS_PRE_BITS -2) ? DATA_BIT : WAIT;
			DATA_BIT:
				next_state = (bit_index == DATA_BITS-1) ? STOP_BIT : WAIT;
			STOP_BIT:
				next_state = (clk_counts == CLKS_PRE_BITS -1) ? IDLE : STOP_BIT;
			default: next_state = IDLE;
		endcase
	end
	
	//operation depending on current state
	always_ff @(posedge clk_50) begin
		if(reset) begin
			state <= IDLE;
			bit_index  <=  0; 
			clk_counts <= 0;
		end
		else begin
			state <= next_state;
			clk_counts  <=  (clk_counts == CLKS_PRE_BITS-1) ? 0 : clk_counts + 1;
		end
	
		if(state == IDLE) begin
			clk_counts <= 0;
			bit_index <=0;
		end
		else if (DATA_BIT) begin
			input_buffer[bit_index]  <=  rx_q1;
			bit_index  <=  (clk_counts == CLKS_PRE_BITS-1) ? bit_index  +  1 : bit_index; 
		end
	end
	
  assign valid = (state == IDLE) ? 1 : 0;
  assign arduino_data = (valid && ready) ? input_buffer : arduino_data; //update input data during at handshake
  
endmodule

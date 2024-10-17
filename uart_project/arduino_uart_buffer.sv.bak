module arduino_uart_buffer #(parameter clk_50S_PER_BIT = (50_000_000/115_200), DATA_BITS = 8)
(
	input  clk_50, 
	input  reset, 
	input  arduino_input,          // The RX pin
	output [DATA_BITS-1:0]  data_received, 
	output valid,       // handshake
	input  ready        // handshake
);
   
  // Synchoronizer:
	logic rx_q0, rx_q1; // Important: only use rx_q1 in your code as this is the synchronizer output!
	always @(posedge clk_50)
		begin
			rx_q0   <= arduino_input;      // 2 flip-flops in series.
			rx_q1   <= rx_q0;
		end
   
	logic   [31:0]  count; 
	logic   [7:0]   data;
	logic   [2:0]   bit_index;
	enum logic [2:0] {IDLE, START_BIT, WAIT, DATA_BIT, STOP_BIT, CLEANUP} state, next_state;

	always_comb begin
		case (state)
			IDLE:
				next_state = (rx_q1) ? IDLE : START_BIT;
			START_BIT:
				next_state = (count == clk_50S_PER_BIT/2 -1) ? WAIT : START_BIT;
			WAIT:
				next_state = (count == clk_50S_PER_BIT -2) ? DATA_BIT : WAIT;
			DATA_BIT:
				next_state = (bit_index == DATA_BITS-1) ? STOP_BIT : WAIT;
			STOP_BIT:
				next_state = (count == clk_50S_PER_BIT -1) ? CLEANUP : STOP_BIT;
			CLEANUP:
				next_state = IDLE;
		endcase
	end

	always_ff @(posedge clk_50) begin
		if(reset) begin
			state <= IDLE;
			bit_index  <=  0; 
				count <= 0;
		end
		else begin
			state <= next_state;
			count  <=  count == clk_50S_PER_BIT-1 ? 0 : count + 1;
		end
	
		if(state == IDLE) begin
			count <= 0;
			bit_index <=0;
		end
		else if (DATA_BIT) begin
			data_received[bit_index]  <=  rx_q1;
			bit_index  <=  (count == clk_50S_PER_BIT-1) ? bit_index  +  1 : bit_index; 
		end

	end


  assign valid = (state == IDLE) ? 1 : 0;
endmodule

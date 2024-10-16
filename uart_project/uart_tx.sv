module uart_tx #(
      parameter CLKS_PER_BIT = (50_000_000/115_200), // E.g. Baud_rate = 115200 with FPGA clk = 50MHz
      parameter BITS_N       = 8, // Number of data bits per UART frame
      parameter PARITY_TYPE  = 0  // 0 for none, 1 for odd parity, 2 for even.
) (
      input clk,
      input rst,
      input [BITS_N-1:0] data_tx,
      output logic uart_out,
      input valid,            // Handshake protocol: valid (when `data_tx` is valid to be sent onto the UART).
      output logic ready,      // Handshake protocol: ready (when this UART module is ready to send data).
		output logic baud_trigger
 );

   logic [BITS_N-1:0] data_tx_temp;
   logic [2:0]        bit_n;

   integer cycle_count; 
   //logic baud_trigger;
   assign baud_trigger = (cycle_count == (CLKS_PER_BIT - 1)) ? 1 : 0;

   enum {IDLE, START_BIT, DATA_BITS, STOP_BIT} current_state = IDLE, next_state;

   always_comb begin : fsm_next_state
         case (current_state)
            IDLE:        next_state = valid ? START_BIT : IDLE; // Handshake protocol: Only start sending data when valid data comes through.
            START_BIT:   next_state = baud_trigger ? DATA_BITS : START_BIT;
            DATA_BITS:   next_state = (baud_trigger && (bit_n == BITS_N-1)) ? STOP_BIT : DATA_BITS;
				STOP_BIT:	 next_state = IDLE;
            default: next_state = IDLE;
         endcase
   end
   
   always_ff @( posedge clk ) begin : fsm_ff
      if (rst) begin
         current_state <= IDLE;
         data_tx_temp <= 0;
         bit_n <= 0;
         cycle_count <= 0;
      end
      else begin
         current_state <= next_state;

         case (current_state)
            IDLE: begin // Idle -- register the data to send (in case it gets corrupted by an external module). Reset counters
               bit_n <= 0;
               cycle_count <= 0;
					data_tx_temp <= data_tx;
            end
            START_BIT: begin 
               cycle_count <= (baud_trigger) ? 0 : cycle_count + 1;
            end
            DATA_BITS: begin // Data transfer -- Count up the bit-index to send.
               if (baud_trigger) begin
                  bit_n <= bit_n + 1'b1;
                  cycle_count <= 0;
               end
               else cycle_count <= cycle_count +1;
            end
         endcase
      end
   end

   always_comb begin : fsm_output
         uart_out = 1'b1; // Default: The UART line is high.
         ready = 1'b0;    // Default: This UART module is only ready for new data when in the IDLE state.
         case (current_state)
            IDLE:   begin
               ready = 1'b1;  // Handshake protocol: This UART module is ready for new data to send.
            end
            DATA_BITS:    begin
               uart_out = data_tx_temp[bit_n]; // Set the UART TX line to the current bit being sent.
            end
            START_BIT:    begin
               uart_out = 1'b0; // The start condition is a zero.
            end
				STOP_BIT: begin
					uart_out = 1'b1;
				end
         endcase
   end

 endmodule
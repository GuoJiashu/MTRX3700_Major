module mid_line_error#(parameter IMAGE_WIDTH = 320, IMAGE_LENGTH = 240, COLOUR_BITS = 4)(
	input 								clk,
	input 								reset,
	input									pixel,
	input 								startofpacket,
	input	integer						row,
	input integer 						col,
	
	output 								end_of_line,
	output logic signed  [31:0]	error,
	output 								error_ready
);
	localparam ref_center_line = IMAGE_WIDTH/2; // graphic center line
	
	logic pixel_temp;
	int pixel_found;
	int x_sum;
	int path_x_center; // path center line
	logic signed [31:0] error_temp;
	logic ready = 0;
	
	
	always_ff @(posedge clk) begin
		if (reset) begin
			pixel_found <= 0;
			x_sum <= 0;
		end
		
		else begin
			if (startofpacket) begin
				pixel_found <= 0;
				x_sum <= 0;
			end
			
			if (row > 160 && row < 190) begin
				if ((col >= 19) && (col <= 299)) begin
					if (pixel == 1) begin
						x_sum <= x_sum + col;
						pixel_found <= pixel_found +1;
					end
				end
			end
			
		end
		
	end
	
	always_ff @(posedge clk) begin
		if (reset || startofpacket) begin
			error_temp <= 0;
			ready <= 0;
		end
		else if ((row > 160 && row < 190) && ((col >= 19) && (col <= 299)) && (pixel_found > 1)) begin
			path_x_center = (pixel_found < 1) ? 0 : x_sum / pixel_found;
			error_temp = ref_center_line - path_x_center;
			end_of_line <= 0;
		end
		else if ((row > 190) && pixel_found == 0 ) begin
			end_of_line <= 1;
			error_temp <= 0;
		end
		else begin
			ready <= (row >= 191);
			end_of_line <= 0;
		end
	end
	
	assign error = error_temp;
   assign error_ready = ready;
endmodule 
module mid_line_error #(parameter IMAGE_WIDTH = 320, IMAGE_LENGTH = 240, COLOUR_BITS = 4)(
	input 								clk,
	input 								reset,
	input [11:0]						pixel,
	input 								red,
	input								green,
	input								blue,
	input 								startofpacket,
	
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
	logic [$clog2(IMAGE_WIDTH)-1:0] col_counter;
	logic [$clog2(IMAGE_LENGTH)-1:0] row_counter;
	
	always_comb begin
		if (red) begin
			pixel_temp = (pixel[11:8] == 4'b1111);
		end
		else if (green) begin
			pixel_temp = (pixel[7:4] == 4'b1111);
		end
		else if (blue) begin
			pixel_temp = (pixel[3:0] == 4'b1111);
		end
		else pixel_temp = 0;
	end
	
	always_ff @(posedge clk) begin
		if (reset) begin
			row_counter <= 0;
			col_counter <= 0;
			pixel_found <= 0;
			x_sum <= 0;
		end
		
		else begin
			if (startofpacket) begin
				row_counter <= 0;
				col_counter <= 0;
				pixel_found <= 0;
				x_sum <= 0;
			end
			
			if (row_counter >= 109 && row_counter <= 229) begin
				if ((col_counter > 105) && (col_counter < 211)) begin
					if (pixel_temp == 1) begin
						x_sum <= x_sum + col_counter;
						pixel_found <= pixel_found +1;
					end
				end
			end
			
			if (row_counter < IMAGE_LENGTH) begin
				if (col_counter == IMAGE_WIDTH - 1) begin
					row_counter <= row_counter + 1;
					col_counter <= 0;
				end
				else begin
					col_counter <= col_counter + 1;
				end
			end

		end
		
	end
	
	always_ff @(posedge clk) begin
		if (reset || startofpacket) begin
			error_temp <= 0;
			ready <= 0;
		end
		else if ((row_counter <= 229) && (col_counter <= 212) && (pixel_found > 0)) begin
			path_x_center = (pixel_found < 1) ? 0 : x_sum / pixel_found;
			error_temp = ref_center_line - path_x_center;
			ready <= ((row_counter == 229) && (col_counter == 212) && (pixel_found > 0));
		end
	end
	assign error = error_temp;
   assign error_ready = ready;
endmodule 
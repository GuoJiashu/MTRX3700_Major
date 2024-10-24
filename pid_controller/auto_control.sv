module auto_control(
	input 								clk,
	input 								reset,
	input 								pixel,
	input 								startofpacket,
	input	integer						row,
	input	integer						col,
	
	output								cmd_valid,
	output [3:0]						move_cmd,
	output [3:0]						speed_level
);
	localparam WA = 4'b0001, WD = 4'b0010, W = 4'b0000, STOP = 4'b1000, A = 4'b0100, D = 4'b0101;
	logic signed [31:0] error;
	logic error_ready;
	logic signed [31:0] controller_output ;
	logic [3:0] move_cmd_temp, speed_level_temp, move_cmd_prev, speed_level_prev;
	logic end_of_line, large_angle_left, large_angle_right;
	
	assign move_cmd = move_cmd_temp;
	assign speed_level = speed_level_temp;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			move_cmd_prev <= 0;
			speed_level_prev <= 0;
		end
		else begin
			move_cmd_prev <= move_cmd_temp;
			speed_level_prev <= speed_level_temp;
		end
	end
	
	mid_line_error#(
		.IMAGE_WIDTH(320),
		.IMAGE_LENGTH(240),
		.COLOUR_BITS(4)
	) u_error(
		.clk(clk),
		.reset(reset),
		.pixel(pixel),
		.startofpacket(startofpacket),
		.row(row),
		.col(col),
		
		.end_of_line(end_of_line),
		.error(error),
		.error_ready(error_ready)
	);

	pid_controller #(
		.K_P(71),
		.K_I(0),
		.K_D(0)
	) u_pid_controller(
		.clk(clk),                  
		.rst(reset),                  
		.error(error),  
		.error_ready(error_ready),
		.cmd_valid(cmd_valid),
		.controller_output(controller_output),		
	);
	
	always_ff @(posedge clk) begin
		if (cmd_valid) begin
			if (end_of_line) begin // no more lines
				if (move_cmd_prev == WD) move_cmd_temp <= D;
				else if (move_cmd_prev == WA) move_cmd_temp <= A;
				else move_cmd_temp <= STOP;
				speed_level_temp <= speed_level_prev;
			end
			else if (controller_output == 0) begin
				move_cmd_temp <= W;
				speed_level_temp <= 1;
			end
			else if ($signed(controller_output) < 0) begin // small angle right turn
				move_cmd_temp <= WD;	// right turn
				speed_level_temp <= (-controller_output);
			end
			else if ($signed(controller_output) > 0) begin // small angle left turn
				move_cmd_temp <= WA; // left turn
				speed_level_temp <= controller_output;
			end
			else begin
				move_cmd_temp <= D; // default stop
				speed_level_temp <= 5;
			end
		end
	end
	
endmodule

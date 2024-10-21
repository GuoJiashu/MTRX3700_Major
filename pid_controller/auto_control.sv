module auto_control(
	input 								clk,
	input 								reset,
	input [11:0]						pixel,
	input 								red,
	input									green,
	input									blue,
	input 								startofpacket,
	
	output [3:0]						move_cmd,
	output [3:0]						speed_level
);
	localparam WA = 4'b0001, WD = 4'b0010, W = 4'b0000;
	logic signed [31:0] error;
	logic error_ready;
	logic signed [31:0] controller_output ;
	logic [3:0] move_cmd_temp, speed_level_temp;
	logic	[11:0] pixel_d, pixel_q;
	logic startofpacket_d, startofpacket_q;
	
	assign move_cmd = move_cmd_temp;
	assign speed_level = speed_level_temp;
	
	always_ff @(posedge clk) begin
		if (reset) begin
			pixel_d <= 0;
			pixel_q <= 0;
			startofpacket_d <= 0;
			startofpacket_q <= 0;
		end
		else begin
			pixel_d <= pixel;
			pixel_q <= pixel_d;
			startofpacket_d <= startofpacket;
			startofpacket_q <= startofpacket_d;
		end
	end
	
	mid_line_error#(
		.IMAGE_WIDTH(320),
		.IMAGE_LENGTH(240),
		.COLOUR_BITS(4)
	) u_error(
		.clk(clk),
		.reset(reset),
		.pixel(pixel_q),
		.red(red),
		.green(green),
		.blue(blue),
		.startofpacket(startofpacket_q),
	
		.error(error),
		.error_ready(error_ready)
	);

	pid_controller #(
		.K_P(18),
		.K_I(10),
		.K_D(10)
	) u_pid_controller(
		.clk(clk),                  
		.rst(reset),                  
		.error(error),  
		.error_ready(error_ready),          
		.controller_output(controller_output)  
	);
	
	always_ff @(posedge clk)begin
		if (controller_output < -10) begin
			move_cmd_temp <= WD;	// righe turn
			speed_level_temp <= ~(controller_output-1); // two's comp
		end
		else if (controller_output > 10) begin
			move_cmd_temp <= WA; // left turn
			speed_level_temp <= controller_output;
		end
		else begin
			move_cmd_temp <= W;
			speed_level_temp <= 1;
		end
	end
	
endmodule 
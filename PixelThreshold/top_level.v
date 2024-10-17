module top_level(
input wire clk_50,
input wire btn_resend,
output wire led_config_finished,
output wire vga_hsync,
output wire vga_vsync,
output wire [7:0] vga_r,
output wire [7:0] vga_g,
output wire [7:0] vga_b,
output wire vga_blank_N,
output wire vga_sync_N,
output wire vga_CLK,
input wire ov7670_pclk,
output wire ov7670_xclk,
input wire ov7670_vsync,
input wire ov7670_href,
input wire [7:0] ov7670_data,
output wire ov7670_sioc,
inout wire ov7670_siod,
output wire ov7670_pwdn,
output wire ov7670_reset,
input wire [17:0] SW
);




// DE2-115 board has an Altera Cyclone V E, which has ALTPLL's'
wire clk_50_camera;
wire clk_25_vga;
wire wren;
wire resend;
wire nBlank;
wire vSync;
wire [16:0] wraddress;
wire [11:0] wrdata;
reg [16:0] rdaddress;
wire [11:0] rddata;
wire [7:0] red; wire [7:0] green; wire [7:0] blue;
wire activeArea;
wire [11:0] filtered_pixel;

  my_altpll Inst_vga_pll(
      .inclk0(clk_50),
    .c0(clk_50_camera),
    .c1(clk_25_vga));

  assign resend =  ~btn_resend;

  ov7670_controller Inst_ov7670_controller(
      .clk(clk_50_camera),
    .resend(resend),
    .config_finished(led_config_finished),
    .sioc(ov7670_sioc),
    .siod(ov7670_siod),
    .reset(ov7670_reset),
    .pwdn(ov7670_pwdn),
    .xclk(ov7670_xclk));

  ov7670_capture Inst_ov7670_capture(
      .pclk(ov7670_pclk),
    .vsync(ov7670_vsync),
    .href(ov7670_href),
    .d(ov7670_data),
    .addr(wraddress),
    .dout(wrdata),
    .we(wren));

  frame_buffer Inst_frame_buffer(
      .rdaddress(rdaddress),
    .rdclock(clk_25_vga),
    .q(rddata),
    .wrclock(ov7670_pclk),
    .wraddress(wraddress[16:0]),
    .data(wrdata),
    .wren(wren));
	 
	pixel_filter filter_inst (
		 .clk(clk_25_vga),
		 .pixel_in(rddata),
		 .pixel_signal(1),
		 .sw(SW[17:0]),
		 .pixel_out(filtered_pixel));	 
	
	 integer row = 0, col = 0;
	 integer row_old = 0, col_old = 0;
	 reg vga_ready, vga_start, vga_end;
	 reg [30:0] vga_data;
	 always @(posedge clk_25_vga) begin
		if (resend) begin
			col = 0; row = 0;
		end else if (vga_ready) begin
			if (col >= 319) begin
				col <= 0 ;
				if (row >= 239) row <=0;
				else row <= row+1;
			end else col <= col + 1;
		
			row_old <= row;
			col_old <= col;
			end
		end

	always @(*) begin
		if (col_old == 0 && row_old == 0) vga_start = 1;
		else vga_start = 0;
		
		if (col_old == 319 && row_old == 239) vga_start = 1;
		else vga_start = 0;
		
		rdaddress = row * 320 + col;
	end
	
	always @(*) begin
		vga_data = {
			{filtered_pixel[11:8], filtered_pixel[11:8], 2'b00},
			{filtered_pixel[7:4], filtered_pixel[7:4], 2'b00},
			{filtered_pixel[3:0], filtered_pixel[3:0], 2'b00}
		};
	end
	
	wire sink_valid;
	assign sink_valid = 1'b1;

	vga u_vga (
		.clk_clk(clk_25_vga), .reset_reset_n(btn_resend),
		.video_scaler_0_avalon_scaler_sink_startofpacket(vga_start),
		.video_scaler_0_avalon_scaler_sink_endofpacket(vga_end),
		.video_scaler_0_avalon_scaler_sink_valid(sink_valid),
		.video_scaler_0_avalon_scaler_sink_ready(vga_ready),
		.video_scaler_0_avalon_scaler_sink_data(vga_data),
		// .video_
		.video_vga_controller_0_external_interface_CLK(vga_CLK),
		.video_vga_controller_0_external_interface_HS(vga_hsync),
		.video_vga_controller_0_external_interface_VS(vga_vsync),
		.video_vga_controller_0_external_interface_BLANK(vga_blank_N),
		.video_vga_controller_0_external_interface_SYNC(vga_sync_N),
		.video_vga_controller_0_external_interface_R(vga_r),
		.video_vga_controller_0_external_interface_G(vga_g),
		.video_vga_controller_0_external_interface_B(vga_b),
);

endmodule

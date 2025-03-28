module top_level(
    input CLOCK_50,
    input [3:0] KEY,
	output [17:0] LEDR,
    inout [10:0] GPIO
);

logic [7:0] arduino_command = 8'b00000000; 
logic manual_on = 0, auto_on = 0;
logic w = 0, s = 0, a = 0, d = 0, wa = 0, wd = 0, as = 0, ds = 0, stop = 0;
logic [3:0] speed_level = 4'b0000;
logic [3:0] move_cmd = 4'b0000;
logic rx_valid;
logic servo = 0;

assign LEDR[7:0] = arduino_command;
mode_select mode_select_u0(
    .clk(CLOCK_50),
    .arduino_command(arduino_command),
    .manual_on(manual_on),
    .auto_on(auto_on)
);

manual_mode manual_mode_u0(
    .clk(CLOCK_50),
    .arduino_command(arduino_command),
    .manual_on(manual_on),
    .w(w),
    .s(s),
    .a(a),
    .d(d),
    .wa(wa),
    .wd(wd),
    .as(as),
    .ds(ds),
    .stop(stop)
);

always_comb begin
    if (stop) begin
       move_cmd = 4'b1000;  // 对应停止操作
    end else if (wa) begin
       move_cmd = 4'b0001;  // 左转 - wa
	end else if (wd) begin
		move_cmd = 4'b0010;  // 右转 - wd
	end else if (as) begin
		move_cmd = 4'b0110;  // 倒退左转 - as
	end else if (ds) begin
		move_cmd = 4'b0111;  // 倒退右转 - sd
	end else if (w) begin
		move_cmd = 4'b0000;  // 前进 - w
	end else if (s) begin
		move_cmd = 4'b0011;  // 倒退 - s
	end else if (a) begin
		move_cmd = 4'b0100;  // 逆时针原地旋转 - a
	end else if (d) begin
		move_cmd = 4'b0101;  // 顺时针原地旋转 - d
	end else begin
		move_cmd = 4'b1000;  // 默认停止
	end
end

always_ff @(posedge CLOCK_50) begin
	if (arduino_command == 8'b11110000) begin
		servo <= 1;
	end else if (arduino_command == 8'b11000000) begin
		servo <= 0;
	end
end

uart_comm #(
    .CLKS_PER_BIT(50_000_000/115_200) 
) uart_u0 (
        .clk(CLOCK_50),                               
        .rst(~KEY[0]),     
		.move_cmd(move_cmd),
		.speed_level(1),
        .valid(rx_valid),             
        .ready(),             
        .uart_out(GPIO[5])        
    );

arduino_uart_buffer u_rx(
	.clk_50(CLOCK_50), 
	.reset(~KEY[0]), 
	.arduino_input(GPIO[3]),
	.arduino_data(arduino_command), 
	.valid(rx_valid),
	.ready(1)
);

pwm_generator pwm_u0 (
		.clk(CLOCK_50),
		.SW(servo),
		.pwm_out(GPIO[9])
	);

endmodule
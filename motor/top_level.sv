module top_level (
   input logic				CLOCK_50,					// DE2-115's 50MHz clock signal
	input logic 			reset,
	input w, a, s, d, wa, wd, as, sd, stop,
	input logic [3:0] speed_level,
   inout logic	[5:0]		GPIO                // 3-TX - from robot 5-RX - to robot
	); 
	
	localparam valid = 1;
	logic move_cmd = 4'b0000;

	always_comb begin
		 if (stop) begin
			  move_cmd = 4'b1000;  // 对应停止操作
		 end else if (wa) begin
			  move_cmd = 4'b0001;  // 左转 - wa
		 end else if (wd) begin
			  move_cmd = 4'b0010;  // 右转 - wd
		 end else if (as) begin
			  move_cmd = 4'b0110;  // 倒退左转 - as
		 end else if (sd) begin
			  move_cmd = 4'b0111;  // 倒退右转 - sd
		 end else if (w) begin
			  move_cmd = 4'b0000;  // 前进 - w
		 end else if (s) begin
			  move_cmd = 4'b0011;  // 倒退 - s
		 end else if (a) begin
			  move_cmd = 4'b0100;  // 逆时针原地旋转 - a
		 end else if (d) begin
			  move_cmd = 4'b0101;  // 顺时针原地旋转 - d
		 end else if (stop) begin
			  move_cmd = 4'b1000;  // 停止 - stop
		 end else begin
			  move_cmd = 4'b1000;  // 默认停止
		 end
	end

	
    uart_comm #(
        .CLKS_PER_BIT(50_000_000/115_200) 
    ) uart_inst (
        .clk(CLOCK_50),                               
        .rst(reset),     
		.move_cmd(move_cmd),
		.speed_level(speed_level),
        .valid(valid),             
        .ready(),             
        .uart_out(GPIO[5])        
    );
endmodule

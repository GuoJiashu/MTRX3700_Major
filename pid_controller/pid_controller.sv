module pid_controller #(
   parameter integer K_P = 14,   // 放大比例系数
   parameter integer K_I = 0,   // 放大积分系数
   parameter integer K_D = 0    // 放大微分系数
)(
   input logic clk,                  
   input logic rst,                  
   input logic signed [31:0] error,  
   input logic error_ready,   
	output logic cmd_valid,
   output logic signed [31:0] controller_output
);

   // 定义中间变量
   logic signed [31:0] error_prev;   // 前一个时刻的误差
   logic signed [31:0] I;            // 积分项
   logic signed [31:0] D;            // 微分项
   logic signed [31:0] P;            // 比例项
	logic signed [31:0] output_temp;
	logic cmd_valid_d
	;
	assign cmd_valid_d = error_ready;
	
   always_ff @(posedge clk or posedge rst) begin
      if (rst) begin
         error_prev <= 32'd0;
         P <= 32'd0;
         I <= 32'd0;
         D <= 32'd0;
      end else if (error_ready) begin
         // P
         P <= K_P * error;  // 放大比例系数

         // I (可以考虑在此处加上限/下限)
         I <= I + error;

         // D
         D <= error - error_prev;

         // Update
         error_prev <= error;
			cmd_valid <= cmd_valid_d;
      end
   end
	
	assign output_temp = (P + I*K_I + D*K_D) / 1000; // max magnitude = 2640, divided by 264 to make sure with in the range of 0 to 10
   assign controller_output = (output_temp < -5) ? -5: (output_temp > 5) ? 5 : output_temp;  // 缩小到0到10

endmodule

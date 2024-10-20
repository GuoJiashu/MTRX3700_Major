module pid_controller #(
    parameter integer Kp = 1,         
    parameter integer Ki = 0,         
    parameter integer Kd = 0          
)(
    input logic clk,                  
    input logic rst,                  
    input logic signed [31:0] error, 
    input logic error_ready,          
    input logic [3:0] speed_level,    // 速度级别0-9
    output logic signed [15:0] control_output  
);

    // 定义中间变量
    logic signed [31:0] error_prev;   // 前一个时刻的误差
    logic signed [31:0] integral;     // 积分项
    logic signed [15:0] derivative;   // 微分项
    logic signed [15:0] proportional; // 比例项
    logic signed [15:0] control_signal; // PID控制信号

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            error_prev <= 16'd0;
            integral <= 32'd0;
            control_output <= 16'd0;
        end else if (error_ready) begin
            // P
            proportional <= Kp * error;

            // I
            integral <= integral + error;

            // D
            derivative <= error - error_prev;

            // Update
            error_prev <= error;

            // PID输出
            control_signal <= (proportional + Ki * integral + Kd * derivative);

            control_output <= control_signal * (speed_level + 1); //？？这里不太确定
        end
    end
endmodule

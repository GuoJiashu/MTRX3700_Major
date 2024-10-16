module pwm_generator (
    input clk,                // FPGA 时钟 (50MHz)
    input [7:0] angle,        // 输入的舵机角度（0-180度）
    output reg pwm_out,       // 输出的PWM信号
    output reg [19:0] counter,  // 将计数器作为输出端口
    output reg [19:0] duty     // 将占空比（脉宽）作为输出端口
);

    reg [19:0] period = 1000000; // 20ms的周期，50MHz对应1,000,000个时钟周期x

    // 定义脉宽范围 (50MHz时钟频率下)
    parameter MIN_DUTY = 50000;   // 对应1ms (0度)
    parameter MAX_DUTY = 100000;  // 对应2ms (180度)

    // 根据角度计算脉宽
    always @(posedge clk) begin
        // 将角度从0~180度映射到脉宽从MIN_DUTY到MAX_DUTY之间
        duty <= MIN_DUTY + (angle * (MAX_DUTY - MIN_DUTY) / 180);
    end

    // 生成PWM信号
    always @(posedge clk) begin
        if (counter < period) begin
            counter <= counter + 1;  // 计数到期
        end else begin
            counter <= 0;  // 重置计数器
        end

        // 生成PWM波形：当计数器值小于duty时，输出高电平，否则低电平
        if (counter < duty) begin
            pwm_out <= 1;
        end else begin
            pwm_out <= 0;
        end
    end
endmodule
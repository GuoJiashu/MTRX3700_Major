module pwm_generator (
    input logic clk,                // FPGA 时钟 (50MHz)
    input logic [7:0] angle,        // 输入的舵机角度（0-180度）
    output logic pwm_out            // 输出的PWM信号
);

    logic [19:0] counter = 0;       // 定义计数器作为内部逻辑
    logic [19:0] duty;              // 定义占空比作为内部逻辑
    logic [19:0] period = 1000000;  // 20ms的周期，50MHz对应1,000,000个时钟周期

    // 定义脉宽范围 (50MHz时钟频率下)
    parameter int MIN_DUTY = 50000;   // 对应1ms (0度)
    parameter int MAX_DUTY = 100000;  // 对应2ms (180度)

    // 根据角度计算脉宽
    always_ff @(posedge clk) begin
        // 将角度从0~180度映射到脉宽从MIN_DUTY到MAX_DUTY之间
        duty <= MIN_DUTY + ((angle * (MAX_DUTY - MIN_DUTY)) / 180);
    end

    // 生成PWM信号
    always_ff @(posedge clk) begin
        if (counter == period - 1) begin
            counter <= 0;  // 重置计数器
        end else begin
            counter <= counter + 1;  // 计数到期
        end

        // 生成PWM波形：当计数器值小于duty时，输出高电平，否则低电平
        pwm_out <= (counter < duty) ? 1'b1 : 1'b0;
    end
endmodule
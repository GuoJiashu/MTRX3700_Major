`timescale 1ns/1ps

module mode_select_tb;

    // Inputs
    reg clk;
    reg [7:0] arduino_command;

    // Outputs
    wire manual_on;
    wire auto_on;

    // Instantiate the Unit Under Test (UUT)
    mode_select uut (
        .clk(clk),
        .arduino_command(arduino_command),
        .manual_on(manual_on),
        .auto_on(auto_on)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 生成周期为10ns的时钟信号
    end

    // Test stimulus
    initial begin
        
        $dumpfile("waveform.vcd");
        $dumpvars();
        // 初始化输入信号
        arduino_command = 8'b00000000; // 初始命令
        #10; // 等待时钟上升沿

        // 模块应从 Initialise 状态转移到 Manual 状态
        #10;
        if (uut.current_state != uut.Manual) $display("Error: Did not transition to Manual state from Initialise.");

        // 检查 manual_on 是否有效
        if (manual_on !== 1) $display("Error: manual_on should be 1 in Manual state.");

        // 发送命令切换到 Auto 模式
        arduino_command = 8'b11111111; // 切换到 Auto 模式的命令
        #10; // 等待状态转移

        // 检查是否进入 Auto 状态
        if (uut.current_state != uut.Auto) $display("Error: Did not transition to Auto state from Manual.");

        // 检查 auto_on 是否有效
        if (auto_on !== 1) $display("Error: auto_on should be 1 in Auto state.");

        // 发送命令切换回 Manual 模式
        arduino_command = 8'b00000000; // 切换回 Manual 模式的命令
        #10; // 等待状态转移

        // 检查是否回到 Manual 状态
        if (uut.current_state != uut.Manual) $display("Error: Did not transition back to Manual state from Auto.");

        // 检查 manual_on 是否再次有效
        if (manual_on !== 1) $display("Error: manual_on should be 1 in Manual state.");

        // 测试完成，结束仿真
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | arduino_command=%b | manual_on=%b | auto_on=%b | State=%s",
            $time, arduino_command, manual_on, auto_on, uut.current_state.name());
    end

endmodule
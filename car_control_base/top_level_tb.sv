`timescale 1ns/1ps

module top_level_tb;

    // 输入信号
    reg CLOCK_50;

    // 实例化待测模块（Unit Under Test，UUT）
    top_level uut (
        .CLOCK_50(CLOCK_50)
    );

    // 时钟信号生成
    initial begin
        CLOCK_50 = 0;
        forever #10 CLOCK_50 = ~CLOCK_50; // 生成周期为20ns的50MHz时钟
    end

    // 测试激励
    initial begin

        $dumpfile("waveform.vcd");
        $dumpvars();
        // 等待系统稳定
        #100;

        uut.arduino_command = 8'b00000000; // 初始化为0
        #20;

        // 模拟进入手动模式
        uut.arduino_command = 8'b00000000;
        #20;

        // 模拟前进命令
        uut.arduino_command = 8'b00000001;
        #50;

        // 模拟后退命令
        uut.arduino_command = 8'b00000100;
        #50;

        // 模拟左转命令
        uut.arduino_command = 8'b00000010;
        #50;

        // 模拟右转命令
        uut.arduino_command = 8'b00001000;
        #50;

        // 模拟左前命令
        uut.arduino_command = 8'b00000011;
        #50;

        // 模拟右前命令
        uut.arduino_command = 8'b00001001;
        #50;

        // 模拟左后命令
        uut.arduino_command = 8'b00000101;
        #50;

        // 模拟右后命令
        uut.arduino_command = 8'b00001100;
        #50;

        // 模拟切换到自动模式
        uut.arduino_command = 8'b11111111;
        #50;

        // 模拟停止命令
        uut.arduino_command = 8'b00000000;
        #50;

        // 结束仿真
        $finish;
    end

    // 输出监视
    initial begin
        $monitor("Time=%0t | arduino_command=%b | manual_on=%b | auto_on=%b | w=%b, s=%b, a=%b, d=%b, wa=%b, wd=%b, as=%b, ds=%b, stop=%b",
            $time, uut.arduino_command, uut.manual_on, uut.auto_on, uut.w, uut.s, uut.a, uut.d, uut.wa, uut.wd, uut.as, uut.ds, uut.stop);
    end

endmodule
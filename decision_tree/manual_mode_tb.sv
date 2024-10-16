`timescale 1ns/1ps

module manual_mode_tb;

    // Inputs
    reg clk;
    reg [7:0] arduino_command;
    reg manual_on;

    // Outputs
    wire w, s, a, d, wa, wd, as, ds, stop;

    // Instantiate the Unit Under Test (UUT)
    manual_mode uut (
        .clk(clk),
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

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 时钟周期为10ns
    end

    // Test stimulus
    initial begin
        
        $dumpfile("waveform.vcd");
        $dumpvars();
        // 初始化输入
        arduino_command = 8'b00000000;
        manual_on = 0;

        // 等待全局复位完成
        #10;

        // 打开手动模式
        manual_on = 1;
        #10;

        // 测试前进命令
        arduino_command = 8'b00000001; // Forward
        #20;

        // 测试后退命令
        arduino_command = 8'b00000100; // Backward
        #20;

        // 测试左转命令
        arduino_command = 8'b00000010; // Left
        #20;

        // 测试右转命令
        arduino_command = 8'b00001000; // Right
        #20;

        // 测试左前命令
        arduino_command = 8'b00000011; // Left Forward
        #20;

        // 测试右前命令
        arduino_command = 8'b00001001; // Right Forward
        #20;

        // 测试左后命令
        arduino_command = 8'b00000101; // Left Backward
        #20;

        // 测试右后命令
        arduino_command = 8'b00001100; // Right Backward
        #20;

        // 测试停止命令
        arduino_command = 8'b00000000; // Stop
        #20;

        // 关闭手动模式
        manual_on = 0;
        #20;

        // 结束仿真
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t | arduino_command=%b | manual_on=%b | State=%s | w=%b, s=%b, a=%b, d=%b, wa=%b, wd=%b, as=%b, ds=%b, stop=%b",
            $time, arduino_command, manual_on, uut.current_state.name(), w, s, a, d, wa, wd, as, ds, stop);
    end

endmodule
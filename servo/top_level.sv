module top_level(
    input CLOCK_50,  // FPGA 时钟 (50MHz)
    inout GPIO[9:0]
);

logic [7:0] angle = 8'd90;

pwm_generator pwm_inst (
    .clk(CLOCK_50),
    .angle(angle),
    .pwm_out(GPIO[9])
);
    
endmodule
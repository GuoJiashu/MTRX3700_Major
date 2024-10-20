module top_level(
    input CLOCK_50,
    inout GPIO[9:0],
	 input SW[17:0]
);

pwm_generator pwm_inst (
    .clk(CLOCK_50),
	 .SW(SW[0]),
    .pwm_out(GPIO[9])
);
    
endmodule

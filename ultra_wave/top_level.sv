module top_level(
	input CLOCK_50,
	inout [35:0] GPIO,
	input [3:0] KEY,
	output [7:0] LEDG,
	output [17:10] LEDR
);

logic reset;
logic echo, trigger;

assign echo = GPIO[34];
assign GPIO[35] = trigger;

logic [10:0] counter;
debounce enable(
  .clk(CLOCK_50),
  .button(!KEY[0]),

  .button_edge(enable)
);
debounce reset_edge(
    .clk(CLOCK_50),
	 .button(!KEY[2]),
    .button_edge(reset)
);

sensor_driver u0(
  .clk(CLOCK_50),
  .rst(reset),
  .enable(enable),
  .echo(echo),
  .trig(trigger),
	.LEDG(LEDG[7:0]),
  .distance_out(LEDR));
  
endmodule

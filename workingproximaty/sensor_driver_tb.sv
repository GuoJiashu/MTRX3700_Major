module sensor_driver_tb();

parameter CLK_PERIOD = 20;

logic clk;
logic echo;
logic trigger;
logic reset;
logic [7:0] LEDR;
logic enable;


sensor_driver u0(
	.clk(clk),
	.echo(echo),
	.enable(enable),
	.rst(reset),
	.trig(trigger),
	.distance(LEDR)
);


initial clk = 1'b0;

always begin
    #10 
	 clk = ~clk;
end
  
 initial begin
	reset = 1;
	echo = 0;
	enable = 0;

	$dumpfile("waveform.vcd");
	$dumpvars();
	#(1 * CLK_PERIOD)
	LEDR = 0;

	#(10 * CLK_PERIOD)
	reset = 0;
	#(10 * CLK_PERIOD)
	enable = 1;
	
	#(100 * CLK_PERIOD)
	enable = 0;
	#(500 * CLK_PERIOD)
	echo = 1;
	#(1000 * CLK_PERIOD)
	
	#(10 * CLK_PERIOD)
	echo = 0;
	
	#(10 * CLK_PERIOD)
	echo = 1;
	#(5000 * CLK_PERIOD)
	
	#(10 * CLK_PERIOD)
	echo = 0;
	
	#(10 * CLK_PERIOD)
	echo = 1;
	#(10000 * CLK_PERIOD)
	
	#(1 * CLK_PERIOD)
	echo = 0;
	
	#(10 * CLK_PERIOD)

	$finish();
  end
endmodule
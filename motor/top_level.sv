module top_level (
   input logic				CLOCK_50,					// DE2-115's 50MHz clock signal
	input logic 			reset,
	input logic [17:0] 	SW,
   inout logic	[5:0]		GPIO                // 3-TX - from robot 5-RX - to robot
	); 
	
	localparam valid = 1;
	localparam neg_l = 1;
	localparam neg_r = 0;


    uart_comm #(
        .CLKS_PER_BIT(50_000_000/115_200) 
    ) uart_inst (
        .clk(CLOCK_50),            
        .SW(SW),                   
        .rst(0),                 
		  .neg_l(neg_l),
		  .neg_r(neg_r),
        .valid(valid),             
        .ready(),             
        .uart_out(GPIO[5])        
    );
endmodule
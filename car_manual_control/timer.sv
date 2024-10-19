module timer #(parameter TIMER_PERIOD = 2, CLK_FREQUENCY = 50_000_000)(
	input clk,
	input reset,
	
	output timer_triggered
);
	int clk_counts;
	int second_counts = TIMER_PERIOD;
	
	always_ff @(posedge clk)begin
		if (reset) begin
			clk_counts <= 0;
			second_counts <= 0;
		end
		else begin
			if (clk_counts == CLK_FREQUENCY-1) begin
				if (second_counts < TIMER_PERIOD-1) begin
					second_counts += 1;
					clk_counts <= 0;
				end
			end
			else clk_counts += 1;
		end
	end
	
	assign timer_triggered = (second_counts == TIMER_PERIOD-1);
endmodule 
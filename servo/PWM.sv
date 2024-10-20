module pwm_generator (
    input clk,
	input SW,
    output logic pwm_out
);

    logic [19:0] counter = 0;
    logic [19:0] duty;
    logic [19:0] period = 1000000;
	logic [7:0] angle = 8'd0;

    parameter int MIN_DUTY = 50000;
    parameter int MAX_DUTY = 100000;

    always_ff @(posedge clk) begin
        duty <= MIN_DUTY + ((angle * (MAX_DUTY - MIN_DUTY)) / 180);
    end

    always_ff @(posedge clk) begin
        if (counter == period - 1) begin
            counter <= 0;
        end else begin
            counter <= counter + 1;
        end

        pwm_out <= (counter < duty) ? 1'b1 : 1'b0;
    end
	 
	 always_comb begin
		 if (SW) begin
			 angle = 8'd210;
		 end else begin
			 angle = 8'd0;
		 end
	 end
endmodule

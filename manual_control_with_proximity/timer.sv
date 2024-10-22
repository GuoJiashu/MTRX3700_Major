module timer #(parameter TIMER_PERIOD = 2, CLK_FREQUENCY = 50_000_000)(
    input clk,
    input reset,
    output timer_triggered
);
    int total_counts;
    localparam TOTAL_CYCLES = TIMER_PERIOD * CLK_FREQUENCY;

    always_ff @(posedge clk) begin
        if (reset) begin
            total_counts <= 0;
        end else if (total_counts == TOTAL_CYCLES - 1) begin
            total_counts <= 0;
        end else begin
            total_counts <= total_counts + 1;
        end
    end

    assign timer_triggered = (total_counts == TOTAL_CYCLES - 1);
endmodule
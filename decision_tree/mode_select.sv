module mode_select(
    input  clk,
    input  arduino_command,
    output manual_on,
    output auto_on
);

typedef enum logic [2:0] { Initialise, Manual, Auto } state_type;
state_type current_state = Initialise, next_state;

always_comb begin
    case (current_state)
        Initialise: begin
            if (arduino_command == 8'b00000000) begin
                next_state = Manual;
            end else begin
                next_state = Initialise;
            end
        end
        Manual: begin
            if (arduino_command == 8'b11111111) begin
                next_state = Auto;
            end else begin
                next_state = Manual;
            end
        end
        Auto: begin
            if (arduino_command == 8'b00000000) begin
                next_state = Manual;
            end else begin
                next_state = Auto;
            end
        end
        default: begin
            next_state = Initialise;
        end
        
    endcase
end

always_ff @(posedge clk) begin
    current_state <= next_state;
end

assign manual_on = (current_state == Manual);
assign auto_on = (current_state == Auto);
    
endmodule
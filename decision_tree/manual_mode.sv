module manual_mode(
    input  clk,
    input  arduino_command,
    input  manual_on,
    output w, a, s, d, wa, wd, as, ad, stop
);

typedef enum logic [9:0] { Initialise, Forward, Backward, Left, Right, Left_forward, Right_forward, Left_backward, Right_backward, Stop } state_type;
state_type current_state = Initialise, next_state;

always_comb begin
    case(current_state)
        Initialise: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Forward: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Backward: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Left: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Right: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Left_forward: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Right_forward: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Left_backward: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
        Right_backward: begin
            if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010) && manual_on) begin
                next_state = Forward;
            end else if ((arduino_command == 8'b00000100) && manual_on) begin
                next_state = Backward;
            end else if ((arduino_command == 8'b00000010) && manual_on) begin
                next_state = Left;
            end else if ((arduino_command == 8'b00001000) && manual_on) begin
                next_state = Right;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_forward;
            end else if ((arduino_command == 8'b00001001) && manual_on) begin
                next_state = Right_forward;
            end else if ((arduino_command == 8'b00000011) && manual_on) begin
                next_state = Left_backward;
            end else if ((arduino_command == 8'b00001100) && manual_on) begin
                next_state = Right_backward;
            end else if ((arduino_command == 8'b00000000) && manual_on) begin
                next_state = Stop;
            end else begin
                next_state = Stop;
            end
        end
    endcase
end

always_ff begin
    current_state <= next_state;
end

assign w = (current_state = Forward);
assign s = (current_state = Backward);
assign a = (current_state = Left);
assign d = (current_state = Right);
assign wa = (current_state = Left_forward);
assign wd = (current_state = Right_forward);
assign as = (current_state = Left_backward);
assign sd = (current_state = Right_backward);
    
endmodule
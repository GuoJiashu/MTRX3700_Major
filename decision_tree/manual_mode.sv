module manual_mode(
    input  clk,
    input  arduino_command,
    output w, a, s, d, wa, wd, as, ad, stop
);

typedef enum logic [9:0] { Initialise, Forward, Backward, Left, Right, Left_forward, Right_forward, Left_backward, Right_backward, Stop } state_type;
state_type current_state = Initialise, next_state;

always_comb begin
    case(current_state)
        Initialise: begin
            if (arduino_command == 8'b00000001 || arduino_command == 8'b00001010) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000 || arduino_command == 8'b00000101) begin
                next_state = Stop;
            end else begin
                next_state = Initialise;
            end
        end
        Forward: begin
            if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000) begin
                next_state = Stop;
            end else if ()
            else begin
                next_state = Forward;
            end
        end
        Backward: begin
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000) begin
                next_state = Stop;
            end else begin
                next_state = Backward;
            end
        end
        Left: begin
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000) begin
                next_state = Stop;
            end else begin
                next_state = Initialise;
            end
        end
        Right: begin
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000) begin
                next_state = Stop;
            end else begin
                next_state = Right;
            end
        end
        Left_forward begin:
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000) begin
                next_state = Stop;
            end else begin
                next_state = Left_forward;
            end
        end
        Right_forward begin:
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000 || arduino_command == 8'b00000101) begin
                next_state = Stop;
            end else begin
                next_state = Right_forward;
            end
        end
        Left_backward begin:
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else if (arduino_command == 8'b00000000) begin
                next_state = Stop;
            end else begin
                next_state = Left_backward;
            end
        end
        Right_backward begin:
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00000000) begin
                next_state = Stop;
            end else begin
                next_state = Right_backward;
            end
        end
        Stop begin:
            if (arduino_command == 8'b00000001) begin
                next_state = Forward;
            end else if (arduino_command == 8'b00000100) begin
                next_state = Backward;
            end else if (arduino_command == 8'b00000010) begin
                next_state = Left;
            end else if (arduino_command == 8'b00001000) begin
                next_state = Right;
            end else if (arduino_command == 8'b00000011) begin
                next_state = Left_forward;
            end else if (arduino_command == 8'b00001001) begin
                next_state = Right_forward;
            end else if (arduino_command == 8'b00000110) begin
                next_state = Left_backward;
            end else if (arduino_command == 8'b00001100) begin
                next_state = Right_backward;
            end else begin
                next_state = Initialise;
            end
        end
    endcase
end

always_ff begin
    current_state <= next_state;
end

assign w = (current_state = Forward);
assign a = (current_state = Left);
assign s = (current_state = Backward);
assign d = (current_state = Right);
assign wa = (current_state = Left_forward);
assign wd = (current_state = Right_forward);
assign as = (current_state = Left_backward);
assign sd = (current_state = Right_backward);
    
endmodule
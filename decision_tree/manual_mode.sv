module manual_mode(
    input  clk,
    input  [7:0] arduino_command,
    input  manual_on,
    output w, s, a, d, wa, wd, as, ds, stop
);

typedef enum logic [3:0] { Forward, Backward, Left, Right, Left_forward, Right_forward, Left_backward, Right_backward, Stop } state_type;
state_type current_state = Forward, next_state;

always_comb begin
    if ((arduino_command == 8'b00000001 || arduino_command == 8'b00001010))
        next_state = Forward;
    else if ((arduino_command == 8'b00000100))
        next_state = Backward;
    else if ((arduino_command == 8'b00000010))
        next_state = Left;
    else if ((arduino_command == 8'b00001000))
        next_state = Right;
    else if ((arduino_command == 8'b00000011))
        next_state = Left_forward;
    else if ((arduino_command == 8'b00001001))
        next_state = Right_forward;
    else if ((arduino_command == 8'b00000101))
        next_state = Left_backward;
    else if ((arduino_command == 8'b00001100))
        next_state = Right_backward;
    else if ((arduino_command == 8'b00000000))
        next_state = Stop;
    else
        next_state = Stop;
end

always_ff @(posedge clk) begin
    current_state <= next_state;
end

assign w = ((current_state == Forward) && (manual_on));
assign s = ((current_state == Backward) && (manual_on));
assign a = ((current_state == Left) && (manual_on));
assign d = ((current_state == Right) && (manual_on));
assign wa = ((current_state == Left_forward) && (manual_on));
assign wd = ((current_state == Right_forward) && (manual_on));
assign as = ((current_state == Left_backward) && (manual_on));
assign ds = ((current_state == Right_backward) && (manual_on));
assign stop = ((current_state == Stop) && (manual_on));
    
endmodule
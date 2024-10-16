module top_level(
    input CLOCK_50
);

logic [7:0] arduino_command = 8'b00000000; 
logic manual_on = 0, auto_on = 0;
logic w = 0, s = 0, a = 0, d = 0, wa = 0, wd = 0, as = 0, ds = 0, stop = 0;

mode_select mode_select_u0(
    .clk(CLOCK_50),
    .arduino_command(arduino_command),
    .manual_on(manual_on),
    .auto_on(auto_on)
);

manual_mode manual_mode_u0(
    .clk(CLOCK_50),
    .arduino_command(arduino_command),
    .manual_on(manual_on),
    .w(w),
    .s(s),
    .a(a),
    .d(d),
    .wa(wa),
    .wd(wd),
    .as(as),
    .ds(ds),
    .stop(stop)
);
    
endmodule
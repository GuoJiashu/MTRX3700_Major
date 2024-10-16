module top_level(
    input CLOCK_50,
    inout GPIO
);

logic arduino_command[7:0] = 8'b00000000, manual_on = 0, auto_on = 0;
logic w = 0, a = 0, s = 0, d = 0, wa = 0, wd = 0, as = 0, ad = 0, stop = 0;

mode_select mode_select_u0(
    .clk(CLOCK_50),
    .arduino_command(arduino_command),
    .manual_on(manual_on),
    .auto_on(auto_on)
);

manual_mode manual_mode_u0(
    .clk(CLOCK_50),
    .arduino_command(arduino_command),
    .manual_on(manual_on)
    .w(w),
    .a(a),
    .s(s),
    .d(d),
    .wa(wa),
    .wd(wd),
    .as(as),
    .ad(ad),
    .stop(stop)
);
    
endmodule
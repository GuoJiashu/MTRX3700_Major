module pixel_filter (
	 input clk,
    input logic [11:0] pixel_in,  // rddata R4:G4:B4
    input logic pixel_signal,
    input logic [17:0] sw,        // 0 - brightness，1 - threshold
    output logic [11:0] pixel_out
);

    // Brightness adjust parameter
    parameter BRIGHTNESS_ADJUST = 4'd2; 
//	 parameter THRESHOLD = 8'h80;
    // Perform weighted sum
    logic [11:0] Y_temp=0;  // Temporary for intermediate result
	 logic [7:0]  Y=0;
	 logic [11:0] Y_r=0;
	 logic [11:0] Y_g=0;
	 logic [11:0] Y_b=0;

	 logic [15:0] Cb_temp=0;
	 logic [7:0]  Cb=0;
	 logic [15:0] Cb_r=0;
	 logic [15:0] Cb_g=0;
	 logic [15:0] Cb_b=0;
	 
	 logic [15:0] Cr_temp=0;
	 logic [7:0]  Cr=0;
	 logic [15:0] Cr_r=0;
	 logic [15:0] Cr_g=0;
	 logic [15:0] Cr_b=0;	 
	 
	 logic [11:0] pixel_adj=0;
	 logic [11:0] pixel_y=0;
	 logic [7:0] r888=0;
	 logic [7:0] g888=0;
	 logic [7:0] b888=0; 

    always @(*) begin
		 	if (sw[0] == 1 && pixel_signal) begin
            // Brightness adj
            pixel_adj[11:8] = (pixel_in[11:8] + BRIGHTNESS_ADJUST < 4'h2) ? 4'hF : pixel_in[11:8] + BRIGHTNESS_ADJUST; // R
            pixel_adj[7:4]  = (pixel_in[7:4]  + BRIGHTNESS_ADJUST < 4'h2) ? 4'hF : pixel_in[7:4]  + BRIGHTNESS_ADJUST; // G
            pixel_adj[3:0]  = (pixel_in[3:0]  + BRIGHTNESS_ADJUST < 4'h2) ? 4'hF : pixel_in[3:0]  + BRIGHTNESS_ADJUST; // B
        end else
				pixel_adj = pixel_in;
	 
	 	  if (sw[1] == 1 && pixel_signal) begin
				// Threshold adj
            if ((pixel_adj[11:8] + pixel_adj[7:4] + pixel_adj[3:0]) > 6'b011000) begin
                pixel_out = 12'hFFF;  // white
            end else begin
                pixel_out = 12'h000;  // black
            end
				
        end else if (sw[2] == 1 && pixel_signal) begin
				r888 = 8'd17 * pixel_in[11:8];
				g888 = 8'd17 * pixel_in[7:4];
				b888 = 8'd17 * pixel_in[3:0];
				
				// Y  = 0.299R +0.587G + 0.114B
            // Grayscale, Divide by 100 (approximation) to get final Y value
//				Cb_r = 8'd43 * r888;
//				Cb_g = 8'd85 * g888;
//				Cb_b = 8'd128 * b888;
//				
//				Cb_temp = 16'd32768 + Cb_b - Cb_r - Cb_g;
//				Cb = Cb_temp[15:8];
//
//				Cr_r = 8'd128 * r888;
//				Cr_g = 8'd107 * g888;
//				Cr_b = 8'd21 * b888;
//				
//				Cr_temp = 16'd32768 + Cr_r - Cr_g - Cr_b;
//				Cr = Cr_temp[15:8];				
				
				Y = 16+(((r888<<6)+(r888<<1)+(g888<<7)+g888+(b888<<4)+(b888<<3)+b888)>>8);
            Cb = 128 + ((-((r888<<5)+(r888<<2)+(r888<<1))-((g888<<6)+(g888<<3)+(g888<<1))+(b888<<7)-(b888<<4))>>8);
            Cr = 128 + (((r888<<7)-(r888<<4)-((g888<<6)+(g888<<5)-(g888<<1))-((b888<<4)+(b888<<1)))>>8);
				
				// Threshold adj - blue
            if (Y > 20 && Y < 80 && Cb > 180 && Cr > 80 && Cr < 140) begin
                pixel_out = pixel_adj;  // original bits
            end else begin
                pixel_out = 12'h000;  // black
            end
				
        end else if (sw[3] == 1 && pixel_signal) begin
				r888 = 8'd17 * pixel_in[11:8];
				g888 = 8'd17 * pixel_in[7:4];
				b888 = 8'd17 * pixel_in[3:0];
				
				Y = 16+(((r888<<6)+(r888<<1)+(g888<<7)+g888+(b888<<4)+(b888<<3)+b888)>>8);
            Cb = 128 + ((-((r888<<5)+(r888<<2)+(r888<<1))-((g888<<6)+(g888<<3)+(g888<<1))+(b888<<7)-(b888<<4))>>8);
            Cr = 128 + (((r888<<7)-(r888<<4)-((g888<<6)+(g888<<5)-(g888<<1))-((b888<<4)+(b888<<1)))>>8);
				
				// Threshold adj - red
            if (Y > 50 && Y < 110 && Cr > 180 && Cb > 60 && Cb < 120) begin
                pixel_out = pixel_adj;  // original bits
            end else begin
                pixel_out = 12'h000;  // black
            end
				
        end else if (sw[4] == 1 && pixel_signal) begin
				r888 = 8'd17 * pixel_in[11:8];
				g888 = 8'd17 * pixel_in[7:4];
				b888 = 8'd17 * pixel_in[3:0];
				
				Y = 16+(((r888<<6)+(r888<<1)+(g888<<7)+g888+(b888<<4)+(b888<<3)+b888)>>8);
            Cb = 128 + ((-((r888<<5)+(r888<<2)+(r888<<1))-((g888<<6)+(g888<<3)+(g888<<1))+(b888<<7)-(b888<<4))>>8);
            Cr = 128 + (((r888<<7)-(r888<<4)-((g888<<6)+(g888<<5)-(g888<<1))-((b888<<4)+(b888<<1)))>>8);
				
				// Threshold adj - green
            if (Y > 110 && Y < 170 && Cr < 60 && Cb > 20 && Cb < 80) begin
                pixel_out = pixel_adj;  // original bits
            end else begin
                pixel_out = 12'h000;  // black
            end
				
        end else
				pixel_out = pixel_adj;		 
		 
    end

		 
endmodule

//--------------------------------------------
//RGB 888 to YCbCr

/********************************************************
            RGB888 to YCbCr
 Y  = 0.299R +0.587G + 0.114B
 Cb = 0.568(B-Y) + 128 = -0.172R-0.339G + 0.511B + 128
 CR = 0.713(R-Y) + 128 = 0.511R-0.428G -0.083B + 128

 Y  = (77 *R    +    150*G    +    29 *B)>>8
 Cb = (-43*R    -    85 *G    +    128*B)>>8 + 128
 Cr = (128*R    -    107*G    -    21 *B)>>8 + 128

 Y  = (77 *R    +    150*G    +    29 *B        )>>8
 Cb = (-43*R    -    85 *G    +    128*B + 32768)>>8
 Cr = (128*R    -    107*G    -    21 *B + 32768)>>8
*********************************************************/

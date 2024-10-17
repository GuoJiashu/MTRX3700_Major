module pixel_filter_tb;

    // Inputs
    logic clk;
    logic [11:0] pixel_in;
    logic pixel_signal;
    logic [17:0] sw;

    // Output
    logic [11:0] pixel_out;

    // Instantiate the Unit Under Test (UUT)
    pixel_filter uut (
        .clk(clk),
        .pixel_in(pixel_in),
        .pixel_signal(pixel_signal),
        .sw(sw),
        .pixel_out(pixel_out)
    );

    // Clock generation
    always #5 clk = ~clk;  // 10ns clock period

    initial begin
        // Initialize Inputs
        clk = 0;
        pixel_in = 12'h0;  // Initial RGB input
        pixel_signal = 0;
        sw = 18'h0;        // Set all switches to 0 initially
        
        // Wait for the global reset
        #10;
        
        // Test 1: Set SW[2] to 1, simulating RGB input and checking YCbCr conversion and thresholding
        sw[2] = 1;   // Enable YCbCr conversion mode
        
        // Simulate a pixel signal
        pixel_signal = 1;

        // Case 1: RGB = (255, 0, 0) -> Expect to detect red
        pixel_in = 12'hF00;  // Red pixel
        #10;  // Wait for 10ns to simulate the processing delay
        $display("Test Red Pixel: pixel_out = %h", pixel_out);

        // Case 2: RGB = (0, 255, 0) -> Expect no red, output black
        pixel_in = 12'h0F0;  // Green pixel
        #10;
        $display("Test Green Pixel: pixel_out = %h", pixel_out);

        // Case 3: RGB = (0, 0, 255) -> Expect no red, output black
        pixel_in = 12'h00F;  // Blue pixel
        #10;
        $display("Test Blue Pixel: pixel_out = %h", pixel_out);

        // Case 4: RGB = (128, 128, 128) -> Grayscale, expect no color detection, output black
        pixel_in = 12'h888;  // Gray pixel
        #10;
        $display("Test Gray Pixel: pixel_out = %h", pixel_out);

        // Case 5: RGB = (255, 255, 0) -> Expect some threshold detection, yellow pixel
        pixel_in = 12'hFF0;  // Yellow pixel
        #10;
        $display("Test Yellow Pixel: pixel_out = %h", pixel_out);

        // Stop simulation
        $stop;
    end
endmodule

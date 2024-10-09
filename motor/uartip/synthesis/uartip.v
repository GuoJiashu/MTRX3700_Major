// uartip.v

// Generated using ACDS version 20.1 711

`timescale 1 ps / 1 ps
module uartip (
		input  wire        clk_clk,                               //                        clk.clk
		input  wire        reset_reset_n,                         //                      reset.reset_n
		input  wire        rs232_0_avalon_rs232_slave_address,    // rs232_0_avalon_rs232_slave.address
		input  wire        rs232_0_avalon_rs232_slave_chipselect, //                           .chipselect
		input  wire [3:0]  rs232_0_avalon_rs232_slave_byteenable, //                           .byteenable
		input  wire        rs232_0_avalon_rs232_slave_read,       //                           .read
		input  wire        rs232_0_avalon_rs232_slave_write,      //                           .write
		input  wire [31:0] rs232_0_avalon_rs232_slave_writedata,  //                           .writedata
		output wire [31:0] rs232_0_avalon_rs232_slave_readdata,   //                           .readdata
		input  wire        rs232_0_external_interface_RXD,        // rs232_0_external_interface.RXD
		output wire        rs232_0_external_interface_TXD,        //                           .TXD
		output wire        rs232_0_interrupt_irq                  //          rs232_0_interrupt.irq
	);

	wire    rst_controller_reset_out_reset; // rst_controller:reset_out -> rs232_0:reset

	uartip_rs232_0 rs232_0 (
		.clk        (clk_clk),                               //                clk.clk
		.reset      (rst_controller_reset_out_reset),        //              reset.reset
		.address    (rs232_0_avalon_rs232_slave_address),    // avalon_rs232_slave.address
		.chipselect (rs232_0_avalon_rs232_slave_chipselect), //                   .chipselect
		.byteenable (rs232_0_avalon_rs232_slave_byteenable), //                   .byteenable
		.read       (rs232_0_avalon_rs232_slave_read),       //                   .read
		.write      (rs232_0_avalon_rs232_slave_write),      //                   .write
		.writedata  (rs232_0_avalon_rs232_slave_writedata),  //                   .writedata
		.readdata   (rs232_0_avalon_rs232_slave_readdata),   //                   .readdata
		.irq        (rs232_0_interrupt_irq),                 //          interrupt.irq
		.UART_RXD   (rs232_0_external_interface_RXD),        // external_interface.export
		.UART_TXD   (rs232_0_external_interface_TXD)         //                   .export
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~reset_reset_n),                 // reset_in0.reset
		.clk            (clk_clk),                        //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule

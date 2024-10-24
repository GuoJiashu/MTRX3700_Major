module sensor_driver#(
    parameter F_CLK = 50_000_000, // 时钟频率 50 MHz
    parameter T_PULSE = 10, // 10 μs
    parameter TEN_US = (F_CLK * T_PULSE) / 1_000_000 // 500
)(
    input clk,
    input rst,
    input echo,
    input enable,
    output [15:0] distance_out, // 扩展至16位
    output [7:0] LEDG,
    output trig
);
    
    localparam IDLE = 3'b000,
               TRIGGER = 3'b010,
               WAIT = 3'b011,
               COUNTECHO = 3'b100,
               DISPLAY_DISTANCE = 3'b101;
    
    wire inIDLE, inTRIGGER, inWAIT, inCOUNTECHO, inDISPLAY;
    reg [9:0] counter;
    reg [21:0] distanceRAW = 0; // cycles in COUNTECHO
    reg [31:0] distanceRAW_in_cm = 0;
    wire trigcountDONE, counterDONE;
    
    logic [2:0] state;
    logic measure;
    
    // Ready
    assign ready = inIDLE;
    
    // Decode states
    assign inIDLE = (state == IDLE);
    assign inTRIGGER = (state == TRIGGER);
    assign inWAIT = (state == WAIT);
    assign inCOUNTECHO = (state == COUNTECHO);
    assign inDISPLAY = (state == DISPLAY_DISTANCE);    
    
    // LED 状态显示
    always_comb begin 
        if (rst) begin
            LEDG = 8'b0000_0000;
        end else if (inIDLE) begin
            LEDG = 8'b0000_0001;
        end else if (inTRIGGER) begin
            LEDG = 8'b0000_0010;
        end else if (inWAIT) begin 
            LEDG = 8'b0000_0100;
        end else if (inCOUNTECHO) begin
            LEDG = 8'b0000_1000;
        end else if (inDISPLAY) begin
            LEDG = 8'b0001_0000;
        end else begin 
            LEDG = 8'b1111_1111;
        end 
    end 
    
    // 计时器用于复位
    reg [24:0] reset_counter;
    logic reset;
    
    always @(posedge clk) begin 
        if (reset_counter == 25'd30_500_600) begin
            reset_counter <= 0;
        end else begin
            reset_counter <= reset_counter + 1;
        end
    end
    assign reset = (reset_counter == 25'd30_500_600) ? 1 : 0;
    
 
    // 测量信号始终有效
    assign measure = 1;
    logic display;
    
    // DISPLAY 状态的计数器
    reg [24:0] display_counter;
    always @(posedge clk) begin
        if(inDISPLAY) begin
            if(display_counter == 25'd27_000_000)
                display_counter <= 25'd0;
            else
                display_counter <= display_counter + 1;
        end
    end
    assign display = (display_counter == 25'd27_000_000) ? 1 : 0;
    
    // 状态转换
    always @(posedge clk) begin
        if (reset | rst) begin
            state <= IDLE;
        end else begin
            case(state)
                IDLE: begin
                    state <= (measure) ? TRIGGER : state;
                end
                TRIGGER: begin
                    state <= (trigcountDONE) ? WAIT : state;
                end
                WAIT: begin
                    state <= (echo) ? COUNTECHO : state;
                end
                COUNTECHO: begin
                    state <= (echo) ? state : DISPLAY_DISTANCE;
                end
                DISPLAY_DISTANCE: begin
                    state <= (display) ? IDLE : state;
                end
                default: state <= IDLE;
            endcase
        end
    end
    
    // Trigger 信号
    assign trig = inTRIGGER;
    
    // 触发信号计数器
    always @(posedge clk) begin
        if(inIDLE) begin
            counter <= 10'd0;
        end else begin
            counter <= counter + 1;
        end
    end
    assign trigcountDONE = (counter == TEN_US);
    
    // 回波信号计数
    always @(posedge clk) begin
        if(inWAIT) begin
            distanceRAW <= 22'd0;
        end else if (distanceRAW == 22'h3FFFFF) begin 
            distanceRAW <= 22'h3FFFFF;
        end else begin
            distanceRAW <= distanceRAW + {21'd0, inCOUNTECHO};
        end
    end
    
    // 距离计算（修正后的乘数）
    always @(posedge clk) begin
       	if(inDISPLAY) begin
			distanceRAW_in_cm <= distanceRAW * 32'h1648;
		end
	end
    
    assign distance_out = distanceRAW_in_cm[31:24]; // 使用高16位
    
endmodule

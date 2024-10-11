module uart_comm #(
	 parameter CLKS_PER_BIT = 3//(50_000_000/115_200)
)(
    input clk,
	 input [17:0] SW,
	 input rst,
	 input neg_l,		// left negative flag
	 input neg_r,		// right negative flag
	 // input speed_l,
	 // input speed_r,
    input valid,               // 当有数据要发送时置高
    output ready,              // UART准备好发送时置高
    output uart_out            // UART输出，连接到GPIO[5]
);
    // 定义待发送的16进制字符
    logic [7:0] data_mem [0:23];  // 24个字符，包含完整的JSON字符串
    logic [4:0] index=0;            // 发送字符的索引
    logic [7:0] data_tx=0;          // 当前发送的字符数据
    logic sending = 0;                // 标志是否正在发送
	 logic baud_trigger = 0;
	 logic [17:0] SW_prev;         // 保存上一个SW状态
    logic SW_changed;             // 标志SW是否变化

    // Init JSON DATA：{"T":1.0,"L":0.5,"R":0.5}
    initial begin
        data_mem[0]  = 8'h7B;  // '{'
        data_mem[1]  = 8'h22;  // '"'
        data_mem[2]  = 8'h54;  // 'T'
        data_mem[3]  = 8'h22;  // '"'
        data_mem[4]  = 8'h3A;  // ':'
        data_mem[5]  = 8'h31;  // '1'
        data_mem[6]  = 8'h2C;  // ','
        data_mem[7]  = 8'h22;  // '"'
        data_mem[8]  = 8'h4C;  // 'L'
        data_mem[9]  = 8'h22;  // '"'
        data_mem[10] = 8'h3A;  // ':'
		  // place for negative sign (left)
        data_mem[11] = 8'h30;  // '0'
        data_mem[12] = 8'h2E;  // '.'
        data_mem[13] = 8'h35;  // '5'
        data_mem[14] = 8'h2C;  // ','
        data_mem[15] = 8'h22;  // '"'
        data_mem[16] = 8'h52;  // 'R'
        data_mem[17] = 8'h22;  // '"'
        data_mem[18] = 8'h3A;  // ':'
		  // place for negative sign (right)
        data_mem[19] = 8'h30;  // '0'
        data_mem[20] = 8'h2E;  // '.'
        data_mem[21] = 8'h35;  // '5'
        data_mem[22] = 8'h7D;  // '}'
		  data_mem[23] = 8'h0A;	 // '\n'
    end

    // UART module
    uart_tx #(
        .CLKS_PER_BIT(CLKS_PER_BIT),  		// BAUD
        .BITS_N(8),
        .PARITY_TYPE(0)                     // No parity bit
    ) uart_instance (
        .clk(clk),
        .rst(rst),
        .data_tx(data_tx),                  // 当前发送的字符
        .uart_out(uart_out),                // 连接到GPIO[5]
        .valid(sending),
        .ready(ready),
		  .baud_trigger(baud_trigger)
    );

	logic ready_trigger;

    // 状态机，控制数据逐字节发送
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            index <= 0;
            sending <= 0;
            data_tx <= 8'h00;
				ready_trigger <= 0;
				SW_prev <= SW;        // 初始化SW_prev
        end else begin
				SW_prev <= SW;
				// 检测SW变化
				if (SW != SW_prev) begin
					SW_changed <= 1;
					//SW_prev <= SW;    // 更新SW_prev
				end else begin
					SW_changed <= 0;
				end
			
				ready_trigger <= ready;  // 保存之前的 ready 状态
				// Preprocess (change speed)
				if (SW[0] == 1) begin		// forward / backward
					data_mem[11] <= 8'h31;  // 1.0
					data_mem[13] <= 8'h30;
		         data_mem[19] <= 8'h31;  // 1.0
					data_mem[21] <= 8'h30;  
				end else if (SW[1] == 1) begin	// turn left
					data_mem[11] <= 8'h31;  // 1.0
					data_mem[13] <= 8'h30;
		         data_mem[19] <= 8'h30;  // 0.0
					data_mem[21] <= 8'h30; 
				end else if (SW[2] == 1) begin	// turn right
					data_mem[11] <= 8'h30;  // 0.0
					data_mem[13] <= 8'h30;
		         data_mem[19] <= 8'h31;  // 1.0
					data_mem[21] <= 8'h30; 
				end else begin							// stop
					data_mem[11] <= 8'h30;  // 0.0
					data_mem[13] <= 8'h30;
		         data_mem[19] <= 8'h30;  // 0.0
					data_mem[21] <= 8'h30; 
				end
				
				// 当检测到SW变化时，重新开始发送
				if (SW_changed || (valid && ready && !ready_trigger)) begin  
					if (!neg_l && !neg_r) begin 							// Normal forward
					// 开始发送数据
						if (index < 24) begin
							 sending <= 1;
							 data_tx <= data_mem[index];  // 发送当前字符
							 index <= index + 1;          // 索引增加，指向下一个字符
						end else if (index >= 24) begin
							 sending <= 0;                // 23位数据发送完毕
							 index <= 0;                  // 复位索引
							 data_tx <= 8'h00;
						end
					end else if (neg_l && neg_r) begin 					// 二轮倒退
						if (index == 11 || index == 20) begin
							 sending <= 1;
							 data_tx <= 8'h2D;  				// 发送负号
							 index <= index + 1;          
						end else if (index >=26) begin
							 sending <= 0;                // 25位数据发送完毕
							 index <= 0;                  // 复位索引
							 data_tx <= 8'h00;
						end else if (index > 20) begin
							 sending <= 1;
							 data_tx <= data_mem[index-2];// 已插入了两个负号，索引-2
							 index <= index + 1;          
						end else if (index > 11) begin
							 sending <= 1;
							 data_tx <= data_mem[index-1];// 已插入了一个负号，索引-1
							 index <= index + 1;          
						end else begin
							 sending <= 1;
							 data_tx <= data_mem[index];  // 发送当前字符
							 index <= index + 1;          // 索引增加，指向下一个字符
						end
					end else if (neg_l) begin 								// 仅左轮倒退
						if (index == 11) begin
							 sending <= 1;
							 data_tx <= 8'h2D;  				// 发送负号
							 index <= index + 1;          // 索引增加，指向下一个字符
						end else if (index >= 25) begin
							 sending <= 0;                // 24位数据发送完毕
							 index <= 0;                  
							 data_tx <= 8'h00;
						end else if (index > 11) begin
							 sending <= 1;
							 data_tx <= data_mem[index-1];// 已插入了一个负号，索引-1
							 index <= index + 1;          
						end else begin
							 sending <= 1;
							 data_tx <= data_mem[index];  // 发送当前字符
							 index <= index + 1;          // 索引增加，指向下一个字符
						end
					end else if (neg_r) begin 								// 仅右轮倒退
						if (index == 20) begin
							 sending <= 1;
							 data_tx <= 8'h2D;  				// 发送负号
							 index <= index + 1;          
						end else if (index >=25) begin
							 sending <= 0;                // 24位数据发送完毕
							 index <= 0;                  
							 data_tx <= 8'h00;
						end else if (index >= 20) begin
							 sending <= 1;
							 data_tx <= data_mem[index-1];// 已插入了1个负号，索引-1
							 index <= index + 1;          
						end else begin
							 sending <= 1;
							 data_tx <= data_mem[index];  // 发送当前字符
							 index <= index + 1;          // 索引增加，指向下一个字符
						end
					end
						
			  end else begin
					sending <= 0;  // If valid & ready is low, no sending
			  end
		  end
    end
endmodule

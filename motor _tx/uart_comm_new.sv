module uart_comm #(
	 parameter CLKS_PER_BIT = 3//50_000_000/115_200
)(
    input clk,
	input rst,
	input [3:0] move_cmd,	   // wasd wa as wd sd stop
	input [3:0] speed_level,
    input valid,               // 当有数据要发送时置高
    output ready,              // UART准备好发送时置高
    output uart_out            // UART输出，连接到GPIO[5]
);
    // 定义待发送的16进制字符
    logic [7:0] data_mem [0:23];  // 24个字符，包含完整的JSON字符串
    logic [4:0] index=0;          // 发送字符的索引
    logic [7:0] data_tx=0;        // 当前发送的字符数据
    logic sending = 0;            // 标志是否正在发送
	logic baud_trigger = 0;
	logic sent = 0;
	 
	logic [3:0] SW_prev;         // 保存上一个SW状态
    logic SW_changed;             // 标志SW是否变化
	logic [3:0] spd_prev;         // 保存上一个速度状态
    logic spd_changed;             // 标志速度是否变化
	 
	logic neg_l = 0;
	logic neg_r = 0;

    // Init JSON DATA：{"T":1,"L":0.5,"R":0.5}
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
		data_mem[23] = 8'h0A;  // '\n'
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
			SW_prev <= move_cmd;        // 初始化SW_prev
			spd_prev <= speed_level;
			sent <= 0;
        end else begin
				SW_prev <= move_cmd;			// 更新SW_prev
				spd_prev <= speed_level;
				// 检测move_cmd变化
				if (move_cmd != SW_prev) begin
					SW_changed <= 1;
					sent <= 0;
				end else begin
					SW_changed <= 0;
				end
			
				if (speed_level != spd_prev) begin
					spd_changed <= 1;
					sent <= 0;
				end else begin
					spd_changed <= 0;
				end
			
				ready_trigger <= ready;  // 保存之前的 ready 状态
				
				// 设置速度和负号
				if (move_cmd == 4'b0000) begin 					// 前进 - 0 - w
					neg_l <= 0;
					neg_r <= 0;
					data_mem[13] <= 8'h30 + speed_level;
					data_mem[21] <= 8'h30 + speed_level;
				end else if (move_cmd == 4'b0001) begin		// 左转 - 1 - wa
					neg_l <= 0;
					neg_r <= 0;
					data_mem[13] <= 8'h30;		// 左轮不动
					data_mem[21] <= 8'h30 + speed_level;
				end else if (move_cmd == 4'b0010) begin		// 右转 - 2 - wd
					neg_l <= 0;
					neg_r <= 0;
					data_mem[13] <= 8'h30 + speed_level;		
					data_mem[21] <= 8'h30; 		// 右轮不动
				end else if (move_cmd == 4'b0011) begin		// 倒退 - 3 - s
					neg_l <= 1;
					neg_r <= 1;
					data_mem[13] <= 8'h30 + speed_level;		
					data_mem[21] <= 8'h30 + speed_level; 		
				end else if (move_cmd == 4'b0100) begin		// 逆时针原地旋转 - 4 - a
					neg_l <= 1;
					neg_r <= 0;
					data_mem[13] <= 8'h30 + speed_level;		
					data_mem[21] <= 8'h30 + speed_level; 		
				end else if (move_cmd == 4'b0101) begin		// 顺时针原地旋转 - 5 - d
					neg_l <= 0;
					neg_r <= 1;
					data_mem[13] <= 8'h30 + speed_level;		
					data_mem[21] <= 8'h30 + speed_level; 		
				end else if (move_cmd == 4'b0110) begin		// 倒退左转 - 6 - as
					neg_l <= 0;
					neg_r <= 1;
					data_mem[13] <= 8'h30;		// 左轮不动
					data_mem[21] <= 8'h30 + speed_level;
				end else if (move_cmd == 4'b0111) begin		// 倒退右转 - 7 - sd
					neg_l <= 1;
					neg_r <= 0;
					data_mem[13] <= 8'h30 + speed_level;		
					data_mem[21] <= 8'h30; 		// 右轮不动
				end else begin											// default - 停止
					neg_l <= 0;
					neg_r <= 0;
					data_mem[13] <= 8'h30;		
					data_mem[21] <= 8'h30; 		
				end 

		
				// 当检测到SW变化时，重新开始发送
				if (sent || SW_changed || spd_changed || (valid && ready && !ready_trigger)) begin 
					if (sent) begin
						sent <= 0;
					end
					
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
							 sent <= 1;
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
							 sent <= 1;
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
							 sent <= 1;
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
						if (index == 19) begin
							 sending <= 1;
							 data_tx <= 8'h2D;  				// 发送负号
							 index <= index + 1;          
						end else if (index >=25) begin
							 sending <= 0;                // 24位数据发送完毕
							 index <= 0;                  
							 data_tx <= 8'h00;
							 sent <= 1;
						end else if (index >= 19) begin
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

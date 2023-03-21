module FFT_8(
    clk,
    rst_n,
    
    // input real part 
    x_r_0,x_r_1,x_r_2,x_r_3,x_r_4,x_r_5,x_r_6,x_r_7,
    
    //input img part
    x_i_0,x_i_1,x_i_2,x_i_3,x_i_4,x_i_5,x_i_6, x_i_7,
    
    // output real part 
    y_r_0,y_r_1,y_r_2,y_r_3,y_r_4,y_r_5,y_r_6,y_r_7,
    
    // output img part 
    y_i_0,y_i_1,y_i_2,y_i_3,y_i_4,y_i_5,y_i_6,y_i_7,
    

);

    input clk;
    input rst_n;
    
    //The input occupies 5 bits, and the sampling value of 0~15 can be input under the condition of keeping the highest bit as 0
    input signed [4:0] x_r_0;
    input signed [4:0] x_r_1;
    input signed [4:0] x_r_2;
    input signed [4:0] x_r_3;
    input signed [4:0] x_r_4;
    input signed [4:0] x_r_5;
    input signed [4:0] x_r_6;
    input signed [4:0] x_r_7;

    input signed [4:0] x_i_0;
    input signed [4:0] x_i_1;
    input signed [4:0] x_i_2;
    input signed [4:0] x_i_3;
    input signed [4:0] x_i_4;
    input signed [4:0] x_i_5;
    input signed [4:0] x_i_6;
    input signed [4:0] x_i_7;
    
    //The output occupies 7 bits
    output reg signed [6:0] y_r_0;
    output reg signed [6:0] y_r_1;
    output reg signed [6:0] y_r_2;
    output reg signed [6:0] y_r_3;
    output reg signed [6:0] y_r_4;
    output reg signed [6:0] y_r_5;
    output reg signed [6:0] y_r_6;
    output reg signed [6:0] y_r_7;

    output reg signed [6:0] y_i_0;
    output reg signed [6:0] y_i_1;
    output reg signed [6:0] y_i_2;
    output reg signed [6:0] y_i_3;
    output reg signed [6:0] y_i_4;
    output reg signed [6:0] y_i_5;
    output reg signed [6:0] y_i_6;
    output reg signed [6:0] y_i_7;
    
    //parameter storage register, store coefficient
    //w_r_*indates the real part of the coefficient(cos value)
    reg [3:0] w_r_0;
    reg [3:0] w_r_1;
    reg [3:0] w_r_2;
    reg [3:0] w_r_3;
    
    //w_i_*indates the img part of the coefficient（sin value）
    reg [3:0] w_i_0;
    reg [3:0] w_i_1;
    reg [3:0] w_i_2;
    reg [3:0] w_i_3;
    
   //temp register
    reg signed [11:0] x_r_tmp_0;
    reg signed [11:0] x_r_tmp_1;
    reg signed [11:0] x_r_tmp_2;
    reg signed [11:0] x_r_tmp_3;
    reg signed [11:0] x_r_tmp_4;
    reg signed [11:0] x_r_tmp_5;
    reg signed [11:0] x_r_tmp_6;
    reg signed [11:0] x_r_tmp_7;
    
    reg signed [11:0] x_i_tmp_0;
    reg signed [11:0] x_i_tmp_1;
    reg signed [11:0] x_i_tmp_2;
    reg signed [11:0] x_i_tmp_3;
    reg signed [11:0] x_i_tmp_4;
    reg signed [11:0] x_i_tmp_5;
    reg signed [11:0] x_i_tmp_6;
    reg signed [11:0] x_i_tmp_7;
    
    //temp register for prevent comflix 
    reg signed [11:0] x_r_tmp_last_0;
    reg signed [11:0] x_r_tmp_last_1;
    reg signed [11:0] x_r_tmp_last_2;
    reg signed [11:0] x_r_tmp_last_3;
    reg signed [11:0] x_r_tmp_last_4;
    reg signed [11:0] x_r_tmp_last_5;
    reg signed [11:0] x_r_tmp_last_6;
    reg signed [11:0] x_r_tmp_last_7;
    
    reg signed [11:0] x_i_tmp_last_0;
    reg signed [11:0] x_i_tmp_last_1;
    reg signed [11:0] x_i_tmp_last_2;
    reg signed [11:0] x_i_tmp_last_3;
    reg signed [11:0] x_i_tmp_last_4;
    reg signed [11:0] x_i_tmp_last_5;
    reg signed [11:0] x_i_tmp_last_6;
    reg signed [11:0] x_i_tmp_last_7;
    
    //state machine
    reg [3:0] state_machine;
    localparam state_start = 4'd0;        //所有寄存器初始化
    localparam state_input = 4'd1;        //中间寄存器获取输入采样值
    localparam state_s1    = 4'd2;        //中间保持寄存器暂存数据过程
    localparam state_s2    = 4'd3;        //第一次蝶形乘法
    localparam state_s3    = 4'd4;        //中间保持寄存器暂存数据过程
    localparam state_s4    = 4'd5;        //第一次蝶形加法
    localparam state_s5    = 4'd6;        //中间保持寄存器暂存数据过程
    localparam state_s6    = 4'd7;        //第二次蝶形乘法
    localparam state_s7    = 4'd9;        //中间保持寄存器暂存数据过程
    localparam state_s8    = 4'd10;        //第二次蝶形加法
    localparam state_s9    = 4'd11;        //中间保持寄存器暂存数据过程
    localparam state_s10   = 4'd12;        //第三次蝶形乘法
    localparam state_s11   = 4'd13;        //中间保持寄存器暂存数据过程
    localparam state_s12   = 4'd14;        //第三次蝶形加法
    localparam state_end   = 4'd15;        //输出计算结果
    
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            w_r_0 = 4'd0;
            w_r_1 = 4'd0;
            w_r_2 = 4'd0;
            w_r_3 = 4'd0;
            
            w_i_0 = 4'd0;
            w_i_1 = 4'd0;
            w_i_2 = 4'd0;
            w_i_3 = 4'd0;
            
            x_r_tmp_0 <= 12'd0;
            x_r_tmp_1 <= 12'd0;
            x_r_tmp_2 <= 12'd0;
            x_r_tmp_3 <= 12'd0;
            x_r_tmp_4 <= 12'd0;
            x_r_tmp_5 <= 12'd0;
            x_r_tmp_6 <= 12'd0;
            x_r_tmp_7 <= 12'd0;
            
            x_i_tmp_0 <= 12'd0;
            x_i_tmp_1 <= 12'd0;
            x_i_tmp_2 <= 12'd0;
            x_i_tmp_3 <= 12'd0;
            x_i_tmp_4 <= 12'd0;
            x_i_tmp_5 <= 12'd0;
            x_i_tmp_6 <= 12'd0;
            x_i_tmp_7 <= 12'd0;
            
            x_r_tmp_last_0 <= 12'd0;
            x_r_tmp_last_1 <= 12'd0;
            x_r_tmp_last_2 <= 12'd0;
            x_r_tmp_last_3 <= 12'd0;
            x_r_tmp_last_4 <= 12'd0;
            x_r_tmp_last_5 <= 12'd0;
            x_r_tmp_last_6 <= 12'd0;
            x_r_tmp_last_7 <= 12'd0;
                           
            x_i_tmp_last_0 <= 12'd0;
            x_i_tmp_last_1 <= 12'd0;
            x_i_tmp_last_2 <= 12'd0;
            x_i_tmp_last_3 <= 12'd0;
            x_i_tmp_last_4 <= 12'd0;
            x_i_tmp_last_5 <= 12'd0;
            x_i_tmp_last_6 <= 12'd0;
            x_i_tmp_last_7 <= 12'd0;
            
            y_r_0 <= 7'd0;
            y_r_1 <= 7'd0;
            y_r_2 <= 7'd0;
            y_r_3 <= 7'd0;
            y_r_4 <= 7'd0;
            y_r_5 <= 7'd0;
            y_r_6 <= 7'd0;
            y_r_7 <= 7'd0;
            
            y_i_0 <= 7'd0;
            y_i_1 <= 7'd0;
            y_i_2 <= 7'd0;
            y_i_3 <= 7'd0;
            y_i_4 <= 7'd0;
            y_i_5 <= 7'd0;
            y_i_6 <= 7'd0;
            y_i_7 <= 7'd0;
            
            state_machine <= state_start;
        end
        else case(state_machine)
            
            state_start: begin
                //输入旋转因子，其中cos值分别为10、7、0、-7
                //因此，在遇到与w_r_3相乘时，需要加上负号
                w_r_0 <= 4'd10;
                w_r_1 <= 4'd7;
                w_r_2 <= 4'sd0;
                w_r_3 <= 4'd7;
                //sin值分别为0、-7、-10、-7
                //因此，在与w_i_1、w_i_2和w_i_3相乘时，需要加上负号
                w_i_0 <= 4'd0;
                w_i_1 <= 4'd7;
                w_i_2 <= 4'd10;
                w_i_3 <= 4'd7;
                
                state_machine <= state_input;
            end
            
            state_input: begin
                x_r_tmp_0 <= x_r_0;
                x_r_tmp_1 <= x_r_4;
                x_r_tmp_2 <= x_r_2;
                x_r_tmp_3 <= x_r_6;
                x_r_tmp_4 <= x_r_1;
                x_r_tmp_5 <= x_r_5;
                x_r_tmp_6 <= x_r_3;
                x_r_tmp_7 <= x_r_7;
                
                x_i_tmp_0 <= x_i_0;
                x_i_tmp_1 <= x_i_4;
                x_i_tmp_2 <= x_i_2;
                x_i_tmp_3 <= x_i_6;
                x_i_tmp_4 <= x_i_1;
                x_i_tmp_5 <= x_i_5;
                x_i_tmp_6 <= x_i_3;
                x_i_tmp_7 <= x_i_7;
                
                state_machine <= state_s1;
            end
            
            state_s1: begin
                x_r_tmp_last_0 <= x_r_tmp_0;
                x_r_tmp_last_1 <= x_r_tmp_1;
                x_r_tmp_last_2 <= x_r_tmp_2;
                x_r_tmp_last_3 <= x_r_tmp_3;
                x_r_tmp_last_4 <= x_r_tmp_4;
                x_r_tmp_last_5 <= x_r_tmp_5;
                x_r_tmp_last_6 <= x_r_tmp_6;
                x_r_tmp_last_7 <= x_r_tmp_7;
                
                x_i_tmp_last_0 <= x_i_tmp_0;
                x_i_tmp_last_1 <= x_i_tmp_1;
                x_i_tmp_last_2 <= x_i_tmp_2;
                x_i_tmp_last_3 <= x_i_tmp_3;
                x_i_tmp_last_4 <= x_i_tmp_4;
                x_i_tmp_last_5 <= x_i_tmp_5;
                x_i_tmp_last_6 <= x_i_tmp_6;
                x_i_tmp_last_7 <= x_i_tmp_7;
                
                state_machine <= state_s2;
            end
            
            state_s2: begin
                x_r_tmp_1 <= (x_r_tmp_last_1 * w_r_0 / 10) - (x_i_tmp_last_1 * w_i_0 / 10);
                x_r_tmp_3 <= (x_r_tmp_last_3 * w_r_0 / 10) - (x_i_tmp_last_3 * w_i_0 / 10);
                x_r_tmp_5 <= (x_r_tmp_last_5 * w_r_0 / 10) - (x_i_tmp_last_5 * w_i_0 / 10);
                x_r_tmp_7 <= (x_r_tmp_last_7 * w_r_0 / 10) - (x_i_tmp_last_7 * w_i_0 / 10);
                
                x_i_tmp_1 <= (x_r_tmp_last_1 * w_i_0 / 10) + (x_i_tmp_last_1 * w_r_0 / 10);
                x_i_tmp_3 <= (x_r_tmp_last_3 * w_i_0 / 10) + (x_i_tmp_last_3 * w_r_0 / 10);
                x_i_tmp_5 <= (x_r_tmp_last_5 * w_i_0 / 10) + (x_i_tmp_last_5 * w_r_0 / 10);
                x_i_tmp_7 <= (x_r_tmp_last_7 * w_i_0 / 10) + (x_i_tmp_last_7 * w_r_0 / 10);
                
                state_machine <= state_s3;
            end
            
            state_s3: begin
                x_r_tmp_last_0 <= x_r_tmp_0;
                x_r_tmp_last_1 <= x_r_tmp_1;
                x_r_tmp_last_2 <= x_r_tmp_2;
                x_r_tmp_last_3 <= x_r_tmp_3;
                x_r_tmp_last_4 <= x_r_tmp_4;
                x_r_tmp_last_5 <= x_r_tmp_5;
                x_r_tmp_last_6 <= x_r_tmp_6;
                x_r_tmp_last_7 <= x_r_tmp_7;
                
                x_i_tmp_last_0 <= x_i_tmp_0;
                x_i_tmp_last_1 <= x_i_tmp_1;
                x_i_tmp_last_2 <= x_i_tmp_2;
                x_i_tmp_last_3 <= x_i_tmp_3;
                x_i_tmp_last_4 <= x_i_tmp_4;
                x_i_tmp_last_5 <= x_i_tmp_5;
                x_i_tmp_last_6 <= x_i_tmp_6;
                x_i_tmp_last_7 <= x_i_tmp_7;
                
                state_machine <= state_s4;
            end
            
            state_s4: begin
                x_r_tmp_0 <= x_r_tmp_last_0 + x_r_tmp_last_1;
                x_r_tmp_2 <= x_r_tmp_last_2 + x_r_tmp_last_3;
                x_r_tmp_4 <= x_r_tmp_last_4 + x_r_tmp_last_5;
                x_r_tmp_6 <= x_r_tmp_last_6 + x_r_tmp_last_7;
                
                x_r_tmp_1 <= x_r_tmp_last_0 - x_r_tmp_last_1;
                x_r_tmp_3 <= x_r_tmp_last_2 - x_r_tmp_last_3;
                x_r_tmp_5 <= x_r_tmp_last_4 - x_r_tmp_last_5;
                x_r_tmp_7 <= x_r_tmp_last_6 - x_r_tmp_last_7;
                
                x_i_tmp_0 <= x_i_tmp_last_0 + x_i_tmp_last_1;
                x_i_tmp_2 <= x_i_tmp_last_2 + x_i_tmp_last_3;
                x_i_tmp_4 <= x_i_tmp_last_4 + x_i_tmp_last_5;
                x_i_tmp_6 <= x_i_tmp_last_6 + x_i_tmp_last_7;
                
                x_i_tmp_1 <= x_i_tmp_last_0 - x_i_tmp_last_1;
                x_i_tmp_3 <= x_i_tmp_last_2 - x_i_tmp_last_3;
                x_i_tmp_5 <= x_i_tmp_last_4 - x_i_tmp_last_5;
                x_i_tmp_7 <= x_i_tmp_last_6 - x_i_tmp_last_7;
                
                state_machine <= state_s5;
            end
            
            state_s5: begin
                x_r_tmp_last_0 <= x_r_tmp_0;
                x_r_tmp_last_1 <= x_r_tmp_1;
                x_r_tmp_last_2 <= x_r_tmp_2;
                x_r_tmp_last_3 <= x_r_tmp_3;
                x_r_tmp_last_4 <= x_r_tmp_4;
                x_r_tmp_last_5 <= x_r_tmp_5;
                x_r_tmp_last_6 <= x_r_tmp_6;
                x_r_tmp_last_7 <= x_r_tmp_7;
                
                x_i_tmp_last_0 <= x_i_tmp_0;
                x_i_tmp_last_1 <= x_i_tmp_1;
                x_i_tmp_last_2 <= x_i_tmp_2;
                x_i_tmp_last_3 <= x_i_tmp_3;
                x_i_tmp_last_4 <= x_i_tmp_4;
                x_i_tmp_last_5 <= x_i_tmp_5;
                x_i_tmp_last_6 <= x_i_tmp_6;
                x_i_tmp_last_7 <= x_i_tmp_7;
                
                state_machine <= state_s6;
            end
            
            state_s6: begin
                x_r_tmp_2 <= (x_r_tmp_last_2 * w_r_0 / 10) - (x_i_tmp_last_2 * w_i_0 / 10);
                x_r_tmp_6 <= (x_r_tmp_last_6 * w_r_0 / 10) - (x_i_tmp_last_6 * w_i_0 / 10);
                
                x_r_tmp_3 <= (x_r_tmp_last_3 * w_r_2 / 10) + (x_i_tmp_last_3 * w_i_2 / 10);
                x_r_tmp_7 <= (x_r_tmp_last_7 * w_r_2 / 10) + (x_i_tmp_last_7 * w_i_2 / 10);
                
                x_i_tmp_2 <= (x_i_tmp_last_2 * w_r_0 / 10) + (x_r_tmp_last_2 * w_i_0 / 10);
                x_i_tmp_6 <= (x_i_tmp_last_6 * w_r_0 / 10) + (x_r_tmp_last_6 * w_i_0 / 10);
                
                x_i_tmp_3 <= (x_i_tmp_last_3 * w_r_2 / 10) - (x_r_tmp_last_3 * w_i_2 / 10);
                x_i_tmp_7 <= (x_i_tmp_last_7 * w_r_2 / 10) - (x_r_tmp_last_7 * w_i_2 / 10);
                
                state_machine <= state_s7;
            end
            
            state_s7: begin
                x_r_tmp_last_0 <= x_r_tmp_0;
                x_r_tmp_last_1 <= x_r_tmp_1;
                x_r_tmp_last_2 <= x_r_tmp_2;
                x_r_tmp_last_3 <= x_r_tmp_3;
                x_r_tmp_last_4 <= x_r_tmp_4;
                x_r_tmp_last_5 <= x_r_tmp_5;
                x_r_tmp_last_6 <= x_r_tmp_6;
                x_r_tmp_last_7 <= x_r_tmp_7;
            
                x_i_tmp_last_0 <= x_i_tmp_0;
                x_i_tmp_last_1 <= x_i_tmp_1;
                x_i_tmp_last_2 <= x_i_tmp_2;
                x_i_tmp_last_3 <= x_i_tmp_3;
                x_i_tmp_last_4 <= x_i_tmp_4;
                x_i_tmp_last_5 <= x_i_tmp_5;
                x_i_tmp_last_6 <= x_i_tmp_6;
                x_i_tmp_last_7 <= x_i_tmp_7;
                
                state_machine <= state_s8;
            end
            
            state_s8: begin
                x_r_tmp_0 <= x_r_tmp_last_0 + x_r_tmp_last_2;
                x_r_tmp_1 <= x_r_tmp_last_1 + x_r_tmp_last_3;
                x_r_tmp_4 <= x_r_tmp_last_4 + x_r_tmp_last_6;
                x_r_tmp_5 <= x_r_tmp_last_5 + x_r_tmp_last_7;
                
                x_r_tmp_2 <= x_r_tmp_last_0 - x_r_tmp_last_2;
                x_r_tmp_3 <= x_r_tmp_last_1 - x_r_tmp_last_3;
                x_r_tmp_6 <= x_r_tmp_last_4 - x_r_tmp_last_6;
                x_r_tmp_7 <= x_r_tmp_last_5 - x_r_tmp_last_7;
                
                x_i_tmp_0 <= x_i_tmp_last_0 + x_i_tmp_last_2;
                x_i_tmp_1 <= x_i_tmp_last_1 + x_i_tmp_last_3;
                x_i_tmp_4 <= x_i_tmp_last_4 + x_i_tmp_last_6;
                x_i_tmp_5 <= x_i_tmp_last_5 + x_i_tmp_last_7;
                
                x_i_tmp_2 <= x_i_tmp_last_0 - x_i_tmp_last_2;
                x_i_tmp_3 <= x_i_tmp_last_1 - x_i_tmp_last_3;
                x_i_tmp_6 <= x_i_tmp_last_4 - x_i_tmp_last_6;
                x_i_tmp_7 <= x_i_tmp_last_5 - x_i_tmp_last_7;
                
                state_machine <= state_s9;
            end
            
            state_s9: begin
                x_r_tmp_last_0 <= x_r_tmp_0;
                x_r_tmp_last_1 <= x_r_tmp_1;
                x_r_tmp_last_2 <= x_r_tmp_2;
                x_r_tmp_last_3 <= x_r_tmp_3;
                x_r_tmp_last_4 <= x_r_tmp_4;
                x_r_tmp_last_5 <= x_r_tmp_5;
                x_r_tmp_last_6 <= x_r_tmp_6;
                x_r_tmp_last_7 <= x_r_tmp_7;
            
                x_i_tmp_last_0 <= x_i_tmp_0;
                x_i_tmp_last_1 <= x_i_tmp_1;
                x_i_tmp_last_2 <= x_i_tmp_2;
                x_i_tmp_last_3 <= x_i_tmp_3;
                x_i_tmp_last_4 <= x_i_tmp_4;
                x_i_tmp_last_5 <= x_i_tmp_5;
                x_i_tmp_last_6 <= x_i_tmp_6;
                x_i_tmp_last_7 <= x_i_tmp_7;
                
                state_machine <= state_s10;
            end
            
            state_s10: begin
                x_r_tmp_4 <= (x_r_tmp_last_4 * w_r_0 / 10) - (x_i_tmp_last_4 * w_i_0 / 10);
                x_r_tmp_5 <= (x_r_tmp_last_5 * w_r_1 / 10) + (x_i_tmp_last_5 * w_i_1 / 10);
                x_r_tmp_6 <= (x_r_tmp_last_6 * w_r_2 / 10) + (x_i_tmp_last_6 * w_i_2 / 10);
                x_r_tmp_7 <= -(x_r_tmp_last_7 * w_r_3 / 10) + (x_i_tmp_last_7 * w_i_3 / 10);
                    
                x_i_tmp_4 <= (x_i_tmp_last_4 * w_r_0 / 10) + (x_r_tmp_last_4 * w_i_0 / 10);
                x_i_tmp_5 <= (x_i_tmp_last_5 * w_r_1 / 10) - (x_r_tmp_last_5 * w_i_1 / 10);
                x_i_tmp_6 <= (x_i_tmp_last_6 * w_r_2 / 10) - (x_r_tmp_last_6 * w_i_2 / 10);
                x_i_tmp_7 <= -(x_i_tmp_last_7 * w_r_3 / 10) - (x_r_tmp_last_7 * w_i_3 / 10);
                
                state_machine <= state_s11;
            end
            
            state_s11: begin
                x_r_tmp_last_0 <= x_r_tmp_0;
                x_r_tmp_last_1 <= x_r_tmp_1;
                x_r_tmp_last_2 <= x_r_tmp_2;
                x_r_tmp_last_3 <= x_r_tmp_3;
                x_r_tmp_last_4 <= x_r_tmp_4;
                x_r_tmp_last_5 <= x_r_tmp_5;
                x_r_tmp_last_6 <= x_r_tmp_6;
                x_r_tmp_last_7 <= x_r_tmp_7;
            
                x_i_tmp_last_0 <= x_i_tmp_0;
                x_i_tmp_last_1 <= x_i_tmp_1;
                x_i_tmp_last_2 <= x_i_tmp_2;
                x_i_tmp_last_3 <= x_i_tmp_3;
                x_i_tmp_last_4 <= x_i_tmp_4;
                x_i_tmp_last_5 <= x_i_tmp_5;
                x_i_tmp_last_6 <= x_i_tmp_6;
                x_i_tmp_last_7 <= x_i_tmp_7;
                
                state_machine <= state_s12;
            end
            
            state_s12: begin
                x_r_tmp_0 <= x_r_tmp_last_0 + x_r_tmp_last_4;
                x_r_tmp_1 <= x_r_tmp_last_1 + x_r_tmp_last_5;
                x_r_tmp_2 <= x_r_tmp_last_2 + x_r_tmp_last_6;
                x_r_tmp_3 <= x_r_tmp_last_3 + x_r_tmp_last_7;
                
                x_r_tmp_4 <= x_r_tmp_last_0 - x_r_tmp_last_4;
                x_r_tmp_5 <= x_r_tmp_last_1 - x_r_tmp_last_5;
                x_r_tmp_6 <= x_r_tmp_last_2 - x_r_tmp_last_6;
                x_r_tmp_7 <= x_r_tmp_last_3 - x_r_tmp_last_7;
                
                x_i_tmp_0 <= x_i_tmp_last_0 + x_i_tmp_last_4;
                x_i_tmp_1 <= x_i_tmp_last_1 + x_i_tmp_last_5;
                x_i_tmp_2 <= x_i_tmp_last_2 + x_i_tmp_last_6;
                x_i_tmp_3 <= x_i_tmp_last_3 + x_i_tmp_last_7;
                
                x_i_tmp_4 <= x_i_tmp_last_0 - x_i_tmp_last_4;
                x_i_tmp_5 <= x_i_tmp_last_1 - x_i_tmp_last_5;
                x_i_tmp_6 <= x_i_tmp_last_2 - x_i_tmp_last_6;
                x_i_tmp_7 <= x_i_tmp_last_3 - x_i_tmp_last_7;
                
                state_machine <= state_end;
            end
            
            state_end: begin
                y_i_0 <= (x_i_tmp_0);
                y_i_1 <= (x_i_tmp_1);
                y_i_2 <= (x_i_tmp_2);
                y_i_3 <= (x_i_tmp_3);
                y_i_4 <= (x_i_tmp_4);
                y_i_5 <= (x_i_tmp_5);
                y_i_6 <= (x_i_tmp_6);
                y_i_7 <= (x_i_tmp_7);
            
                y_r_0 <= (x_r_tmp_0);
                y_r_1 <= (x_r_tmp_1);
                y_r_2 <= (x_r_tmp_2);
                y_r_3 <= (x_r_tmp_3);
                y_r_4 <= (x_r_tmp_4);
                y_r_5 <= (x_r_tmp_5);
                y_r_6 <= (x_r_tmp_6);
                y_r_7 <= (x_r_tmp_7);
                
                state_machine <= state_start;
            end             
            
            default: begin
                state_machine <= state_start;
            end
            
        endcase
    end
    
endmodule
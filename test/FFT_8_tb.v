`timescale 1ns / 1ns

`define clock_period 100

`include "FFT_8.v"

module FFT_8_tb;

    reg clk;
    reg rst_n;
    
    reg signed [4:0] x_r_0;
    reg signed [4:0] x_r_1;
    reg signed [4:0] x_r_2;
    reg signed [4:0] x_r_3;
    reg signed [4:0] x_r_4;
    reg signed [4:0] x_r_5;
    reg signed [4:0] x_r_6;
    reg signed [4:0] x_r_7;

    reg signed [4:0] x_i_0;
    reg signed [4:0] x_i_1;
    reg signed [4:0] x_i_2;
    reg signed [4:0] x_i_3;
    reg signed [4:0] x_i_4;
    reg signed [4:0] x_i_5;
    reg signed [4:0] x_i_6;
    reg signed [4:0] x_i_7;


    wire signed [6:0] y_r_0;
    wire signed [6:0] y_r_1;
    wire signed [6:0] y_r_2;
    wire signed [6:0] y_r_3;
    wire signed [6:0] y_r_4;
    wire signed [6:0] y_r_5;
    wire signed [6:0] y_r_6;
    wire signed [6:0] y_r_7;

    wire signed [6:0] y_i_0;
    wire signed [6:0] y_i_1;
    wire signed [6:0] y_i_2;
    wire signed [6:0] y_i_3;
    wire signed [6:0] y_i_4;
    wire signed [6:0] y_i_5;
    wire signed [6:0] y_i_6;
    wire signed [6:0] y_i_7;
    
    FFT_8 FFT_8_Inst(
        .clk(clk),
        .rst_n(rst_n),
        
        .x_r_0(x_r_0),    //input real
        .x_r_1(x_r_1),
        .x_r_2(x_r_2),
        .x_r_3(x_r_3),
        .x_r_4(x_r_4),
        .x_r_5(x_r_5),
        .x_r_6(x_r_6),
        .x_r_7(x_r_7),
        
        .x_i_0(x_i_0),    //input img
        .x_i_1(x_i_1),
        .x_i_2(x_i_2),
        .x_i_3(x_i_3),
        .x_i_4(x_i_4),
        .x_i_5(x_i_5),
        .x_i_6(x_i_6),
        .x_i_7(x_i_7),
        
        .y_r_0(y_r_0),    //output  real
        .y_r_1(y_r_1),
        .y_r_2(y_r_2),
        .y_r_3(y_r_3),
        .y_r_4(y_r_4),
        .y_r_5(y_r_5),
        .y_r_6(y_r_6),
        .y_r_7(y_r_7),
        
        .y_i_0(y_i_0),    //output img
        .y_i_1(y_i_1),
        .y_i_2(y_i_2),
        .y_i_3(y_i_3),
        .y_i_4(y_i_4),
        .y_i_5(y_i_5),
        .y_i_6(y_i_6),
        .y_i_7(y_i_7)
    );
    
    initial clk = 1;
    always #(`clock_period/2) clk = ~clk;
    
    initial begin
        $dumpfile("FFT_8.vcd");
        $dumpvars(0,FFT_8_tb);
    
        rst_n = 1'b0;
        
        x_r_0 = 5'd0;
        x_r_1 = 5'd0;
        x_r_2 = 5'd0;
        x_r_3 = 5'd0;
        x_r_4 = 5'd0;
        x_r_5 = 5'd0;
        x_r_6 = 5'd0;
        x_r_7 = 5'd0;
        
        x_i_0 = 5'd0;    
        x_i_1 = 5'd0;
        x_i_2 = 5'd0;
        x_i_3 = 5'd0;
        x_i_4 = 5'd0;
        x_i_5 = 5'd0;
        x_i_6 = 5'd0;
        x_i_7 = 5'd0;
        
        #(`clock_period*10 + 1);
        
        rst_n = 1'b1;
        
        x_r_0 = 5'b0_1110;
        x_r_1 = 5'b0;
        x_r_2 = 5'b0_0110;
        x_r_3 = 5'b0;
        x_r_4 = 5'b0_0101;
        x_r_5 = 5'b0;
        x_r_6 = 5'b0_1111;
        x_r_7 = 5'b0;
        
        x_i_0 = 5'd0;
        x_i_1 = 5'd0;
        x_i_2 = 5'd0;
        x_i_3 = 5'd0;
        x_i_4 = 5'd0;
        x_i_5 = 5'd0;
        x_i_6 = 5'd0;
        x_i_7 = 5'd0;
        
        #(`clock_period*50);
        
        x_r_0 = 5'b0_0101;
        x_r_1 = 5'b0_0101;
        x_r_2 = 5'b0_0101;
        x_r_3 = 5'b0_0101;
        x_r_4 = 5'b0_0101;
        x_r_5 = 5'b0_0101;
        x_r_6 = 5'b0_0101;
        x_r_7 = 5'b0_0101;
        
        x_i_0 = 5'd0;
        x_i_1 = 5'd0;
        x_i_2 = 5'd0;
        x_i_3 = 5'd0;
        x_i_4 = 5'd0;
        x_i_5 = 5'd0;
        x_i_6 = 5'd0;
        x_i_7 = 5'd0;
        
        #(`clock_period*50);
        
        // $stop;
    end
    
endmodule
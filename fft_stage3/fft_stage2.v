
////////////////
////Thea Zhu///
///////////////

`include "butterfly_1.v"
`include "butterfly_2.v"
`include "delay.v"
`include "complex_mul.v"

module fft_stage2(s0,s1,s2,s3,s4,s5,s6,s7,clk,rst,t0,tr1,ti1,t2,tr3,ti3,t4,tr5,ti5,t6,tr7,ti7);

    parameter N = 4;
                                    
    input [(2**N)-1:0]s0,s1,s2,s3,s4,s5,s6,s7;
    input clk,rst;
    output [(2**N)-1:0] t0,tr1,ti1,t2,tr3,ti3,t4,tr5,ti5,t6,tr7,ti7;  // r indicates real number, i indicates imaginary number
    wire [(2**N)-1:0] y0,y1,y2,y3,y4,yr5,yi5,y6,yr7,yi7;

    butterfly_1 bf1_1(s0,s1,clk,rst,y0,y2);
    butterfly_2 bf2_1(y1,y3,clk,rst,tr1,tr3,ti1,ti3);
    butterfly_1 bf1_2(s4,s5,clk,rst,y4,y6);
    butterfly_2 bf2_2(s6,s7,clk,rst,yr5,yr7,yi5,yi7);

    //synchronize the operations
    delay d1(y0,clk,rst,t0);
    delay d2(y2,clk,rst,t2);
    delay d3(s2,clk,rst,y1);
    delay d4(s3,clk,rst,y3);

    delay d5(y4,clk,rst,t4);
    delay d6(y6,clk,rst,t6);

    complex_mul cm1(yr5,yi5,clk,rst,tr5,ti5);
    complex_mul cm2(yr7,yi7,clk,rst,tr7,ti7);


endmodule
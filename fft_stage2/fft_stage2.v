
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
    wire [(2**N)-1:0] y0,y2,y4,y6,yr5,yi5,yr7,yi7,yr1,yr3,yi1,yi3;

    butterfly_1 bf1_1(s0,s2,clk,rst,y0,y2);
    butterfly_2 bf2_1(s1,s3,clk,rst,yr1,yr3,yi1,yi3);
    butterfly_1 bf1_2(s4,s6,clk,rst,y4,y6);
    butterfly_2 bf2_2(s5,s7,clk,rst,yr5,yr7,yi5,yi7);

    //synchronize the operations
    delay d1(y0,clk,rst,t0);
    delay d2(y3,clk,rst,t3);
    delay d3(y4,clk,rst,t4);
    delay d4(y6,clk,rst,t6);
    delay d5(yr1,clk,rst,tr1);
    delay d6(yi1,clk,rst,ti1);
    delay d7(yr3,clk,rst,tr3);
    delay d8(yi3,clk,rst,ti3);

    complex_mul cm1(yr5,yi5,clk,rst,tr5,ti5);
    complex_mul cm2(yr7,yi7,clk,rst,tr7,ti7);


// .\fft_stage2.v:21: warning: input port a is coerced to inout.
// .\fft_stage2.v:21: warning: input port b is coerced to inout.
// .\fft_stage2.v:21: warning: output port yr1 is coerced to inout.
// .\fft_stage2.v:21: warning: output port yi1 is coerced to inout.
// .\fft_stage2.v:21: warning: output port yi2 is coerced to inout.
// .\fft_stage2.v:23: warning: input port a is coerced to inout.
// .\fft_stage2.v:23: warning: input port b is coerced to inout.
// .\fft_stage2.v:23: warning: output port yr1 is coerced to inout.
// .\fft_stage2.v:23: warning: output port yi1 is coerced to inout.
// .\fft_stage2.v:23: warning: output port yi2 is coerced to inout.
// .\fft_stage2.v:27: warning: Port 1 (a) of delay expects 16 bits, got 1.
// .\fft_stage2.v:27:        : Padding 15 high bits of the port.
// .\fft_stage2.v:27: warning: Port 4 (b) of delay expects 16 bits, got 1.
// .\fft_stage2.v:27:        : Padding 15 high bits of the port.

endmodule
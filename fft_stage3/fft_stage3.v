///////////////
////Thea Zhu///
///////////////

`include "butterfly_1.v"
`include "butterfly_2.v"
`include "delay.v"
`include "complex_mul.v"
                  
module fft_stage3(a0,a1,ar2,ai2,ar3,ai3,a4,a5,ar6,ai6,ar7,ai7,clk,rst,
                y0,yr1,yi1,yr2,yi2,yr3,yi3,y4,yr5,yi5,yr6,yi6,yr7,yi7);

    parameter N = 4;
                                    
    input [(2**N)-1:0]a0,a1,ar2,ai2,ar3,ai3,a4,a5,ar6,ai6,ar7,ai7;// r indicates real number, i indicates imaginary number
    input clk,rst;
    output [(2**N)-1:0]y0,yr1,yi1,yr2,yi2,yr3,yi3,y4,yr5,yi5,yr6,yi6,yr7,yi7;  

    butterfly_1 bf1_1(a0,a1,clk,rst,y0,y4);

    butterfly_1 bf1_real(ar2,ar3,clk,rst,yr5,yr1);// Real part y1,y5
    butterfly_1 bf1_imag(ai2,ai3,clk,rst,yi6,yi2);// imag part y1,y5
    
    butterfly_2 bf2_1(a4,a5,clk,rst,yr2,yr6,yi2,yi6);

    butterfly_1 bf2_real(ar6,ar7,clk,rst,yr7,yr3);// Real part y3,y7
    butterfly_1 bf2_imag(ai6,ai7,clk,rst,yi7,yi3);// imag part y3,y7


endmodule

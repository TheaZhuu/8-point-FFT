
////////////////
////Thea Zhu///
///////////////

// `include "butterfly_1.v"

module fft_stage1(a0,a1,a2,a3,a4,a5,a6,a7,clk,rst,s0,s1,s2,s3,s4,s5,s6,s7);

    parameter N = 4;
                                    
    input [(2**N)-1:0]a0,a1,a2,a3,a4,a5,a6,a7;
    input clk,rst;
    output [(2**N)-1:0] s0,s1,s2,s3,s4,s5,s6,s7;

    butterfly_1 bf1(a0,a4,clk,rst,s0,s1);
    butterfly_1 bf2(a2,a6,clk,rst,s2,s3);
    butterfly_1 bf3(a1,a5,clk,rst,s4,s5);
    butterfly_1 bf4(a3,a7,clk,rst,s6,s7);

endmodule

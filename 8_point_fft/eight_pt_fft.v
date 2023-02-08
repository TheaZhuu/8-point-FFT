///////////////
////Thea Zhu///
///////////////

// `include "fft_stage1.v"
// `include "fft_stage2.v"
// `include "fft_stage3.v"


module eight_pt_fft(a0,a1,a2,a3,a4,a5,a6,a7,clk,rst,
                    y0,yr1,yi1,yr2,yi2,yr3,yi3,y4,yr5,yi5,yr6,yi6,yr7,yi7);

    parameter N = 4;
                                    
    input [(2**N)-1:0]a0,a1,a2,a3,a4,a5,a6,a7;
    input clk,rst;
// r indicates real number, i indicates imaginary number
    output [(2**N)-1:0]y0,yr1,yi1,yr2,yi2,yr3,yi3,y4,yr5,yi5,yr6,yi6,yr7,yi7;     
    wire [(2**N)-1:0]s0,s1,s2,s3,s4,s5,s6,s7;  
    
    wire [(2**N)-1:0]t0,t4, tr1,ti1,tr5,ti5,t2,t6,tr3,ti3,tr7,ti7;
             
    fft_stage1 fs1 (a0,a1,a2,a3,a4,a5,a6,a7,clk,rst,s0,s1,s2,s3,s4,s5,s6,s7);
                 
    fft_stage2 fs2 (s0,s1,s2,s3,s4,s5,s6,s7,clk,rst,t0,tr1,ti1,t2,tr3,ti3,t4,tr5,ti5,t6,tr7,ti7); 
                   
    fft_stage3 fs3 (t0,t4,tr1,ti1,tr5,ti5,t2,t6,tr3,ti3,tr7,ti7,clk,rst
                        y0,yr1,yi1,yr2,yi2,yr3,yi3,y4,yr5,yi5,yr6,yi6,yr7,yi7);


endmodule
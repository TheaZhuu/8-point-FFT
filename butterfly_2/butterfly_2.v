
////////////////
////Thea Zhu///
///////////////

// `include "add_sub.v"
// `include "reg_n.v"


module butterfly_2(a,b,clk,rst,yr1,yr2,yi1,yi2);
    parameter N = 4;
    input  [(2**N)-1:0] a,b;
    input clk,rst;
    output [(2**N)-1:0] yr1,yr2,yi1,yi2; //output for real number and imaginary number
    wire [(2**N)-1:0] t;

    parameter zero_real = 16'b0000000000000000;

    reg_n rr1 (a,clk,rst,yr1);
    add_sub sub1(1'b1,zero_real,b,t); //s1 = 0-b
    reg_n rr3 (t,clk,rst,yi1);
    assign yr2 = yr1;
 

endmodule



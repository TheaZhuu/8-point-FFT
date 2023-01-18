
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
    wire [(2**N)-1:0] s1;

    parameter zero_real = 16'b0000000000000000;

    reg_n rr1 (yr1,clk,rst,a);
    add_sub sub1(1'b1,zero_real,b,s1); //s1 = 0-b
    reg_n rr2 (yi1,clk,rst,s1);
    reg_n rr3 (yi2,clk,rst,b);
    assign yr2 = yr1;

endmodule




////////////////
////Thea Zhu///
///////////////
`include "add_sub.v"
`include "reg_n.v"


module butterfly_1(a,b,clk,rst,y1,y2);
    parameter N = 4;
    input  [(2**N)-1:0] a,b;
    input clk,rst;
    output [(2**N)-1:0] y1,y2;
    wire [(2**N)-1:0] s1,s2;

    add_sub add1(1'b0,a,b,y1); //y1= a+b
    add_sub sub1(1'b1,a,b,y2);//y2 = a-b

    reg_n rr1 (y1,clk,rst,s1);
    reg_n rr2 (y2,clk,rst,s2);

endmodule



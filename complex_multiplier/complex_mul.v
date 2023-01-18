////////////////
////Thea Zhu///
///////////////

`include "c_multiplier.v"

module complex_mul(ra,rb,clk,rst,real_op,image_op);
    parameter N = 4;
    input [(2**N)-1:0] ra,rb;
    input clk,rst;
    output [(2**N)-1:0] real_op, image_op;

    wire [(2**N)-1:0] s1,s2,s3,s4,s5,s6;
//0 is "+", 1 is "-"
    add_sub a1(1'b1,ra,rb,s1);//s1 = a-b
    add_sub a2(1'b0,ra,rb,s2);//s2 = a+b

    //synchronize the operations
    reg_n rr1 (s1,clk,rst,s3);//s3 = s1
    reg_n rr2 (s2,clk,rst,s4);//s4 = s2

    //0.7071
    c_multiplier cm1(s3,clk,rst,s5); //s5 = (a-b)*0.071
    c_multiplier cm2(s4,clk,rst,s6); //s6 = (a+b)*0.071

    reg_n rr3(s5,clk,rst,real_op);
    reg_n rr4(s6,clk,rst,image_op);

    
endmodule
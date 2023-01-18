////////////////
////Thea Zhu///
///////////////
`include "rsh_n.v"
`include "add_sub.v"
`include "reg_n.v"

module c_multiplier(a,clk,rst,result);

    parameter N = 4;
    input  [(2**N)-1:0] a;
    input clk,rst;
    output [(2**N)-1:0] result;
    wire [(2**N)-1:0] r1,r3,r4,r6,r8,s1,s2,s3,s4,s5,s6,s7,s8;

    rsh_n #(.N(N),.SHFT(1)) rsh1(.a(a),.b(r1));
    rsh_n #(.N(N),.SHFT(3)) rsh3(.a(a),.b(r3));
    rsh_n #(.N(N),.SHFT(4)) rsh4(.a(a),.b(r4));
    rsh_n #(.N(N),.SHFT(6)) rsh6(.a(a),.b(r6));
    rsh_n #(.N(N),.SHFT(8)) rsh8(.a(a),.b(r8));

    add_sub add1(1'b0, r1,r3, s1); //s1 = rsh1+ rsh3
    add_sub add2(1'b0, r4,r6, s2); // s2 = rsh4 + rsh6

    //synchronize the operations
    reg_n rr1(s1,clk,rst,s3); //s1 = rsh1+ rsh3 = s3
    reg_n rr2(s2,clk,rst,s4); //s2 = rsh4 + rsh6 = s4
    reg_n rr3(r8,clk,rst,s4); // s4 = rsh8
    
    add_sub add3(1'b0, s3,s4,s6); // s6 = rsh1+ rsh3 + rsh4 + rsh6
    reg_n rr4(s6,clk,rst,s7); // s7 = s6
    reg_n rr5(s4,clk,rst,s8); // s8 = s4

    add_sub add4(1'b0, s7,s8,result); // result = rsh1+ rsh3 + rsh4 + rsh6 + rsh8 
    
endmodule

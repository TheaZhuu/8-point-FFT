////////////////
////Thea Zhu///
///////////////

`include "dff.v"

module reg_n(d,clk,rst,q);

    parameter N = 4;
    input [(2**N)-1:0] d;
    input clk,rst;
    output [(2**N)-1:0] q;


    dff dff0(d[0],rst,clk,q[0]);
    dff dff1(d[1],rst,clk,q[1]);
    dff dff2(d[2],rst,clk,q[2]);
    dff dff3(d[3],rst,clk,q[3]);
    dff dff4(d[4],rst,clk,q[4]);
    dff dff5(d[5],rst,clk,q[5]);
    dff dff6(d[6],rst,clk,q[6]);
    dff dff7(d[7],rst,clk,q[7]);
    dff dff8(d[8],rst,clk,q[8]);
    dff dff9(d[9],rst,clk,q[9]);
    dff dff10(d[10],rst,clk,q[10]);
    dff dff11(d[11],rst,clk,q[11]);
    dff dff12(d[12],rst,clk,q[12]);
    dff dff13(d[13],rst,clk,q[13]);
    dff dff14(d[14],rst,clk,q[14]);
    dff dff15(d[15],rst,clk,q[15]);

endmodule  
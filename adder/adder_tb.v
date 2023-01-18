`include "adder.v"

module adder_tb;

parameter N =3;

reg[(2**N)-1:0] a,b,c;
reg clk,rst;
wire [(2**N)-1:0] d;

adder a1(a,b,c,d,clk,rst);

integer i;
    initial begin
        $dumpfile("adder.vcd");
        for (i=0; i<8; i=i+1) begin
            clk = 1;
            rst = 0;
            a=$urandom%10;
            b=$urandom%20;
            c=$urandom%10;
            #10;
            $display("A %d, B: %d, C: %d, clk: %d, res: %d, then A+B+C+D: %d",a,b,c,clk,rst,d);
            rst =1;
        end
    end
endmodule  


    
    
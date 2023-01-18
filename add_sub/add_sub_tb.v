////////////////
////Thea Zhu///
///////////////

`include "add_sub.v"

module add_sub_tb;

parameter N =3;
reg[(2**N)-1:0] a,b;
reg add;
wire [(2**N)-1:0] result;

add_sub a1(add,a,b,result);

integer i;
    initial begin
        $dumpfile("add_sub.vcd");
        for (i=0; i<8; i=i+1) begin
            add = 1;
            a=$urandom%10;
            b=$urandom%20;
             #10;
            $display("ADD %d, A: %d, B: %d,  then A + B: %d",add,a,b,result);
           
            add = 0;
            a=$urandom%10;
            b=$urandom%20;
             #10;
            $display("ADD %d, A: %d, B: %d,  then A - B: %d",add,a,b,result);
           
        end
    end
endmodule  


    
    
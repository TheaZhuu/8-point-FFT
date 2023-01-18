////////////////
////Thea Zhu///
///////////////

`include "rsh_n.v"

module rsh_n_tb();

    parameter N = 3;
    parameter SHFT =2 ;

    reg  [(2**N)-1:0] a;
    wire [(2**N)-1:0] b;
    // rsh_n #(.N(3),.SHFT(2)) test (.a(a),.b(b));
    rsh_n test(.a(a),.b(b));

    integer i;
    initial begin
        
        $dumpfile("rsh_n.vcd");
        $dumpvars(0,rsh_n_tb);
        a = 0;
        for(i=0; i<6; i=i+1) begin
           a = $random%30;
            #10;
        $display("a is %b, and then the result of %d bit right shift is %b",a, SHFT, b); 

        end 
    end



endmodule
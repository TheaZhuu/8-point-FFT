`include "bit_reversal.v"

module bit_reversal_tb;
    parameter N = 4;
    reg [(2**N)-1:0] Xi;
    wire[(2**N)-1:0] res;

    bit_reversal a1(Xi,res);
    integer i;

    initial begin
        $dumpfile("bit_reversal.vcd");
        $dumpvars(0,bit_reversal_tb);
        Xi = 0;
        for(i=0; i<6; i=i+1) begin
            Xi = $random%20;
            #10;
        $display("Xi is %b, and then after bit reverse is %b", Xi, res); 
        end 
    end
endmodule
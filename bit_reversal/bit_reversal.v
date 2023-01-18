module bit_reversal (Xi,res);
parameter N = 4;
input  [(2**N)-1:0] Xi;
output reg[(2**N)-1:0] res;

integer i;
always @(*) begin
    for (i = 0; i<2**N; i = i+1) begin
         res[i] = Xi[(2**N)-i-1];
    end 
end
    
endmodule



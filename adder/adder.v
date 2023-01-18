module adder(a,b,c,d,clk,rst);
    parameter N = 3;
    input [(2**N)-1:0] a,b,c;
    input clk,rst;
    output reg [(2**N)-1:0] d;

    integer i;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            d = 0;
        end
        else begin
            d = a + b + c;
        end
    end
endmodule

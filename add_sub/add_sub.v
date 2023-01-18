////////////////
////Thea Zhu///
///////////////
module add_sub(add,a,b,result);
    parameter N = 3;
    input [(2**N)-1:0] a,b;
    input add;
    output reg[(2**N)-1:0] result;

    always @(*) begin
        if(add) begin //0 is adder. 1 is subtractor
          result = a+b;// assign for connecting nets
        end
        else begin//1 is subtractor
          result = a-b;
        end
    end


endmodule
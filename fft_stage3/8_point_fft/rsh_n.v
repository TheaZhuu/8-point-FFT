////////////////
////Thea Zhu///
///////////////

module rsh_n(a,b);

    parameter N = 3;
    parameter SHFT =2 ;
    input  [(2**N)-1:0] a;
    output reg[(2**N)-1:0] b;


    always @(*) begin
      if(SHFT == 1)begin
        if(a[(2**N)-1]==0) begin
          b[(2**N)-1] <=0;
          end
        else begin
          b[(2**N)-1] <=1;
        end 
        b[(2**N)-1-1:0] <= a[(2**N)-1:1];
      end 
    
    else begin
      if(a[(2**N)-1]==0) begin
          b[(2**N)-1:((2**N)-1-SHFT)] <=0;
        end
      else begin
        b[(2**N)-1:((2**N)-1-SHFT)] <=~(a[(2**N)-1:((2**N)-1-SHFT)]& 0);

      end 
        b[(2**N)-1-1-SHFT:0] <= a[(2**N)-1:SHFT];
    end 
    end 
endmodule


// module rsh_n 
// #(parameter N = 3,parameter SHFT =2)
// (input  [(2**N)-1:0] a,output reg[(2**N)-1:0] b);


//     always @(*) begin
//       if(SHFT == 1)begin
//         if(a[(2**N)-1]==0) begin
//           b[(2**N)-1] <=0;
//           end
//         else begin
//           b[(2**N)-1] <=1;
//         end 
//         b[(2**N)-1-1:0] <= a[(2**N)-1:1];
//       end 
    
//     else begin
//       if(a[(2**N)-1]==0) begin
//           b[(2**N)-1:((2**N)-1-SHFT)] <=0;
//         end
//       else begin
//         b[(2**N)-1:((2**N)-1-SHFT)] <=~(a[(2**N)-1:((2**N)-1-SHFT)]& 0);

//       end 
//         b[(2**N)-1-1-SHFT:0] <= a[(2**N)-1:SHFT];
//     end 
//     end 
// endmodule
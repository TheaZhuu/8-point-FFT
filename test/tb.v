`timescale 1ns / 1ps

 
`include "complex_type.sv"
// import complex_type::* ;
 
module test;
parameter N = 8;
Complex IN [0:N-1];
Complex OUT [0:N-1];
logic clk;
logic rst;
logic valid;
logic ready;
 
initial begin
    clk=0;
    forever begin
        #5 clk=~clk;
    end
end
 
initial begin
    rst=1;
    #20
    rst=0;
end
initial begin
    for(int i=0;i<N;i++)
    begin
        IN[i].r=(i<<12);
        IN[i].i=0;
    end
end
 
initial begin
    valid=1;
    #10
    valid=0;
end
 
always_ff@(posedge clk)
if(ready)
begin
    for(int i=0;i<N;i++)
        $display("data_out[%d]=%f+%f*i",i,integer'(OUT[i].r)/65536.0,integer'(OUT[i].i)/65536.0);
end
FFT U(
.clk(clk),
.rst(rst),
.data_in(IN),
.data_out(OUT),
.valid(valid),
.ready(ready)
);
 
endmodule
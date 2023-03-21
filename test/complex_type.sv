`timescale 1ns / 1ps

package complex_type;    //package name 
    parameter DATA_WIDTH = 32;
    //complex struct
    typedef struct packed{
    logic signed [DATA_WIDTH-1:0]  r;
    logic signed [DATA_WIDTH-1:0]  i;
    } Complex;

    //complex arithmetic functions
    //def complext multiplication
    function Complex complex_mul(Complex a,Complex b);             //(a.r+i*a.i)x(b.r+i*b.i)
        Complex res;
        //To prevent overflow, expand to 64 bits and then perform multiplication
        logic [2*DATA_WIDTH-1:0] expand_a_r;
        logic [2*DATA_WIDTH-1:0] expand_a_i;
        logic [2*DATA_WIDTH-1:0] expand_b_r;
        logic [2*DATA_WIDTH-1:0] expand_b_i;
        // $display("a=(%d,%d),b=(%d,%d)",a.r,a.i,b.r,b.i);
        expand_a_r={{32{a.r[31]}},a.r};
        expand_a_i={{32{a.i[31]}},a.i};
        expand_b_r={{32{b.r[31]}},b.r};
        expand_b_i={{32{b.i[31]}},b.i};
        res.r=(expand_a_r*expand_b_r-expand_a_i*expand_b_i)>>>16;
        res.i=(expand_a_r*expand_b_i+expand_a_i*expand_b_r)>>>16;
        // $display("res=(%d,%d)",res.r,res.i);
        return res;
    endfunction
    //def complex addition 
    function Complex complex_add(Complex a,Complex b);
        Complex res;
        res.r=a.r+b.r;
        res.i=a.i+b.i;
        return res;
    endfunction
    //def complex subtraction
    function Complex complex_sub(Complex a,Complex b);
        Complex res;
        res.r=a.r-b.r;
        res.i=a.i-b.i;
        return res;
    endfunction
endpackage
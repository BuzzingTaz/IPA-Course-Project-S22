`ifndef SUB_64BIT
`define SUB_64BIT

`include "../ALU/Add_64bit.v"
module Subtract_64bit(S, Cout, error, A, B, Cin);

    input [63:0] A, B;
    input Cin;
    output [63:0] S;
    output Cout, error;

    wire [63:0] B_1;
    integer k;

    // 1's complement of B structural
    not64 complement(B_1, B);   

    Adder_64bit Subtract(S, Cout, error, A, B_1, Cin);


endmodule

`endif
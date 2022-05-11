`ifndef ADD_64BIT
`define ADD_64BIT

`include "../ALU/CLA_Adder_4bit.v"

module Adder_64bit(S, Cout, OF, A, B, Cin );
  output [63:0] S;
  output reg Cout;
  output reg OF;
  input [63:0] A, B;
  input Cin;

    CLA_Adder_4bit CLA1(S[3:0], Cout1, C3_1, A[3:0], B[3:0], Cin);
    CLA_Adder_4bit CLA2(S[7:4], Cout2, C3_2, A[7:4], B[7:4], Cout1);
    CLA_Adder_4bit CLA3(S[11:8], Cout3, C3_3, A[11:8], B[11:8], Cout2);
    CLA_Adder_4bit CLA4(S[15:12], Cout4, C3_4, A[15:12], B[15:12], Cout3);
    CLA_Adder_4bit CLA5(S[19:16], Cout5, C3_5, A[19:16], B[19:16], Cout4);
    CLA_Adder_4bit CLA6(S[23:20], Cout6, C3_6, A[23:20], B[23:20], Cout5);
    CLA_Adder_4bit CLA7(S[27:24], Cout7, C3_7, A[27:24], B[27:24], Cout6);
    CLA_Adder_4bit CLA8(S[31:28], Cout8, C3_8, A[31:28], B[31:28], Cout7);
    CLA_Adder_4bit CLA9(S[35:32], Cout9, C3_9, A[35:32], B[35:32], Cout8);
    CLA_Adder_4bit CLA10(S[39:36], Cout10, C3_10, A[39:36], B[39:36], Cout9);
    CLA_Adder_4bit CLA11(S[43:40], Cout11, C3_11, A[43:40], B[43:40], Cout10);
    CLA_Adder_4bit CLA12(S[47:44], Cout12, C3_12, A[47:44], B[47:44], Cout11);
    CLA_Adder_4bit CLA13(S[51:48], Cout13, C3_13, A[51:48], B[51:48], Cout12);
    CLA_Adder_4bit CLA14(S[55:52], Cout14, C3_14, A[55:52], B[55:52], Cout13);
    CLA_Adder_4bit CLA15(S[59:56], Cout15, C3_15, A[59:56], B[59:56], Cout14);
    CLA_Adder_4bit CLA16(S[63:60], Cout16, C3_16, A[63:60], B[63:60], Cout15);

    always@* Cout = Cout16;
    always @* OF = error;
    xor overflow(error, Cout16, C3_16);
endmodule

`endif
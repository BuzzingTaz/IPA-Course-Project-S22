`ifndef CLA_ADDER_4BIT
`define CLA_ADDER_4BIT

module CLA_Adder_4bit(S, Cout, C3, A, B, C0);

  output [3:0] S;
  output Cout, C3;
  input [3:0] A, B;
  input C0;
  wire S0, S1, S2, S3;
  wire A0 = A[0], A1 = A[1], A2 = A[2], A3 = A[3];
  wire B0 = B[0], B1 = B[1], B2 = B[2], B3 = B[3];

wire P3, P2, P1, P0, G3, G2, G1, G0, C0, C1, C2, C3, Cout, P1G0, P2G1, P3G2, P2P1G0, P3P2G1, P3P2P1G0, P0C0, P1P0C0, P2P1P0C0, P3P2P1P0C0;

//Making layer 1

xor
xor0(P0,A0,B0),
xor1(P1,A1,B1),
xor2(P2,A2,B2),
xor3(P3,A3,B3);
and 
and0(G0,A0,B0),
and1(G1,A1,B1),
and2(G2,A2,B2),
and3(G3,A3,B3);

// Making layer 2

and and00(P0C0, P0, C0);
or or00(C1, P0C0, G0);

and 
and10(P1P0C0, P0, P1, C0),
and11(P1G0, P1, G0);
or or10(C2, P1P0C0, P1G0, G1);

and 
and20(P2P1P0C0, P2, P1, P0, C0),
and21(P2P1G0, P2, P1, G0),
and22(P2G1, P2, G1);
or or20(C3, P2P1P0C0, P2P1G0, P2G1, G2);

and 
and30(P3P2P1P0C0, P3, P2, P1, P0, C0),
and31(P3P2P1G0, P3, P2, P1, G0),
and32(P3P2G1, P3, P2, G1),
and33(P3G2, P3, G2);
or or30(Cout, P3P2P1P0C0, P3P2P1G0, P3P2G1, P3G2, G3);


// final

xor f3(S3, P3, C3),
f2(S2, P2, C2),
f1(S1, P1, C1),
f0(S0, P0, C0);

assign S[0] = S0;
assign S[1] = S1;
assign S[2] = S2;
assign S[3] = S3;

endmodule

`endif
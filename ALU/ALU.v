`ifndef ALU
`define ALU

`include "../ALU/Add_64bit.v"
`include "../ALU/Sub_64bit.v"
`include "../ALU/gates64.v"

module ALU(out, Cout, OF, control, A, B);

input [1:0] control;
input [63:0] A,B;
output reg [63:0] out;
output Cout;
output reg OF;

wire [63:0] ADD_out, SUB_out, AND_out, XOR_out;
reg [63:0]to_send;
wire OF_add, OF_sub;

Adder_64bit ADD(ADD_out, Cout, OF_add, A, B, control[0]);
Subtract_64bit SUB(SUB_out, Cout, OF_sub, B, A, control[0]);
and64 AND(AND_out, A, B);
xor64 XOR(XOR_out, A, B);

always @*
begin
    if (control==2'b00)begin
    out = ADD_out;
    OF = OF_add;
    end

    else if (control==2'b01)begin
    out = SUB_out;
    OF = OF_sub;
    end

    else if (control==2'b10)
    out = AND_out;

    else if (control==2'b11)
    out = XOR_out;
end
endmodule

`endif
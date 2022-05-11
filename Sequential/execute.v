`include "../ALU/ALU.v"
module execute(valE,cnd,CC_out,icode,ifun,valC,valA,valB,CC_in);

output reg [63:0] valE;
output reg cnd;
output reg [2:0] CC_out;
input [3:0] icode,ifun;
input [63:0] valC,valA,valB;
input [2:0] CC_in;              // OF,SF,ZF condition codes

wire cout;
wire OF;
reg prev_PC;           

wire Z_F, S_F, O_F;
assign Z_F = CC_in[0];
assign S_F = CC_in[1];
assign O_F = CC_in[2];

wire [63:0] valE_AB, valE_CB,valE_OP, valE_INC, valE_DEC;
wire OF_dum;
always @*begin
    if(icode==2 |icode ==7)begin
    case (ifun)
        4'h0: cnd = 1;              // unconditional
        4'h1: cnd = (O_F^S_F)|Z_F;  // le
        4'h2: cnd = O_F^S_F;        // l
        4'h3: cnd = Z_F;            // e
        4'h4: cnd = ~Z_F;           // ne
        4'h5: cnd = ~(S_F^O_F);     // ge
        4'h6: cnd = ~(S_F^O_F)&~Z_F;// g
    endcase
    end
end

ALU aluAB(valE_AB,cout,OF_dum,2'b0,valA,valB);
ALU aluOP(valE_OP,cout,OF,ifun[1:0],valA,valB);
ALU aluCB(valE_CB,cout,OF_dum,2'b0,valC,valB);
ALU aluINC(valE_INC,cout,OF_dum,2'b0,64'd1,valB);
ALU aluDEC(valE_DEC,cout,OF_dum,2'b1,64'd1,valB);


always@*
begin
    
    case (icode)
    4'h2:   valE = valE_AB;     // cmovx
    4'h3:   valE=valE_CB;       // irmovq
    4'h4:   valE=valE_CB;       // rmmovq
    4'h5:   valE=valE_CB;       // mrmovq
    4'h6:begin                  // opq
            valE=valE_OP;
            CC_out[2] <= OF;
            CC_out[1] <= valE[63];
            CC_out[0] <= valE ? 0:1;
    end
    4'h8: valE=valE_DEC;        // call
    4'h9: valE=valE_INC;        // ret
    4'hA: valE=valE_DEC;        // pushq
    4'hB: valE=valE_INC;        // popq
    default: valE=0;
    endcase

end
endmodule
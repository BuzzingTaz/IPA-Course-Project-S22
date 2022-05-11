`include "../ALU/ALU.v"
module execute(M_stat,M_icode,M_cnd,M_valE,M_valA,M_dstE,M_dstM,e_valE,e_dstE,
                E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,E_dstE,E_dstM,e_cnd,m_stat,W_stat,clk,M_bubble,set_cc);

  input clk;
  input [0:3] E_stat;
  input [3:0] E_icode,E_ifun;
  input [63:0] E_valC,E_valA,E_valB;
  input [3:0] E_dstE,E_dstM;
  input [0:3] m_stat, W_stat;     // Stats to check for exceptions in next stages
  input M_bubble;
  input set_cc;

  output reg [0:3] M_stat;
  output reg [3:0] M_icode;
  output reg M_cnd;
  output reg [63:0] M_valE,M_valA,e_valE;
  output reg [3:0] M_dstE,M_dstM,e_dstE;
  output reg e_cnd=1;

  reg [2:0] CC = 3'b000;      // OF,SF,ZF condition codes

  wire cout;
  wire OF_dum;

  wire O_F;         
  wire ZF, SF, OF;
  assign ZF = CC[0];
  assign SF = CC[1];
  assign OF = CC[2];

  wire [63:0] valE_AB, valE_CB,valE_OP, valE_INC, valE_DEC;

  // Checking for cnd
  always @*
  begin
    if(E_icode==2 |E_icode ==7)
    begin
      case (E_ifun)
        4'h0: e_cnd = 1;              // unconditional
        4'h1: e_cnd = (OF^SF)|ZF;     // le
        4'h2: e_cnd = OF^SF;          // l
        4'h3: e_cnd = ZF;             // e
        4'h4: e_cnd = ~ZF;            // ne
        4'h5: e_cnd = ~(SF^OF);       // ge
        4'h6: e_cnd = ~(SF^OF)&~ZF;   // g
      endcase
      e_dstE = e_cnd ? E_dstE : 4'hF;
    end
    else
      e_dstE = E_dstE;
  end

  ALU aluAB(valE_AB,cout,OF_dum,2'b0,E_valA,E_valB);
  ALU aluOP(valE_OP,cout,O_F,E_ifun[1:0],E_valA,E_valB);
  ALU aluCB(valE_CB,cout,OF_dum,2'b0,E_valC,E_valB);
  ALU aluINC(valE_INC,cout,OF_dum,2'b0,64'd1,E_valB);
  ALU aluDEC(valE_DEC,cout,OF_dum,2'b1,64'd1,E_valB);


  always@*
  begin 
    case (E_icode)
    4'h2:   e_valE=valE_AB;         // cmovx
    4'h3:   e_valE=valE_CB;         // irmovq
    4'h4:   e_valE=valE_CB;         // rmmovq
    4'h5:   e_valE=valE_CB;         // mrmovq
    4'h6:begin                      // opq
          e_valE=valE_OP;
          if(set_cc)
          begin
              CC[2] = OF;
              CC[1] = e_valE[63];
              CC[0] = e_valE ? 0:1;
          end
    end
    4'h8: e_valE=valE_DEC;        // call
    4'h9: e_valE=valE_INC;        // ret
    4'hA: e_valE=valE_DEC;        // pushq
    4'hB: e_valE=valE_INC;        // popq
    default: e_valE=0;
    endcase

  end

  always@(posedge clk)
  begin
    if(M_bubble)
    begin
      M_stat <= 4'b1000;
      M_icode <= 4'b001;
      M_cnd <= 1;
      M_valE <= 0;
      M_valA <= 0;
      M_dstE <= 4'hF;
      M_dstM <= 4'hF;
    end
    else
    begin
      M_stat <= E_stat;
      M_icode <= E_icode;
      M_cnd <= e_cnd;
      M_valE <= e_valE;
      M_valA <= E_valA;
      M_dstE <= e_dstE;
      M_dstM <= E_dstM;
    end
  end

endmodule
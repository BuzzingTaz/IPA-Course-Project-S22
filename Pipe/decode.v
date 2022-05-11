module decode(E_bubble,clk,D_icode,D_ifun,D_rA,D_rB,D_stat,D_valC,D_valP,
              e_dstE,M_dstE,M_dstM,W_dstE,W_dstM,
              e_valE,M_valE,m_valM,W_valE,W_valM,W_icode,
              E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,
              E_dstE,E_dstM,E_srcA,E_srcB,
              d_srcA,d_srcB,
              reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,
              reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14
              );

  input clk;
  input [3:0] D_icode,D_ifun,D_rA,D_rB;
  input [0:3] D_stat;
  input [63:0] D_valC,D_valP;
  input E_bubble;

  input [3:0] W_icode;
  input [3:0] e_dstE,M_dstE,M_dstM,W_dstE,W_dstM;
  input [63:0] e_valE,M_valE,m_valM,W_valE,W_valM;

  output reg [0:3] E_stat;
  output reg [3:0] E_icode,E_ifun;
  output reg [63:0] E_valC,E_valA,E_valB;
  output reg [3:0] E_dstE,E_dstM,E_srcA,E_srcB;
  output reg[63:0] reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14;
  output reg [3:0] d_srcA,d_srcB;

  reg [3:0] d_dstE,d_dstM;
  reg [63:0] d_rvalA,d_rvalB,d_valA,d_valB;
  reg [63:0] reg_mem[0:14];

  initial begin
      reg_mem[0] = 2;
      reg_mem[1] = 1;
      reg_mem[2] = 2;
      reg_mem[3] = 5;
      reg_mem[4] = 5;
      reg_mem[5] = 5;
      reg_mem[6] = 6;
      reg_mem[7] = 7;
      reg_mem[8] = 8;
      reg_mem[9] = 9;
      reg_mem[10] = 10;
      reg_mem[11] = 11;
      reg_mem[12] = 12;
      reg_mem[13] = 13;
      reg_mem[14] = 14;
  end

  always@*
  begin

    d_srcA = 4'hF;
    d_srcB = 4'hF;
    d_dstE = 4'hF;
    d_dstM = 4'hF;
    // computing dst and src
    case (D_icode)
      4'h2: begin
        d_srcA = D_rA;
        d_dstE = D_rB;
      end
      4'h3: begin
        d_dstE = D_rB;
      end
      4'h4: begin
        d_srcA = D_rA;
        d_srcB = D_rB;
      end
      4'h5: begin
        d_srcB = D_rB;
        d_dstM = D_rA;
      end
      4'h6: begin
        d_srcA = D_rA;
        d_srcB = D_rB;
        d_dstE = D_rB;
      end
      4'h8:begin
        d_srcB = 4;
        d_dstE = 4;
      end
      4'h9:begin
        d_srcA = 4;
        d_srcB = 4;
        d_dstE = 4;
      end
      4'hA: begin
        d_srcA = D_rA;
        d_srcB = 4;
        d_dstE = 4;
      end
      4'hB: begin
        d_srcA = 4;
        d_srcB = 4;
        d_dstE = 4;
        d_dstM = D_rA;
      end
      default: begin
        d_srcA = 4'hF;
        d_srcB = 4'hF;
        d_dstE = 4'hF;
        d_dstM = 4'hF;
      end
    endcase


    if(D_icode==4'b0010) //cmovq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=64'b0;
    end
    if(D_icode==4'b0011) //irmovq
        d_rvalB=64'b0;
    else if(D_icode==4'b0100) //rmmovq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=reg_mem[D_rB];
    end
    else if(D_icode==4'b0101) //mrmovq
    begin
        d_rvalB=reg_mem[D_rB];
    end
    else if(D_icode==4'b0110) //OPq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=reg_mem[D_rB];
    end
    // add jxx
    else if(D_icode==4'b1000) //call
    begin
        d_rvalB=reg_mem[4]; 
    end
    else if(D_icode==4'b1001) //ret
    begin
        d_rvalA=reg_mem[4]; 
        d_rvalB=reg_mem[4];
    end
    else if(D_icode==4'b1010) //pushq
    begin
        d_rvalA=reg_mem[D_rA];
        d_rvalB=reg_mem[4];
    end
    else if(D_icode==4'b1011) //popq
    begin
        d_rvalA=reg_mem[4]; 
        d_rvalB=reg_mem[4];
    end

    // Forwarding A
    if(D_icode==4'h7 | D_icode == 4'h8) //jxx or call
      d_valA = D_valP;
    else if(d_srcA==e_dstE & e_dstE!=4'hF)
      d_valA = e_valE;
    else if(d_srcA==M_dstM & M_dstM!=4'hF)
      d_valA = m_valM;
    else if(d_srcA==W_dstM & W_dstM!=4'hF)
      d_valA = W_valM;
    else if(d_srcA==M_dstE & M_dstE!=4'hF)
      d_valA = M_valE;
    else if(d_srcA==W_dstE & W_dstE!=4'hF)
      d_valA = W_valE;
    else
      d_valA = d_rvalA;
    
    // Forwarding B
    if(d_srcB==e_dstE & e_dstE!=4'hF)      // Forwarding from execute
      d_valB = e_valE;
    else if(d_srcB==M_dstM & M_dstM!=4'hF) // Forwarding from memory
      d_valB = m_valM;
    else if(d_srcB==W_dstM & W_dstM!=4'hF) // Forwarding memory value from write back stage
      d_valB = W_valM;
    else if(d_srcB==M_dstE & M_dstE!=4'hF) // Forwarding execute value from memory stage
      d_valB = M_valE;
    else if(d_srcB==W_dstE & W_dstE!=4'hF) // Forwarding execute value from write back stage 
      d_valB = W_valE;
    else
      d_valB = d_rvalB;
  end

  always@(posedge clk)
  begin 
    if(E_bubble)
    begin
      E_stat <= 4'b1000;
      E_icode <= 4'b0001;
      E_ifun <= 4'b0000;
      E_valC <= 4'b0000;
      E_valA <= 4'b0000;
      E_valB <= 4'b0000;
      E_dstE <= 4'hF;
      E_dstM <= 4'hF;
      E_srcA <= 4'hF;
      E_srcB <= 4'hF;
    end
    else
    begin
      // Execute register update
      E_stat <= D_stat;
      E_icode <= D_icode;
      E_ifun <= D_ifun;
      E_valC <= D_valC;
      E_valA <= d_valA;
      E_valB <= d_valB;
      E_srcA <= d_srcA;
      E_srcB <= d_srcB;
      E_dstE <= d_dstE;
      E_dstM <= d_dstM;
    end

  end


// writeback 
  always@(posedge clk) begin

    if(W_icode==4'b0010) //cmovxx
    begin
      reg_mem[W_dstE]=W_valE;
    end
    else if(W_icode==4'b0011) //irmovq
      reg_mem[W_dstE]=W_valE;

    else if(W_icode==4'b0101) //mrmovq
    begin
      reg_mem[W_dstM] = W_valM;
    end
    else if(W_icode==4'b0110) //OPq
    begin
      reg_mem[W_dstE] = W_valE;
    end
    else if(W_icode==4'b1000) //call
    begin
      reg_mem[W_dstE] = W_valE;
    end
    else if(W_icode==4'b1001) //ret
    begin
      reg_mem[W_dstE] = W_valE;
    end
    else if(W_icode==4'b1010) //pushq
    begin
      reg_mem[W_dstE] = W_valE;
    end
    else if(W_icode==4'b1011) //popq
    begin
      reg_mem[W_dstE] = W_valE;
      reg_mem[W_dstM] = W_valM;
    end

    reg_mem0 <= reg_mem[0];
    reg_mem1 <= reg_mem[1];
    reg_mem2 <= reg_mem[2];
    reg_mem3 <= reg_mem[3];
    reg_mem4 <= reg_mem[4];
    reg_mem5 <= reg_mem[5];
    reg_mem6 <= reg_mem[6];
    reg_mem7 <= reg_mem[7];
    reg_mem8 <= reg_mem[8];
    reg_mem9 <= reg_mem[9];
    reg_mem10 <= reg_mem[10];
    reg_mem11 <= reg_mem[11];
    reg_mem12 <= reg_mem[12];
    reg_mem13 <= reg_mem[13];
    reg_mem14 <= reg_mem[14];
  end
endmodule
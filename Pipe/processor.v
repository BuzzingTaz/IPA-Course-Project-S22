// includes
`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "pipe_control.v"
module processor;
  reg clk;
  reg [0:3] stat = 4'b1000;           // AOK, HLT, ADR, INS

  reg [63:0] F_predPC;
  wire [63:0] f_predPC;
  wire [0:3] D_stat,E_stat,M_stat,W_stat,m_stat;
  wire [3:0] D_icode,E_icode,M_icode,W_icode;
  wire [3:0] D_ifun,E_ifun;
  wire [3:0] D_rA,D_rB;
  wire [63:0] D_valC,D_valP;
  wire [3:0] d_srcA,d_srcB;
  wire [63:0] E_valC,E_valA,E_valB,e_valE;
  wire [63:0] M_valE,M_valA,m_valM;
  wire [63:0] W_valE,W_valM;
  wire [3:0] E_dstE,E_dstM,E_srcA,E_srcB,e_dstE;
  wire [3:0] M_dstE,M_dstM;
  wire [3:0] W_dstE,W_dstM;
  wire M_cnd;
  wire e_cnd;

  wire F_stall, D_stall, D_bubble, E_bubble, M_bubble, W_stall, set_cc;
  wire [63:0] reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14;


  // stat is calculated at every stage of the processor
  always@(W_stat)begin
    stat = W_stat;
  end  

  // always halt logic
  always@(stat) begin
    if(stat==4'b0100) begin
      $display("Halting");
      $finish;
    end
    else if(stat==4'b0010) begin
      $display("ADR Error");
      $finish;
    end
    else if(stat==4'b0001) begin
      $display("INS Error");
      $finish;
    end
  end

  always #10 clk = ~clk;

  always @(posedge clk) F_predPC <= f_predPC;


  fetch fetch(
    .D_stat(D_stat),.D_icode(D_icode),.D_ifun(D_ifun),.D_rA(D_rA),
    .D_rB(D_rB),.D_valC(D_valC),.D_valP(D_valP),
    .f_predPC(f_predPC),
    .M_icode(M_icode),.M_cnd(M_cnd),.M_valA(M_valA),
    .W_icode(W_icode),.W_valM(W_valM),
    .F_predPC(F_predPC),
    .clk(clk),
    .F_stall(F_stall),.D_stall(D_stall),.D_bubble(D_bubble)
  );

  decode decode(
    .E_bubble(E_bubble),
    .clk(clk),
    .D_stat(D_stat),.D_icode(D_icode),.D_ifun(D_ifun),.D_rA(D_rA),
    .D_rB(D_rB),.D_valC(D_valC),.D_valP(D_valP),
    .e_dstE(e_dstE),.M_dstE(M_dstE),.M_dstM(M_dstM),.W_dstE(W_dstE),.W_dstM(W_dstM),
    .e_valE(e_valE),.M_valE(M_valE),.m_valM(m_valM),.W_valE(W_valE),.W_valM(W_valM),.W_icode(W_icode),
    .E_stat(E_stat),.E_icode(E_icode),.E_ifun(E_ifun),.E_valC(E_valC),.E_valA(E_valA),.E_valB(E_valB),
    .E_dstE(E_dstE),.E_dstM(E_dstM),.E_srcA(E_srcA),.E_srcB(E_srcB),
    .d_srcA(d_srcA),.d_srcB(d_srcB),
    .reg_mem0(reg_mem0),.reg_mem1(reg_mem1),.reg_mem2(reg_mem2),.reg_mem3(reg_mem3),.reg_mem4(reg_mem4),
    .reg_mem5(reg_mem5),.reg_mem6(reg_mem6),.reg_mem7(reg_mem7),.reg_mem8(reg_mem8),.reg_mem9(reg_mem9),
    .reg_mem10(reg_mem10),.reg_mem11(reg_mem11),.reg_mem12(reg_mem12),.reg_mem13(reg_mem13),.reg_mem14(reg_mem14)
              );

  execute execute(
    .M_stat(M_stat),.M_icode(M_icode),.M_cnd(M_cnd),.M_valE(M_valE),.M_valA(M_valA),.M_dstE(M_dstE),.M_dstM(M_dstM),
    .e_valE(e_valE),.e_dstE(e_dstE),
    .E_stat(E_stat),.E_icode(E_icode),.E_ifun(E_ifun),.E_valC(E_valC),.E_valA(E_valA),.E_valB(E_valB),.E_dstE(E_dstE),.E_dstM(E_dstM),
    .e_cnd(e_cnd),.m_stat(m_stat),
    .W_stat(W_stat),
    .clk(clk),
    .M_bubble(M_bubble),.set_cc(set_cc)
                  );


  memory memory(
    .W_stat(W_stat),.W_icode(W_icode),.W_valE(W_valE),.W_valM(W_valM),.W_dstE(W_dstE),.W_dstM(W_dstM),
    .m_valM(m_valM),.m_stat(m_stat),
    .M_stat(M_stat),.M_icode(M_icode),.M_cnd(M_cnd),.M_valE(M_valE),.M_valA(M_valA),.M_dstE(M_dstE),.M_dstM(M_dstM),
    .clk(clk),
    .W_stall(W_stall)
              );

  pipe_control pipe_control(
    .F_stall(F_stall),.D_stall(D_stall),.D_bubble(D_bubble),.E_bubble(E_bubble),.M_bubble(M_bubble),.W_stall(W_stall),.set_cc(set_cc),
    .D_icode(D_icode),.d_srcA(d_srcA),.d_srcB(d_srcB),.E_icode(E_icode),.E_dstM(E_dstM),.e_cnd(e_cnd),.M_icode(M_icode),.m_stat(m_stat),.W_stat(W_stat)
                          );
                          
  initial begin

      $dumpfile("processor.vcd");
      $dumpvars(0,processor);
      F_predPC=64'd0;
      clk=0;
      // $monitor("clk=%d f_predPC=%d F_predPC=%d D_icode=%d,E_icode=%d, M_icode=%d, ifun=%d,rax=%d,rdx=%d,rbx=%d,rcx=%d\n",clk,f_predPC,F_predPC, D_icode,E_icode,M_icode,D_ifun,reg_mem0,reg_mem2,reg_mem3,reg_mem1);
      $monitor("clk=%d f_predPC=%d F_predPC=%d D_icode=%d,E_icode=%d, M_icode=%d, m_valM=%d, f_stall=%d, ifun=%d,rdi=%d,rsi=%d\n",clk,f_predPC,F_predPC, D_icode,E_icode,M_icode,m_valM,F_stall,D_ifun,reg_mem7,reg_mem6);

  end
endmodule
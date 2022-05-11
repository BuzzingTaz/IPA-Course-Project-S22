`include "fetch.v"
`include "decode.v"

module decode_test;
  reg clk;
  
  wire [3:0] D_icode;
  wire [3:0] D_ifun;
  wire [3:0] D_rA;
  wire [3:0] D_rB; 
  wire [63:0] D_valC;
  wire [63:0] D_valP;
  wire [3:0] D_stat;
  wire [63:0] f_predPC;
  
  wire [0:3] E_stat;
  wire [3:0] E_icode,E_ifun;
  wire [63:0] E_valC,E_valA,E_valB;
  wire [3:0] E_dstE,E_dstM,E_srcA,E_srcB;
  wire [63:0] reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14; 


  reg [3:0] M_icode,W_icode;
  reg [63:0] M_valA;
  reg [63:0] F_predPC_in;
  reg [3:0] e_dstE,M_dstE,M_dstM,W_dstE,W_dstM;
  reg [63:0] e_valE,M_valE,m_valM,W_valE,W_valM; 
  reg [7:0] instr_mem[0:20480];

  fetch fetch(
    .D_icode(D_icode),
    .D_ifun(D_ifun),
    .D_rA(D_rA),
    .D_rB(D_rB),
    .D_valC(D_valC),
    .D_valP(D_valP),
    .D_stat(D_stat),
    .f_predPC(f_predPC),
    .M_icode(M_icode),
    .M_cnd(M_cnd),
    .M_valA(M_valA),
    .W_icode(W_icode),
    .W_valM(W_valM),
    .F_predPC(F_predPC_in),
    .clk(clk)
  );

  decode decode(
    clk,D_icode,D_ifun,D_rA,D_rB,D_stat,D_valC,D_valP,
              e_dstE,M_dstE,M_dstM,W_dstE,W_dstM,
              e_valE,M_valE,m_valM,W_valE,W_valM,W_icode,
              E_stat,E_icode,E_ifun,E_valC,E_valA,E_valB,
              E_dstE,E_dstM,E_srcA,E_srcB,
              reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,
              reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14
              );
  always @(D_icode) begin
    if(D_icode==0) 
      $finish;
  end

  always @(posedge clk) F_predPC_in <= f_predPC;

  always #10 clk = ~clk;

  initial begin 
    clk=1;
    F_predPC_in=64'd32;
  end
  initial 
		$monitor("clk=%d F_predPC=%d F_predPC_in=%d icode=%b ifun=%b valA=%d valB=%d,valC=%d\n",clk,f_predPC,F_predPC_in, E_icode,E_ifun,E_valA,E_valB,E_valC);
    // $monitor("%d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14);
endmodule
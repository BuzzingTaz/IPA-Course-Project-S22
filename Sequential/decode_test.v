`include "fetch.v"
`include "decode.v"

module decode_test;
  reg clk;
  reg [63:0] PC;
  
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valA, valB, valC, valM;
  wire [63:0] valP;
  wire imem_error, instr_valid;
  reg [7:0] instr_mem[0:20480];
  reg [0:79] instr;
  reg cnd = 1;

  wire [63:0] reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14; 


  fetch fetch(
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .clk(clk),
    .PC(PC),
    .imem_error(imem_error),
    .instr_valid(instr_valid),
    .instr(instr)
  );
  
  decode decode(.clk(clk),.icode(icode),.rA(rA),.rB(rB),.valA(valA),.valB(valB),.valM(valM),
                .reg_mem0(reg_mem0),.reg_mem1(reg_mem1),.reg_mem2(reg_mem2),.reg_mem3(reg_mem3),.reg_mem4(reg_mem4),
                .reg_mem5(reg_mem5),.reg_mem6(reg_mem6),.reg_mem7(reg_mem7),.reg_mem8(reg_mem8),.reg_mem9(reg_mem9),
                .reg_mem10(reg_mem10),.reg_mem11(reg_mem11),.reg_mem12(reg_mem12),.reg_mem13(reg_mem13),.reg_mem14(reg_mem14)
                );

  always@(PC) begin
    
    instr={
      instr_mem[PC],
      instr_mem[PC+1],
      instr_mem[PC+2],
      instr_mem[PC+3],
      instr_mem[PC+4],
      instr_mem[PC+5],
      instr_mem[PC+6],
      instr_mem[PC+7],
      instr_mem[PC+8],
      instr_mem[PC+9]
    };
  end

  always @(icode) begin
    if(icode==0 && ifun==0) 
      $finish;
  end

  always #10 clk = ~clk;
  // always #20 PC = valP;
  always @(posedge clk) PC<=valP;

  initial begin 
    clk=1;
    PC=64'd32;
   //OPq
    instr_mem[32]=8'b01100001; //6 fn
    instr_mem[33]=8'b00100011; //rA rB


  //cmovxx
    instr_mem[34]=8'b00100000; //2 fn
    instr_mem[35]=8'b00110100; //rA rB

    instr_mem[36]=8'b00100101; // 2 ge
    instr_mem[37]=8'b01010011; // rA rB

  //halt
    instr_mem[38]=8'b00000000; // 0 0

  
end 
  
  initial 
		$monitor("clk=%d icode=%b ifun=%b rA=%b rB=%b,valA=%d,valB=%d,reg_mem[3]]=%d\n",clk,icode,ifun,rA,rB,valA,valB,reg_mem3);
    // $monitor("%d %d %d %d %d %d %d %d %d %d %d %d %d %d\n", reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14);
endmodule
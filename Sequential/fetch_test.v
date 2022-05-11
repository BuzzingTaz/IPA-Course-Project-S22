`include "fetch.v"

module fetch_test;
  reg clk;
  reg [63:0] PC;
  
  wire [3:0] icode;
  wire [3:0] ifun;
  wire [3:0] rA;
  wire [3:0] rB; 
  wire [63:0] valC;
  wire [63:0] valP;
  wire imem_error, instr_valid;
  reg [7:0] instr_mem[0:20480];
  reg [0:79] instr;

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
		$monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
endmodule
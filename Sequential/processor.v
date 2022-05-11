// includes
`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "pc_update.v"

module processor;
  reg clk;
  reg [63:0] PC;
  wire [63:0] PC_next;
  reg [0:3] stat = 4'b1000;     // AOK, HLT, ADR, INS
  
  reg [2:0] CC_in;
  reg [0:79] instr;
  reg [7:0] instr_mem[0:20480];       // can hold minimum of 256 instructions

  wire cnd;
  wire dmem_error;
  wire [2:0] CC_out;
  wire instr_valid, imem_error;
  wire [3:0] icode,ifun,rA,rB;
  wire [63:0] valA,valB,valC,valE,valM,valP;
  wire [63:0] reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14;

  // always stat logic using imem_error, icode, dmem_error
  always@(instr_valid,imem_error,dmem_error,icode)begin
    if(instr_valid==0)
      stat = 4'b0001;
    else if(imem_error==1)
      stat = 4'b0010;
    else if(dmem_error==1)
      stat = 4'b0010;
    else if(icode==4'b0000)
      stat = 4'b0100;
    else
      stat = 4'b1000;
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

  // read instruction from memory    
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

  always #10 clk = ~clk;

  always @* PC = PC_next;


  fetch fetch(.icode(icode),
              .ifun(ifun),
              .rA(rA),
              .rB(rB),
              .valC(valC),
              .valP(valP),
              .imem_error(imem_error),
              .instr_valid(instr_valid),
              .clk(clk),
              .PC(PC),
              .instr(instr)
              );

  decode decode(.clk(clk),.icode(icode),.rA(rA),.rB(rB),.cnd(cnd),.valA(valA),.valB(valB),.valE(valE),.valM(valM),
                .reg_mem0(reg_mem0),.reg_mem1(reg_mem1),.reg_mem2(reg_mem2),.reg_mem3(reg_mem3),.reg_mem4(reg_mem4),
                .reg_mem5(reg_mem5),.reg_mem6(reg_mem6),.reg_mem7(reg_mem7),.reg_mem8(reg_mem8),.reg_mem9(reg_mem9),
                .reg_mem10(reg_mem10),.reg_mem11(reg_mem11),.reg_mem12(reg_mem12),.reg_mem13(reg_mem13),.reg_mem14(reg_mem14)
                );

  execute execute(.valE(valE),
                  .cnd(cnd),
                  .CC_out(CC_out),
                  .icode(icode),
                  .ifun(ifun),
                  .valA(valA),
                  .valB(valB),
                  .valC(valC),
                  .CC_in(CC_in)
                  );
  always @(posedge clk) begin
    if(icode==6)CC_in = CC_out;
  end

  memory memory(.valM(valM),
                .dmem_error(dmem_error),
                .clk(clk),
                .icode(icode),
                .valE(valE),
                .valA(valA),
                .valP(valP)
                );

  pc_update pc_update(.PC(PC_next),
                      .clk(clk),
                      .icode(icode),
                      .cnd(cnd),
                      .valC(valC),
                      .valM(valM),
                      .valP(valP)
                      );



initial begin
  // $monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valC=%d,valP=%d\n",clk,PC,icode,ifun,rA,rB,valC,valP);
  $monitor("clk=%d PC=%d icode=%b ifun=%b cnd=%d CC_in=%b CC_out=%b rA=%b rB=%b,valA=%d,valB=%d,vaE=%d,reg_mem[3]=%d\n",clk,PC,icode,ifun,cnd,CC_in,CC_out,rA,rB,valA,valB,valE,reg_mem3);
  // $monitor("clk=%d PC=%d icode=%b ifun=%b rA=%b rB=%b,valA=%d,valB=%d,vaE=%d,valM=%d,reg1=%d,reg2=%d,reg3=%d,reg5=%d,reg7=%d\n",clk,PC,icode,ifun,rA,rB,valA,valB,valE,valM,reg_mem1,reg_mem2,reg_mem3,reg_mem5,reg_mem7);

    clk=1;
    PC=64'd32;

  //   //cmovxx
  //   instr_mem[0]=8'b00100000; //2 fn
  //   instr_mem[1]=8'b00010011; //rA rB

  // //irmovq
  //   instr_mem[2]=8'b00110000; //3 0
  //   instr_mem[3]=8'b00000010; //F rB
  //   instr_mem[4]=8'b00000000; //V
  //   instr_mem[5]=8'b00000000; //V
  //   instr_mem[6]=8'b00000000; //V
  //   instr_mem[7]=8'b00000000; //V
  //   instr_mem[8]=8'b00000000; //V
  //   instr_mem[9]=8'b00000000; //V
  //   instr_mem[10]=8'b00000000; //V
  //   instr_mem[11]=8'b00010001; //V=17

  // //rmmovq
  //   instr_mem[12]=8'b01000000; //4 0
  //   instr_mem[13]=8'b01010010; //rA rB
  //   instr_mem[14]=8'b00000000; //D
  //   instr_mem[15]=8'b00000000; //D
  //   instr_mem[16]=8'b00000000; //D
  //   instr_mem[17]=8'b00000000; //D
  //   instr_mem[18]=8'b00000000; //D
  //   instr_mem[19]=8'b00000000; //D
  //   instr_mem[20]=8'b00000000; //D
  //   instr_mem[21]=8'b00000001; //D

  // //mrmovq
  //   instr_mem[22]=8'b01010000; //5 0
  //   instr_mem[23]=8'b0111  ; //rA rB
  //   instr_mem[24]=8'b00000000; //D
  //   instr_mem[25]=8'b00000000; //D
  //   instr_mem[26]=8'b00000000; //D
  //   instr_mem[27]=8'b00000000; //D
  //   instr_mem[28]=8'b00000000; //D
  //   instr_mem[29]=8'b00000000; //D
  //   instr_mem[30]=8'b00000000; //D
  //   instr_mem[31]=8'b00000001; //D

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
endmodule
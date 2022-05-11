module decode(clk,icode,rA,rB,cnd,valA,valB,valE,valM,
              reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,
              reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14);

input clk;
input cnd;
input [3:0] icode,rA,rB;
input [63:0] valE,valM;
output reg [63:0] valA,valB;
output reg[63:0] reg_mem0,reg_mem1,reg_mem2,reg_mem3,reg_mem4,reg_mem5,reg_mem6,reg_mem7,reg_mem8,reg_mem9,reg_mem10,reg_mem11,reg_mem12,reg_mem13,reg_mem14;

reg [63:0] reg_mem[0:14];
initial begin
    reg_mem[0] = 0;
    reg_mem[1] = 1;
    reg_mem[2] = 2;
    reg_mem[3] = 2;
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
    if(icode==4'b0010) //cmovq
    begin
        valA=reg_mem[rA];
        valB=64'b0;
    end
    if(icode==4'b0011) //irmovq
        valB=64'b0;
    else if(icode==4'b0100) //rmmovq
    begin
        valA=reg_mem[rA];
        valB=reg_mem[rB];
    end
    else if(icode==4'b0101) //mrmovq
    begin
        valB=reg_mem[rB];
    end
    else if(icode==4'b0110) //OPq
    begin
        valA=reg_mem[rA];
        valB=reg_mem[rB];
    end
    else if(icode==4'b1000) //call
    begin
        valB=reg_mem[4]; 
    end
    else if(icode==4'b1001) //ret
    begin
        valA=reg_mem[4]; 
        valB=reg_mem[4];
    end
    else if(icode==4'b1010) //pushq
    begin
        valA=reg_mem[rA];
        valB=reg_mem[4];
    end
    else if(icode==4'b1011) //popq
    begin
        valA=reg_mem[4]; 
        valB=reg_mem[4];
    end
end


    // writeback 
always@(posedge clk) begin

    if(icode==4'b0010) //cmovxx
    begin
      if(cnd)
        reg_mem[rB]=valE;
    end
    else if(icode==4'b0011) //irmovq
      reg_mem[rB]=valE;

    else if(icode==4'b0101) //mrmovq
    begin
      reg_mem[rA] = valM;
    end
    else if(icode==4'b0110) //OPq
    begin
      reg_mem[rB] = valE;
    end
    else if(icode==4'b1000) //call
    begin
      reg_mem[4] = valE;
    end
    else if(icode==4'b1001) //ret
    begin
      reg_mem[4] = valE;
    end
    else if(icode==4'b1010) //pushq
    begin
      reg_mem[4] = valE;
    end
    else if(icode==4'b1011) //popq
    begin
      reg_mem[4] = valE;
      reg_mem[rA] = valM;
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
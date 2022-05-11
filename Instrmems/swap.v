//.pos 0
// irmovq stack %rsp
    instr_mem[0]=8'h30; //3 0
    instr_mem[1]=8'hF4; //F rB=0
    instr_mem[2]=8'h00;           
    instr_mem[3]=8'h00;           
    instr_mem[4]=8'h00;           
    instr_mem[5]=8'h00;           
    instr_mem[6]=8'h00;           
    instr_mem[7]=8'h00;           
    instr_mem[8]=8'h03;          
    instr_mem[9]=8'hff; //V=1023

// call main
    instr_mem[10]=8'h80; //8 0
    instr_mem[11]=8'h00;
    instr_mem[12]=8'h00;
    instr_mem[13]=8'h00;
    instr_mem[14]=8'h00;
    instr_mem[15]=8'h00;
    instr_mem[16]=8'h00;
    instr_mem[17]=8'h00;
    instr_mem[18]=8'h14;

// halt
    instr_mem[19]=8'h00; //0 0


//main:

// irmovq $0x10 %rdi
    instr_mem[20]=8'h30; //3 0
    instr_mem[21]=8'hF7; //F rB=7
    instr_mem[22]=8'h00;           
    instr_mem[23]=8'h00;           
    instr_mem[24]=8'h00;           
    instr_mem[25]=8'h00;           
    instr_mem[26]=8'h00;           
    instr_mem[27]=8'h00;           
    instr_mem[28]=8'h00;          
    instr_mem[29]=8'h10; //V=16
// irmovq $0xc %rsi
    instr_mem[30]=8'h30; //3 0
    instr_mem[31]=8'hF6; //F rB=6
    instr_mem[32]=8'h00;           
    instr_mem[33]=8'h00;           
    instr_mem[34]=8'h00;           
    instr_mem[35]=8'h00;           
    instr_mem[36]=8'h00;           
    instr_mem[37]=8'h00;           
    instr_mem[38]=8'h00;          
    instr_mem[39]=8'h0c; //V=12
// call gcd
    instr_mem[40]=8'h80; // 8 0
    instr_mem[41]=8'h00;
    instr_mem[42]=8'h00;
    instr_mem[43]=8'h00;
    instr_mem[44]=8'h00;
    instr_mem[45]=8'h00;
    instr_mem[46]=8'h00;
    instr_mem[47]=8'h00;
    instr_mem[48]=8'h32;
// ret
    instr_mem[49]=8'h90; // 9 0

// gcd(%rdx,%rbx)
// swap:
// pushq
instr_mem[50]=8'hA0; //3 0
instr_mem[51]=8'h7f; //F rB=0

// pushq
instr_mem[52]=8'hA0;           
instr_mem[53]=8'h6F;       

// popq
instr_mem[54]=8'hB0;           
instr_mem[55]=8'h7f;           
instr_mem[56]=8'hb0;           
instr_mem[57]=8'h6f;           

// ret
instr_mem[58]=8'h90; // 9 0






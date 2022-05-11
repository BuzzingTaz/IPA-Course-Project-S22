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

// irmovq $0x10 %rdx
    instr_mem[20]=8'h30; //3 0
    instr_mem[21]=8'hF2; //F rB=2
    instr_mem[22]=8'h00;           
    instr_mem[23]=8'h00;           
    instr_mem[24]=8'h00;           
    instr_mem[25]=8'h00;           
    instr_mem[26]=8'h00;           
    instr_mem[27]=8'h00;           
    instr_mem[28]=8'h00;          
    instr_mem[29]=8'h10; //V=16
// irmovq $0xc %rbx
    instr_mem[30]=8'h30; //3 0
    instr_mem[31]=8'hF3; //F rB=3
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
// gcd:
//irmovq $0x0, %rax
instr_mem[50]=8'b00110000; //3 0
instr_mem[51]=8'b00000000; //F rB=0//.pos 0
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

// irmovq $0x10 %rdx
    instr_mem[20]=8'h30; //3 0
    instr_mem[21]=8'hF2; //F rB=2
    instr_mem[22]=8'h00;           
    instr_mem[23]=8'h00;           
    instr_mem[24]=8'h00;           
    instr_mem[25]=8'h00;           
    instr_mem[26]=8'h00;           
    instr_mem[27]=8'h00;           
    instr_mem[28]=8'h00;          
    instr_mem[29]=8'h10; //V=16
// irmovq $0xc %rbx
    instr_mem[30]=8'h30; //3 0
    instr_mem[31]=8'hF3; //F rB=3
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
// gcd:
//irmovq $0x0, %rax
    instr_mem[50]=8'b00110000; //3 0
    instr_mem[51]=8'b00000000; //F rB=0
    instr_mem[52]=8'b00000000;           
    instr_mem[53]=8'b00000000;           
    instr_mem[54]=8'b00000000;           
    instr_mem[55]=8'b00000000;           
    instr_mem[56]=8'b00000000;           
    instr_mem[57]=8'b00000000;           
    instr_mem[58]=8'b00000000;          
    instr_mem[59]=8'b00000000; //V=0
    //jmp check
    instr_mem[60]=8'b01110000; //7 fn
    instr_mem[61]=8'b00000000; //Dest
    instr_mem[62]=8'b00000000; //Dest
    instr_mem[63]=8'b00000000; //Dest
    instr_mem[64]=8'b00000000; //Dest
    instr_mem[65]=8'b00000000; //Dest
    instr_mem[66]=8'b00000000; //Dest
    instr_mem[67]=8'b00000000; //Dest
    instr_mem[68]=8'h45; //Dest=69

    // check:
    // addq %rax, %rbx 
    instr_mem[69]=8'b01100000; //5 fn
    instr_mem[70]=8'b00000011; //rA=0 rB=3
    // je rbxres  
    instr_mem[71]=8'b01110011; //7 fn=3
    instr_mem[72]=8'b00000000; //Dest
    instr_mem[73]=8'b00000000; //Dest
    instr_mem[74]=8'b00000000; //Dest
    instr_mem[75]=8'b00000000; //Dest
    instr_mem[76]=8'b00000000; //Dest
    instr_mem[77]=8'b00000000; //Dest
    instr_mem[78]=8'b00000000; //Dest
    instr_mem[79]=8'h98; //Dest=152
    // addq %rax, %rdx
    instr_mem[80]=8'b01100000; //5 fn
    instr_mem[81]=8'b00000010; //rA=0 rB=2
    // je rdxres 
    instr_mem[82]=8'b01110011; //7 fn=3
    instr_mem[83]=8'b00000000; //Dest
    instr_mem[84]=8'b00000000; //Dest
    instr_mem[85]=8'b00000000; //Dest
    instr_mem[86]=8'b00000000; //Dest
    instr_mem[87]=8'b00000000; //Dest
    instr_mem[88]=8'b00000000; //Dest
    instr_mem[89]=8'b00000000; //Dest
    instr_mem[90]=8'h9B; //Dest=155
    // jmp loop2 
    instr_mem[91]=8'b01110000; //7 fn=0
    instr_mem[92]=8'b00000000; //Dest
    instr_mem[93]=8'b00000000; //Dest
    instr_mem[94]=8'b00000000; //Dest
    instr_mem[95]=8'b00000000; //Dest
    instr_mem[96]=8'b00000000; //Dest
    instr_mem[97]=8'b00000000; //Dest
    instr_mem[98]=8'b00000000; //Dest
    instr_mem[99]=8'h64; //Dest=100

    // loop2:
    // rrmovq %rdx, %rsi 
    instr_mem[100]=8'b00100000; //2 fn=0
    instr_mem[101]=8'b00100110; //rA=2 rB=6
    // rrmovq %rbx, %rdi
    instr_mem[102]=8'b00100000; //2 fn=0
    instr_mem[103]=8'b00110111; //rA=3 rB=7
    // subq %rbx, %rsi
    instr_mem[104]=8'b01100001; //5 fn=1
    instr_mem[105]=8'b00110110; //rA=3 rB=6
    // jge ab1  
    instr_mem[106]=8'b01110101; //7 fn=5
    instr_mem[107]=8'b00000000; //Dest
    instr_mem[108]=8'b00000000; //Dest
    instr_mem[109]=8'b00000000; //Dest
    instr_mem[110]=8'b00000000; //Dest
    instr_mem[111]=8'b00000000; //Dest
    instr_mem[112]=8'b00000000; //Dest
    instr_mem[113]=8'b00000000; //Dest
    instr_mem[114]=8'h7E; //Dest=126
    // subq %rdx, %rdi 
    instr_mem[115]=8'b01100001; //5 fn
    instr_mem[116]=8'b00100111; //rA=2 rB=7
    // jge ab2
    instr_mem[117]=8'b01110101; //7 fn=5
    instr_mem[118]=8'b00000000; //Dest
    instr_mem[119]=8'b00000000; //Dest
    instr_mem[120]=8'b00000000; //Dest
    instr_mem[121]=8'b00000000; //Dest
    instr_mem[122]=8'b00000000; //Dest
    instr_mem[123]=8'b00000000; //Dest
    instr_mem[124]=8'b00000000; //Dest
    instr_mem[125]=8'h8B; //Dest=139

    // ab1:
    // rrmovq %rbx, %rdx
    instr_mem[126]=8'b00100000; //2 fn=0
    instr_mem[127]=8'b00110010; //rA=3 rB=2
    // rrmovq %rsi, %rbx
    instr_mem[128]=8'b00100000; //2 fn=0
    instr_mem[129]=8'b01100011; //rA=6 rB=3
    // jmp check
    instr_mem[130]=8'b01110000; //7 fn=0
    instr_mem[131]=8'b00000000; //Dest
    instr_mem[132]=8'b00000000; //Dest
    instr_mem[133]=8'b00000000; //Dest
    instr_mem[134]=8'b00000000; //Dest
    instr_mem[135]=8'b00000000; //Dest
    instr_mem[136]=8'b00000000; //Dest
    instr_mem[137]=8'b00000000; //Dest
    instr_mem[138]=8'h45; //Dest=69

    // ab2:
    // rrmovq %rbx, %rdx
    instr_mem[139]=8'b00100000; //2 fn=0
    instr_mem[140]=8'b00110010; //rA=3 rB=2
    // rrmovq %rdi, %rbx
    instr_mem[141]=8'b00100000; //2 fn=0
    instr_mem[142]=8'b01110011; //rA=7 rB=3
    // jmp check
    instr_mem[143]=8'b01110000; //7 fn=0
    instr_mem[144]=8'b00000000; //Dest
    instr_mem[145]=8'b00000000; //Dest
    instr_mem[146]=8'b00000000; //Dest
    instr_mem[147]=8'b00000000; //Dest
    instr_mem[148]=8'b00000000; //Dest
    instr_mem[149]=8'b00000000; //Dest
    instr_mem[150]=8'b00000000; //Dest
    instr_mem[151]=8'h45; //Dest=69

    // rbxres:
    // rrmovq %rdx, %rcx
    instr_mem[152]=8'b00100000; //2 fn=0
    instr_mem[153]=8'b00100001; //rA=2 rB=1
    // ret
    instr_mem[154]=8'h90; // 9 0

    // rdxres:
    // rrmovq %rbx, %rcx
    instr_mem[155]=8'b00100000; //2 fn=0
    instr_mem[156]=8'b00110001; //rA=3 rB=1
    // ret
    instr_mem[157]=8'h90; // 9 0
instr_mem[52]=8'b00000000;           
instr_mem[53]=8'b00000000;           
instr_mem[54]=8'b00000000;           
instr_mem[55]=8'b00000000;           
instr_mem[56]=8'b00000000;           
instr_mem[57]=8'b00000000;           
instr_mem[58]=8'b00000000;          
instr_mem[59]=8'b00000000; //V=0
//jmp check
instr_mem[60]=8'b01110000; //7 fn
instr_mem[61]=8'b00000000; //Dest
instr_mem[62]=8'b00000000; //Dest
instr_mem[63]=8'b00000000; //Dest
instr_mem[64]=8'b00000000; //Dest
instr_mem[65]=8'b00000000; //Dest
instr_mem[66]=8'b00000000; //Dest
instr_mem[67]=8'b00000000; //Dest
instr_mem[68]=8'h45; //Dest=69

// check:
// addq %rax, %rbx 
instr_mem[69]=8'b01100000; //5 fn
instr_mem[70]=8'b00000011; //rA=0 rB=3
// je rbxres  
instr_mem[71]=8'b01110011; //7 fn=3
instr_mem[72]=8'b00000000; //Dest
instr_mem[73]=8'b00000000; //Dest
instr_mem[74]=8'b00000000; //Dest
instr_mem[75]=8'b00000000; //Dest
instr_mem[76]=8'b00000000; //Dest
instr_mem[77]=8'b00000000; //Dest
instr_mem[78]=8'b00000000; //Dest
instr_mem[79]=8'h98; //Dest=152
// addq %rax, %rdx
instr_mem[80]=8'b01100000; //5 fn
instr_mem[81]=8'b00000010; //rA=0 rB=2
// je rdxres 
instr_mem[82]=8'b01110011; //7 fn=3
instr_mem[83]=8'b00000000; //Dest
instr_mem[84]=8'b00000000; //Dest
instr_mem[85]=8'b00000000; //Dest
instr_mem[86]=8'b00000000; //Dest
instr_mem[87]=8'b00000000; //Dest
instr_mem[88]=8'b00000000; //Dest
instr_mem[89]=8'b00000000; //Dest
instr_mem[90]=8'h9B; //Dest=155
// jmp loop2 
instr_mem[91]=8'b01110000; //7 fn=0
instr_mem[92]=8'b00000000; //Dest
instr_mem[93]=8'b00000000; //Dest
instr_mem[94]=8'b00000000; //Dest
instr_mem[95]=8'b00000000; //Dest
instr_mem[96]=8'b00000000; //Dest
instr_mem[97]=8'b00000000; //Dest
instr_mem[98]=8'b00000000; //Dest
instr_mem[99]=8'h64; //Dest=100

// loop2:
// rrmovq %rdx, %rsi 
instr_mem[100]=8'b00100000; //2 fn=0
instr_mem[101]=8'b00100110; //rA=2 rB=6
// rrmovq %rbx, %rdi
instr_mem[102]=8'b00100000; //2 fn=0
instr_mem[103]=8'b00110111; //rA=3 rB=7
// subq %rbx, %rsi
instr_mem[104]=8'b01100001; //5 fn=1
instr_mem[105]=8'b00110110; //rA=3 rB=6
// jge ab1  
instr_mem[106]=8'b01110101; //7 fn=5
instr_mem[107]=8'b00000000; //Dest
instr_mem[108]=8'b00000000; //Dest
instr_mem[109]=8'b00000000; //Dest
instr_mem[110]=8'b00000000; //Dest
instr_mem[111]=8'b00000000; //Dest
instr_mem[112]=8'b00000000; //Dest
instr_mem[113]=8'b00000000; //Dest
instr_mem[114]=8'h7E; //Dest=126
// subq %rdx, %rdi 
instr_mem[115]=8'b01100001; //5 fn
instr_mem[116]=8'b00100111; //rA=2 rB=7
// jge ab2
instr_mem[117]=8'b01110101; //7 fn=5
instr_mem[118]=8'b00000000; //Dest
instr_mem[119]=8'b00000000; //Dest
instr_mem[120]=8'b00000000; //Dest
instr_mem[121]=8'b00000000; //Dest
instr_mem[122]=8'b00000000; //Dest
instr_mem[123]=8'b00000000; //Dest
instr_mem[124]=8'b00000000; //Dest
instr_mem[125]=8'h8B; //Dest=139

// ab1:
// rrmovq %rbx, %rdx
instr_mem[126]=8'b00100000; //2 fn=0
instr_mem[127]=8'b00110010; //rA=3 rB=2
// rrmovq %rsi, %rbx
instr_mem[128]=8'b00100000; //2 fn=0
instr_mem[129]=8'b01100011; //rA=6 rB=3
// jmp check
instr_mem[130]=8'b01110000; //7 fn=0
instr_mem[131]=8'b00000000; //Dest
instr_mem[132]=8'b00000000; //Dest
instr_mem[133]=8'b00000000; //Dest
instr_mem[134]=8'b00000000; //Dest
instr_mem[135]=8'b00000000; //Dest
instr_mem[136]=8'b00000000; //Dest
instr_mem[137]=8'b00000000; //Dest
instr_mem[138]=8'h45; //Dest=69

// ab2:
// rrmovq %rbx, %rdx
instr_mem[139]=8'b00100000; //2 fn=0
instr_mem[140]=8'b00110010; //rA=3 rB=2
// rrmovq %rdi, %rbx
instr_mem[141]=8'b00100000; //2 fn=0
instr_mem[142]=8'b01110011; //rA=7 rB=3
// jmp check
instr_mem[143]=8'b01110000; //7 fn=0
instr_mem[144]=8'b00000000; //Dest
instr_mem[145]=8'b00000000; //Dest
instr_mem[146]=8'b00000000; //Dest
instr_mem[147]=8'b00000000; //Dest
instr_mem[148]=8'b00000000; //Dest
instr_mem[149]=8'b00000000; //Dest
instr_mem[150]=8'b00000000; //Dest
instr_mem[151]=8'h45; //Dest=39

// rbxres:
// rrmovq %rdx, %rcx
instr_mem[152]=8'b00100000; //2 fn=0
instr_mem[153]=8'b00100001; //rA=2 rB=1
// ret
instr_mem[154]=8'h90; // 9 0

// rdxres:
// rrmovq %rbx, %rcx
instr_mem[155]=8'b00100000; //2 fn=0
instr_mem[156]=8'b00110001; //rA=3 rB=1
// ret
instr_mem[157]=8'h90; // 9 0






module fetch(D_stat,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,f_predPC,M_icode,M_cnd,M_valA,W_icode,W_valM,F_predPC,clk,F_stall,D_stall,D_bubble);

    input clk;                              // clock input
    input [3:0] M_icode,W_icode;
    input [63:0] M_valA,W_valM;
    input M_cnd;
    input [63:0] F_predPC;                  // predicted input from prev instruction
    input F_stall,D_stall,D_bubble;

    output reg [3:0] D_icode, D_ifun;           // icode is the type of instruction. ifun gives the exact instruction
    output reg [3:0] D_rA, D_rB;                // rA rB register/memory addresses
    output reg [63:0] D_valC;                 // 8 byte values. either immediate or displacement
    output reg [63:0] D_valP;                 // incremented PC
    output reg [0:3] D_stat=4'b1000;                  // AOK, HLT, ADR, INS
    output reg [63:0] f_predPC;               // predicted PC

    reg [3:0] icode, ifun;           // icode is the type of instruction. ifun gives the exact instruction
    reg [3:0] rA, rB;                // rA rB register/memory addresses
    reg [63:0] valC;                 // 8 byte values. either immediate or displacement
    reg [63:0] valP;                 // incremented PC
    reg imem_error=0, instr_valid=1; // flags
    reg [0:3] stat;                  // AOK, HLT, ADR, INS
    reg [0:79] instr;                   // Current instruction
    reg [7:0] instr_mem[0:2048];       // Instruction memory
    reg [63:0] PC;                           // Program counter

    //Maybe remove later
    initial 
        PC = F_predPC;

    always@*
    begin
        // $display("working");
            // Selecting PC
        if(M_icode==4'h7 & !M_cnd)  // Jump not taken
            PC = M_valA;
        else if(W_icode==4'h9)      // Return statement
            PC = W_valM;
        else
            PC = F_predPC;          // Default
    end

    // Combinational block
    always@* 
    begin 

        instr_valid=1;
        // imem_error=0;
        if(PC>2048)
        begin
            imem_error=1;
        end

        instr = {instr_mem[PC],instr_mem[PC+1],instr_mem[PC+2],instr_mem[PC+3],instr_mem[PC+4],instr_mem[PC+5],instr_mem[PC+6],instr_mem[PC+7],instr_mem[PC+8],instr_mem[PC+9]};
        {icode, ifun} = instr[0:7];

        // Fetching rA rB valC values based on instruction
        // updating valP, f_predPC
        case (icode)
        4'h0:
            begin
                valP=PC;              // halt
                f_predPC=valP;
            end
        4'h1:begin
                valP=PC+1;              // nop
                f_predPC=valP;
        end
        4'h2:begin                   // cmovq
                {rA,rB}=instr[8:15];
                valP=PC+2;
                f_predPC = valP;
        end
        4'h3:begin                  // irmovq
                {rA,rB,valC}=instr[8:79];
                valP=PC+10;
                f_predPC = valP;
        end
        4'h4:begin                  // rmmovq
            {rA,rB,valC}=instr[8:79];
            valP=PC+10;
            f_predPC = valP;
        end
        4'h5:begin                  // mrmovq
            {rA,rB,valC}=instr[8:79];
            valP=PC+10;
            f_predPC = valP;
        end
        4'h6:begin                  // OPq
            {rA,rB}=instr[8:15];
            valP=PC+2;
            f_predPC = valP;
        end
        4'h7:begin                  //jxx
            valC=instr[8:71];
            valP=PC+9;
            f_predPC = valC;
        end
        4'h8:begin                  //call
            valC=instr[8:71];
            valP=PC+9;
            f_predPC = valC;
        end
        4'h9:valP=PC+1;             //ret                    
        4'hA:begin                  //pushq
            {rA,rB}=instr[8:15];
            valP=PC+2;
            f_predPC = valP;
        end
        4'hB:begin                  //popq
            {rA,rB}=instr[8:15];
            valP=PC+2;
            f_predPC = valP;
        end
        default: begin                    // invalid instruction
            // $display("hello icode=%d",icode);
            instr_valid=1'b0;
        end
        endcase


        if(instr_valid==0)
        stat = 4'b0001;
        else if(imem_error==1)
        begin
            $display("Hi");
        stat = 4'b0010;
        end
        else if(icode==4'b0000)
        stat = 4'b0100;
        else
        stat = 4'b1000;

    end

    // Assigning to decode registers
    always@(posedge clk)
    begin
        if(F_stall)
        begin
            PC = F_predPC;
        end

        if(D_stall)
        begin
        end
        else if(D_bubble)
        begin
            D_icode <= 4'b0001;
            D_ifun <= 4'b0000;
            D_rA <= 4'b0000;
            D_rB <= 4'b0000;
            D_valC <= 64'b0;
            D_valP <= 64'b0;
            D_stat <= 4'b1000;
        end
        else
        begin
            D_icode <= icode;
            D_ifun <= ifun;
            D_rA <= rA;
            D_rB <= rB;
            D_valC <= valC;
            D_valP <= valP;
            D_stat <= stat;
        end
    end

    initial begin
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



    end

endmodule
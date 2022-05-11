module fetch(icode,ifun,rA,rB,valC,valP,imem_error,instr_valid,clk,PC,instr);

    input clk;                              // clock input
    input [63:0] PC;                        // Program counter
    input [0:79] instr;                     // Current instruction
    output reg [3:0] icode, ifun;           // icode is the type of instruction. ifun gives the exact instruction
    output reg [3:0] rA, rB;                // rA rB register/memory addresses
    output reg [63:0] valC;                 // 8 byte values. either immediate or displacement
    output reg [63:0] valP;                 // incremented PC
    output reg imem_error=0, instr_valid=1; // flags

    // Combinational block
    always@* 
    begin 

        // imem_error=0;
        if(PC>20480)
        begin
            imem_error=1;
        end

        {icode, ifun} = instr[0:7];

        case (icode)
        4'h0:valP=PC+1;              // halt
        4'h1:valP=PC+1;              // nop
        4'h2:begin                   // cmovq
                {rA,rB}=instr[8:15];
                valP=PC+2;
        end
        4'h3:begin                  // irmovq
                {rA,rB,valC}=instr[8:79];
                valP=PC+10;
        end
        4'h4:begin                  // rmmovq
            {rA,rB,valC}=instr[8:79];
            valP=PC+10;
        end
        4'h5:begin                  // mrmovq
            {rA,rB,valC}=instr[8:79];
            valP=PC+10;
        end
        4'h6:begin                  // OPq
            {rA,rB}=instr[8:15];
            valP=PC+2;
        end
        4'h7:begin                  //jxx
            valC=instr[8:71];
            valP=PC+9;
        end
        4'h8:begin                  //call
            valC=instr[8:71];
            valP=PC+9;
        end
        4'h9:                       //ret
            valP=PC+1;
        4'hA:begin                  //pushq
            {rA,rB}=instr[8:15];
            valP=PC+2;
        end
        4'hB:begin                  //popq
            {rA,rB}=instr[8:15];
            valP=PC+2;
        end
        default:                    // invalid instruction
            instr_valid=1'b0;
    endcase
    end

endmodule
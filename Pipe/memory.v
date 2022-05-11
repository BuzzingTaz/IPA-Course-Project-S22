module memory(W_stat,W_icode,W_valE,W_valM,W_dstE,W_dstM,m_valM,m_stat,
            M_stat,M_icode,M_cnd,M_valE,M_valA,M_dstE,M_dstM,clk,W_stall);

    input clk;
    input [0:3] M_stat;
    input [3:0] M_icode;
    input M_cnd;
    input [63:0] M_valE,M_valA;
    input [3:0] M_dstE,M_dstM;
    input W_stall;
    output reg [0:3] W_stat;
    output reg [3:0] W_icode;
    output reg [63:0] W_valE,W_valM;
    output reg [3:0] W_dstE,W_dstM;
    output reg [63:0] m_valM;
    output reg [0:3] m_stat;

    reg [63:0] data_mem [0:1023];
    reg dmem_error = 0;
    reg check_valE,check_valA;

    always @*
    begin
        if(dmem_error)
            m_stat = 4'b0010;
        else
            m_stat = M_stat;
    end

    always @*
    begin
        if(M_icode==4'h4 | M_icode==4'h5 | M_icode==4'h8 | M_icode==4'hB)
            check_valE = 1;
        else
            check_valE = 0;

        if(M_icode==4'h9 | M_icode==4'hB)
            check_valA = 1;
        else
            check_valA = 0;
    end

    always@*
    begin
        if((M_valE>1023 & check_valE) | (M_valA>1023 & check_valA))
            dmem_error = 1;
        case(M_icode)
            4'h5:  m_valM = data_mem[M_valE];   // mrmovq
            4'h9:  m_valM = data_mem[M_valA];   // ret
            4'hB:  m_valM = data_mem[M_valA];   // popq
        endcase
    end

    always@(posedge clk)
    begin 
        if((M_valE>1023 & check_valE) | (M_valA>1023 & check_valA))
            dmem_error = 1;
        case(M_icode)
            4'h4:  data_mem[M_valE] <= M_valA;  // rmmovq
            4'h8:  data_mem[M_valE] <= M_valA;  // call
            4'hA:  data_mem[M_valE] <= M_valA;  // pushq
        endcase
        end

    always@(posedge clk)
    begin
        if(W_stall)
        begin
        end
        else
        begin
            W_stat <= m_stat;
            W_icode <= M_icode;
            W_valE <= M_valE;
            W_valM <= m_valM;
            W_dstE <= M_dstE;
            W_dstM <= M_dstM;
        end
    end
endmodule
module memory(valM,dmem_error,clk,icode,valE,valA,valP);
    input clk;
    input [3:0] icode;
    input [63:0] valE, valP;
    input [63:0] valA;
    output reg [63:0] valM;
    output reg dmem_error=0;

    reg [63:0] data_mem [0:1023];
    reg check_valE,check_valA;

always @*
begin
    if(icode==4'h4 | icode==4'h5 | icode==4'h8 | icode==4'hB)
        check_valE = 1;
    else
        check_valE = 0;

    if(icode==4'h9 | icode==4'hB)
        check_valA = 1;
    else
        check_valA = 0;
end

always@*
begin
    if((valE>1023 & check_valE) | (valA>1023 & check_valA))
        dmem_error = 1;
    case(icode)
        4'h5:  valM = data_mem[valE];   // mrmovq
        4'h9:  valM = data_mem[valA];   // ret
        4'hB:  valM = data_mem[valA];   // popq
    endcase
end

always@(posedge clk)
begin 
    if((valE>1023 & check_valE))
        dmem_error = 1;
    case(icode)
        4'h4:  data_mem[valE] <= valA;  // rmmovq
        4'h8:  data_mem[valE] <= valP;  // call
        4'hA:  data_mem[valE] <= valA;  // pushq
    endcase
end
endmodule
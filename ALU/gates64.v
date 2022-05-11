`ifndef GATES64
`define GATES64

module not64(Out, A);

    input [63:0] A;
    output [63:0] Out;
 
    // 64 bit not
    genvar k;

    for(k=0; k<64; k=k+1) begin
        not(Out[k],A[k]);
    end


endmodule

module and64(Out, A, B);

    input [63:0] A, B;
    output [63:0] Out;
    
    // 64 bit and
    genvar k;

    for(k = 0; k < 64; k = k + 1) begin
        and(Out[k], A[k], B[k]);
    end

endmodule

module xor64(Out, A, B);

    input [63:0] A, B;
    output [63:0] Out;
    
    genvar k;
    
    for(k=0; k<64; k=k+1) begin
        xor(Out[k], A[k], B[k]);
    end


endmodule

`endif
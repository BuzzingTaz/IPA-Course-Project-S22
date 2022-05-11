module and_test;


wire [63:0] Out;
reg [63:0] A=64'b0000000000000000000000000000000000000000000000000000000000000001, B=64'b0000000000000000000000000000000000000000000000000000000000000000, ans;

and64 DUT(
    .A(A),
    .B(B),
    .Out(Out)
);

integer k, j, correct=0, wrong=0;

always @ (A or B) begin
    ans = A&B;
end

initial begin
    $dumpfile("andVerilog.vcd");
    $dumpvars(0,and_test);
    // $monitor($time," ,%d ,%d", S, ans);
    $monitor($time," A=%b B=%b Out=%b", A,B,Out);

    for(k = 0; k < 256; k = k + 1)
    begin
        A = A+1;
        for(j = 0; j < 256; j = j + 1)
        begin
            B = B+1;
            
            if(ans^Out)
            begin
                wrong = wrong+1;
            end
            else begin
                correct = correct+1;
            end

            #5;
        end
        B=0;
    end

    $display("correct=%d wrong=%d", correct, wrong);
end

endmodule

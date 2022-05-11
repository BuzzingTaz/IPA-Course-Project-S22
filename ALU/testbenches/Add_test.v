module adder_test;

wire signed [63:0] S;
wire Cout, error;
reg signed [63:0] A=64'b0000000000000000000000000000000000000000000000000000000000000001, B=64'b0000000000000000000000000000000000000000000000000000000000000000, ans;
reg Cin=0;
Adder_64bit DUT(
    .A(A),
    .B(B),
    .Cin(Cin),
    .Cout(Cout),
    .S(S),
    .error(error)
);

integer k, j, correct=0, wrong=0;

always@(A or B)
begin
    B_1 = ~B + 1;
    ans = A+B_1;
end

initial begin
    $dumpfile("adderVerilog.vcd");
    $dumpvars(0,adder_test);
    // $monitor($time," ,%d ,%d", S, ans);
    $monitor($time," A=%d B=%d Cout=%b S=%d, erorr=%b, ans=%d", A,B,Cout,S, error, ans);


    for(k = 0; k < 256; k = k + 1)
    begin
        A = A+1;
        for(j = 0; j < 256; j = j + 1)
        begin
            B = B+1;

            if(ans^S)
            begin
                wrong = wrong+1;
            end
            else begin
                correct = correct+1;
            end

            #5;
        end

    end
    $display("correct=%d wrong=%d", correct, wrong);

end

endmodule

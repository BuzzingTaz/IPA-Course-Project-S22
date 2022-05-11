module ALU_test;

wire signed [63:0] out;
wire Cout, OF;
reg signed [63:0] A=7870992480675748942, B=-8252321028086873738, ans, B_1;
reg [1:0] control = 3;  // 0: add, 1: sub, 2: and, 3: xor;

ALU DUT(
    .out(out),
    .Cout(Cout),
    .A(A),
    .B(B),
    .control(control),
    .OF(OF)
);


integer k, j, correct=0, wrong=0;

always@(A or B)
begin
    if (control==0)
    ans = A+B;

    else if (control==1)
    begin
        B_1 = ~B + 1;
        ans = A+B_1;
    end

    else if (control==2)
        ans = A&B;

    else if (control==3)
        ans = A^B;
end


initial begin
    $dumpfile("ALUVerilog.vcd");
    $dumpvars(0,ALU_test);
    // $monitor($time," ,%d ,%d", S, ans);
    $monitor($time," A=%b B=%b Cout=%b out=%b, OF=%b, ans=%b", A, B, Cout, out, OF, ans);


    for(k = 0; k < 4; k = k + 1)
    begin
        A = A+1;
        for(j = 0; j < 4; j = j + 1)
        begin
            B = B+1;

            if(ans^out)
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

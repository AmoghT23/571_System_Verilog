module tb_fourbitDEC;

reg[1:0]a;
wire[3:0]y;
reg [3:0] expected;

fourbitDEC uut(.a(a),.y(y));

  initial begin
        for (int i = 0; i < 4; i = i + 1) begin
            a = i;
            // Give output time to settle
            #1;
            expected = 4'b0001 << i;
	if(y===expected)
	$display("a=%b, y=%b, expected=%b|PASS",a,y,expected);
	else
	$display("a=%b, y=%b, expected=%b|FAIL",a,y,expected);
	end
	end
endmodule

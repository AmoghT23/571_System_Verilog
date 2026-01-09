module tb_fourbitFA;

logic [3:0]a,b;
logic [3:0]sum;
logic [4:0]expected;
logic carry;

fourbitFA uut(.a(a), .b(b), .sum(sum), .carry(carry));

initial
begin
	$dumpfile("dump.vcd");
    	$dumpvars(1);
	$display("  a    |   b    |   sum    |  carry  |  Expected Carry   | Result");


for(int i = 0; i<16; i= i+1) begin
	for(int j=0; j<16; j=j+1) begin
		a = i[3:0];
		b = j[3:0];
		#1;

	expected = a+b;
	
	if({carry, sum} === expected) 
		$display("a=%b | b=%b | sum=%b | carry=%b | expected_carry=%b  | PASS", 
			   a, b, sum, carry, expected[4]);
	else
		 $display("a=%b | b=%b | sum=%b | carry=%b | expected_carry=%b  | FAIL",
			    a, b, sum, carry, expected[4]); 
		end
	end
end
endmodule


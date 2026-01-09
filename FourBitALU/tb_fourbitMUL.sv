module tb_fourbitMUL;

reg [3:0]a,b;
wire [7:0]product;

fourbitMUL uut(.a(a), .b(b), .product(product));

reg [7:0] expected;

initial
begin
	$dumpfile("dump.vcd");
    	$dumpvars(1);
	$display("  a    |   b    |   product    |     Expected Product   | Result");


for(int i = 0; i<16; i= i+1) begin
	for(int j=0; j<16; j=j+1) begin
		a = i;
		b = j;
		#1;

	expected = a*b;
	
	if({product} === expected) 
		$display("a=%b | b=%b | product=%b | expected_product=%b  | PASS", 
			   a, b, product, expected);
	else
		 $display("a=%b | b=%b | product=%b | expected_product=%b  | FAIL",
			    a, b, product, expected); 
		end
	end
end
endmodule

module fourbitDEC(input logic [1:0]a, 
		 output logic [3:0]y);

assign y[0] = ~a[1] & ~a[0];
assign y[1] = ~a[1] & a[0];
assign y[2] = a[1] & ~a[0];
assign y[3] = a[1] & a[0];
endmodule

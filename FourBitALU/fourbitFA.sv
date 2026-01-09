module fourbitFA(input logic[3:0] a,b,
		output logic [3:0] sum, 
		output logic carry);

logic [2:0]c;

onebitFA fa0(.a(a[0]), .b(b[0]), .cin(1'b0), .sum(sum[0]), .carry(c[0]));
onebitFA fa1(.a(a[1]), .b(b[1]), .cin(c[0]), .sum(sum[1]), .carry(c[1]));
onebitFA fa2(.a(a[2]), .b(b[2]), .cin(c[1]), .sum(sum[2]), .carry(c[2]));
onebitFA fa3(.a(a[3]), .b(b[3]), .cin(c[2]), .sum(sum[3]), .carry(carry));


endmodule

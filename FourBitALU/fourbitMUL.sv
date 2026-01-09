module fourbitMUL(input logic [3:0]a,b,
		  output logic [7:0]product);

 wire [3:0] pp0, pp1, pp2, pp3;
    wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12;
    wire s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11;

    // Partial products
    assign pp0 = a & {4{b[0]}};
    assign pp1 = a & {4{b[1]}};
    assign pp2 = a & {4{b[2]}};
    assign pp3 = a & {4{b[3]}};

    // First product bit (LSB)
    assign product[0] = pp0[0];

    // Second bit using half adder structure
    onebitFA fa1 (.a(pp0[1]), .b(pp1[0]), .cin(1'b0), .sum(product[1]), .carry(c1));

    // Third bit
    onebitFA fa2 (.a(pp0[2]), .b(pp1[1]), .cin(c1), .sum(s1), .carry(c2));
    onebitFA fa3 (.a(s1), .b(pp2[0]), .cin(1'b0), .sum(product[2]), .carry(c3));

    // Fourth bit
    onebitFA fa4 (.a(pp0[3]), .b(pp1[2]), .cin(c2), .sum(s2), .carry(c4));
    onebitFA fa5 (.a(s2), .b(pp2[1]), .cin(c3), .sum(s3), .carry(c5));
    onebitFA fa6 (.a(s3), .b(pp3[0]), .cin(1'b0), .sum(product[3]), .carry(c6));

    // Fifth bit
    onebitFA fa7 (.a(pp1[3]), .b(pp2[2]), .cin(c4), .sum(s4), .carry(c7));
    onebitFA fa8 (.a(s4), .b(pp3[1]), .cin(c5), .sum(s5), .carry(c8));
    onebitFA fa9 (.a(s5), .b(c6), .cin(1'b0), .sum(product[4]), .carry(c9));

    // Sixth bit
    onebitFA fa10 (.a(pp2[3]), .b(pp3[2]), .cin(c7), .sum(s6), .carry(c10));
    onebitFA fa11 (.a(s6), .b(c8), .cin(c9), .sum(product[5]), .carry(c11));

    // Seventh bit
    onebitFA fa12 (.a(pp3[3]), .b(c10), .cin(c11), .sum(product[6]), .carry(product[7]));

endmodule 






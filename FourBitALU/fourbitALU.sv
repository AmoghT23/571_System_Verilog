module fourbitALU(input logic [3:0]a,b,
		  input logic [2:0]opcode,
		  output logic[7:0]result);

typedef enum logic [2:0]{
	ADD = 3'b000,
	SUB = 3'b001,
	MUL = 3'b010,
	AND = 3'b011,
	DEC = 3'b100} four_alu;

logic [3:0] sum;
logic carry;
logic [7:0] product;
logic [3:0] y;

fourbitFA s_add (.a(a), .b(b), .sum(sum), .carry(carry));
fourbitMUL s_mul (.*);
fourbitDEC s_dec (.a(a[1:0]), .y(y));

logic [7:0] ta,ts,tand,td;

assign ta = {3'b000, carry,sum};
assign td = {4'b0000, y};

always @(a or b) begin
ts={4'b0000, (a-b)};
tand={4'b0000, (a&b)};
end

always@* begin
case (opcode)
ADD : result = ta;
SUB : result = ts;
MUL : result = product;
AND : result = tand;
DEC : result = td;
default: result = 8'd0;
endcase

end

endmodule

typedef enum  logic[2:0]{
	ADD = 3'b000,
	SUB = 3'b001,
	MUL = 3'b010,
	AND = 3'b011,
	DEC = 3'b100} four_alu;


module tb_fourbitALU;

logic [3:0] a,b;
four_alu opcode;
wire [7:0] result;

logic [7:0] exp_r;

logic [3:0] s,d;
logic cout;

fourbitALU dut (.*);

initial
begin

for (int oc =0; oc <=8; oc++) begin
opcode = four_alu'(oc);

for (int i=0; i<16;i++) begin
for (int j=0; j<16;j++) begin
a=i[3:0];
b=j[3:0];
#1;


{cout,s} = a+b;
d = 4'b0001 << a[1:0];

case (opcode)
ADD : exp_r = {3'b000,cout,s};
SUB : exp_r = {4'b0000, (a-b)};
MUL : exp_r = a*b;
AND : exp_r = {4'b0000,(a&b)};
DEC : exp_r = {4'b0000,d};
default: exp_r = 8'b00000000;
endcase

if(result!=exp_r)
$display("Error: a=%b b=%b opcode=%b Expected result=%b Got result=%b",a,b,opcode,exp_r,result);


$display("a=%b b=%b opcode=%b Expected result=%b Got result=%b %s",a,b,opcode,exp_r,result,(result===exp_r) ? "PASS" : "FAIL");

end
end
end
$finish;
end
endmodule

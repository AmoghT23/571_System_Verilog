//This is the package with name fp 
package fp;

	parameter int EXPONENT_BITS = 8;		//Parameter for exponent bits size
	parameter int FRACTION_BITS = 23;		//Parameter for fraction bits size

typedef struct packed{
				logic 			  sign;
  				logic [EXPONENT_BITS-1:0] exp;
  				logic [FRACTION_BITS-1:0] frac;
				} float; 

function float fpnumberfromcomponents (
				input logic sign, 
				logic [EXPONENT_BITS-1:0] exp,
				logic [FRACTION_BITS-1:0] frac); 

				float f;
				f.sign = sign;
				f.exp = exp;
				f.frac = frac;
				return f;
endfunction 

function float fpnumberfromshortreal (input shortreal sr);

				float f;
				logic [31:0]bits;
				
				bits = $shortrealtobits(sr);
				f.sign = bits[31];
				f.exp = bits[30:23];
				f.frac = bits[22:0];
				return f;

endfunction 
    
function shortreal shortrealfromfpnumber (input float f); 
				logic [31:0] bits;
				bits = {f.sign, f.exp, f.frac};
	
				return $bitstoshortreal(bits);
endfunction 

function void printfp (input float f); 

				$display("float: sign=%0d exp=0x%0h frac=0x%0h",f.sign, f.exp, f.frac);
endfunction 
  
endpackage : fp


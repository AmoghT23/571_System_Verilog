//This is the Alignment Module Design
import fp::*;

module fp_alignment (
    input float bign,
    input float smalln,
    output float aligned
);

    logic [fp::EXPONENT_BITS-1:0] exp_diff;
    logic [fp::FRACTION_BITS:0] temp_frac; 
    logic [fp::FRACTION_BITS-1:0] shifted_frac;

    always_comb begin
	//Calculating the difference between the exponents 
        exp_diff = bign.exp - smalln.exp; 

        temp_frac = {1'b1, smalln.frac};

        temp_frac = temp_frac >> exp_diff;

        shifted_frac = temp_frac[FRACTION_BITS-1:0];

        aligned.sign = smalln.sign;    
        aligned.exp  = bign.exp;       
        aligned.frac = shifted_frac;  
    end

endmodule



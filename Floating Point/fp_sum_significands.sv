//This is the Sum Significand Module Design 
import fp::*;

module fp_sum_significands (
    input  fp::float bign,      
    input  fp::float smalln,   

    output logic [fp::FRACTION_BITS+1:0] sum
);

    logic [fp::FRACTION_BITS:0] big_sig;
    logic [fp::FRACTION_BITS:0] small_sig;

    logic add_op;

    always_comb begin
        add_op = (bign.sign == smalln.sign);
        
        big_sig   = { (bign.exp  != 0), bign.frac   };
        small_sig = { (smalln.exp != 0), smalln.frac };

        if (add_op) begin
            sum = {1'b0, big_sig} + {1'b0, small_sig}; 
        end
        else begin
            sum = {1'b0, big_sig} - {1'b0, small_sig}; 
        end
    end

endmodule

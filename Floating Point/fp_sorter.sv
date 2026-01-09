//This is the Sorter Module Design 
import fp::*;

module fp_sorter(
		input float a,
		input float b,
		output float bign,
  		output float smalln);

  always_comb begin
	//Comparing the value of exponents
    	if(a.exp > b.exp) begin
      		bign = a;
      		smalln = b; 
    	end
    
    	else if (a.exp < b.exp)begin
      		bign = b;
      		smalln = a;
    	end 

	else begin
	//Comparing the values of the fraction
        if ({1'b1, a.frac} >= {1'b1, b.frac}) begin
          bign   = a;
          smalln = b;
        end
        else begin
          bign   = b;
          smalln = a;
        end
      end
    end
endmodule 


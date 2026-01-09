module DaysDetector(m, LY, d27, d28);
  
  input [4:0]m;
  input LY;
  output d27, d28;
  
  assign d27 = m[0] & ~LY;
  
  assign d28 = m[0] | m[2] & m[1] & m[0] & LY;
  
endmodule

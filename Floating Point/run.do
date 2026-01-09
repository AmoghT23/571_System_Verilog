vlib work           
vdel -all          
vlib work  


vlog fp_pkg.sv     
vlog fp_sorter.sv +acc 
vlog fp_sorter_tb.sv +acc  

vlog fp_alignment.sv +acc 
vlog fp_alignment_tb.sv +acc 

vlog fp_sum_significands.sv +acc  
vlog fp_sum_significands_tb.sv +acc  

vlog fp_adder.sv +acc 
vlog fp_adder_tb.sv +acc 


# 1. Run fp_sorter_tb
vsim -c work.fp_sorter_tb -do "run -all; quit" -t 1ns

# 2. Run fp_alignment_tb
vsim -c work.fp_alignment_tb -do "run -all; quit" -t 1ns

# 3. Run fp_sum_significands_tb
vsim -c work.fp_sum_significands_tb -do "run -all; quit" -t 1ns

# 4. Run fp_adder_tb
vsim -c work.fp_adder_tb -do "run -all; quit" -t 1ns

 add wave -r *
 run -all


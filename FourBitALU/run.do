vlib work
vdel -all
vlib work

vlog onebitFA.sv +acc
vlog fourbitFA.sv +acc
vlog fourbitMUL.sv +acc
vlog fourbitDEC.sv +acc
vlog fourbitALU.sv +acc
vlog tb_fourbitALU.sv +acc

vsim work.tb_fourbitALU
add wave -r *
run -all

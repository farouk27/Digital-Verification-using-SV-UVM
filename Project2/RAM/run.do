vlib work
vlog -f src_files.txt
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all
add wave -position insertpoint sim:/top/ram_regif/*
coverage save ram.ucdb -onexit 
run -all
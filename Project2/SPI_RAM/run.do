vlib work
vlog -f src_files.txt
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all
add wave -position insertpoint sim:/top/spi_regif/*
run 0
coverage save spi.ucdb -onexit 
run -all
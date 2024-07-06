vlog	FIFO_coverage_pkg.sv FIFO_scoreboard_pkg.sv shared_pkg.sv FIFO_transaction_pkg.sv +cover
vlog	FIFO.sv FIFO_if.sv FIFO_MONITOR.sv FIFO_TB.sv FIFO_TOP.sv +cover 
vsim -voptargs=+acc work.FIFO_TOP -cover

add wave *
add wave -position insertpoint  \
sim:/FIFO_TOP/TB/FIFO_OBJ \
sim:/FIFO_TOP/TB/FIFO_CHECK
coverage save FIFO.ucdb -onexit
run -all
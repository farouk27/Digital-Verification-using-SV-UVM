vlib work
vlog project_ram.sv ram_if.sv  ram_monitor.sv ram_sva.sv ram_tb.sv ram_top.sv -covercells
vsim -voptargs=+acc work.ram_top -cover 
add wave * 
coverage save ram.ucdb -onexit 
run -all

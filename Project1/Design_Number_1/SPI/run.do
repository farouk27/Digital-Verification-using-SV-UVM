vlib work
vlog spi_wrapper_package.sv spi_wrapper.sv project_spi.v project_ram.sv spi_wrapper_interface.sv  spi_wrapper_monitor.sv spi_wrapper_tb.sv spi_wrapper_top.sv -covercells
vsim -voptargs=+acc work.spi_wrapper_top -cover 
add wave -position insertpoint  \
sim:/spi_wrapper_top/dut/w_if/clk \
sim:/spi_wrapper_top/dut/w_if/MOSI \
sim:/spi_wrapper_top/dut/w_if/MISO \
sim:/spi_wrapper_top/dut/w_if/rst_n \
sim:/spi_wrapper_top/dut/w_if/SS_n
add wave -position insertpoint  \
sim:/spi_wrapper_top/dut/w_if/clk \
sim:/spi_wrapper_top/dut/w_if/MOSI \
sim:/spi_wrapper_top/dut/w_if/MISO \
sim:/spi_wrapper_top/dut/w_if/rst_n \
sim:/spi_wrapper_top/dut/w_if/SS_n
add wave -position insertpoint  \
sim:/spi_wrapper_top/dut/m2/din \
sim:/spi_wrapper_top/dut/m2/rx_valid \
sim:/spi_wrapper_top/dut/m2/rst_n \
sim:/spi_wrapper_top/dut/m2/tx_valid \
sim:/spi_wrapper_top/dut/m2/dout \
sim:/spi_wrapper_top/dut/m2/WRITE_ADD \
sim:/spi_wrapper_top/dut/m2/READ_ADD \
sim:/spi_wrapper_top/dut/m2/mem

coverage save spi.ucdb -onexit 
run -all

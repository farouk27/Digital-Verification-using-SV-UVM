import uvm_pkg::*;
import spi_test_pkg::*;
`include "uvm_macros.svh"

module top();

bit clk;

initial begin
forever
#1 clk =~clk;
end

spi_wrapper_interface spi_regif(clk);

spi_wrapper DUT(spi_regif);


initial begin
uvm_config_db#(virtual spi_wrapper_interface)::set(null,"uvm_test_top","SPI_IF",spi_regif);
run_test("spi_test");
end 

endmodule

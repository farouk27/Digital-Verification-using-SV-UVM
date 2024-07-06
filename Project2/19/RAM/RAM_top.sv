import uvm_pkg::*;
import ram_test_pkg::*;
`include "uvm_macros.svh"

module top();

bit clk;

initial begin
forever
#1 clk =~clk;
end

RAM_if ram_regif(clk);

spi_ram DUT(ram_regif);

bind spi_ram ram_sva ram_sva_instan(ram_regif.ASSERTIONS);

initial begin
uvm_config_db#(virtual RAM_if)::set(null,"uvm_test_top","RAM_IF",ram_regif);
run_test("ram_test");
end 

endmodule

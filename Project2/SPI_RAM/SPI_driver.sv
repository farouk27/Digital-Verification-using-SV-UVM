package spi_driver_pkg;

import spi_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_driver extends uvm_driver #(spi_seq_item);

`uvm_component_utils(spi_driver)


virtual spi_wrapper_interface spi_config_vif;


spi_seq_item stim_seq_item;


function new(string name = "spi_driver",uvm_component parent = null);
super.new(name ,parent);

endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction


task run_phase(uvm_phase phase);

super.run_phase(phase);

forever begin

stim_seq_item = spi_seq_item::type_id::create("stim_seq_item");


seq_item_port.get_next_item(stim_seq_item);


spi_config_vif.rst_n = stim_seq_item.rst_n;
foreach(stim_seq_item.MOSI[i])
begin
	@(negedge spi_config_vif.clk)
	spi_config_vif.SS_n = stim_seq_item.SS_n;
	spi_config_vif.MOSI = stim_seq_item.MOSI[i];
end
	@(negedge spi_config_vif.clk); 
	spi_config_vif.SS_n = 1'b1 ; 

	repeat(8)
	begin
		@(negedge spi_config_vif.clk); 
  		stim_seq_item.MISO = spi_config_vif.MISO;
	end
	@(negedge spi_config_vif.clk);
seq_item_port.item_done();
`uvm_info("run_phase", stim_seq_item.convert2string_stimulus(),UVM_HIGH)
end
endtask

endclass

endpackage

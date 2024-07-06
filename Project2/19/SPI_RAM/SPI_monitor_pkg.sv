package spi_monitor_pkg;

import spi_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"


class spi_monitor extends uvm_monitor;

`uvm_component_utils(spi_monitor)


virtual spi_wrapper_interface spi_config_vif;


spi_seq_item rsp_seq_item;


uvm_analysis_port #(spi_seq_item) mon_ap;

function new(string name = "spi_monitor" , uvm_component parent = null );
super.new(name,parent);
endfunction

// only building the monitor component and the port connection
function void build_phase (uvm_phase phase);
super.build_phase(phase);
mon_ap = new("mon_ap",this);
endfunction : build_phase


task run_phase(uvm_phase phase);

super.run_phase(phase);

forever begin

rsp_seq_item = spi_seq_item::type_id::create("rsp_seq_item");

rsp_seq_item.rst_n = spi_config_vif.rst_n;

foreach(rsp_seq_item.MOSI[i])
begin
	@(negedge spi_config_vif.clk)
	rsp_seq_item.MOSI[i] = spi_config_vif.MOSI;
end

@(negedge spi_config_vif.clk)
rsp_seq_item.SS_n = spi_config_vif.SS_n;

repeat(8)
begin
	@(negedge spi_config_vif.clk);
	rsp_seq_item.MISO = spi_config_vif.MISO;
end

@(negedge spi_config_vif.clk);

mon_ap.write(rsp_seq_item);
`uvm_info("run_phase", rsp_seq_item.convert2string(),UVM_HIGH)
end
endtask

endclass

endpackage

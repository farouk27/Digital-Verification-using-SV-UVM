package ram_monitor_pkg;

import ram_seq_item_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"


class ram_monitor extends uvm_monitor;

`uvm_component_utils(ram_monitor)


virtual RAM_if ram_config_vif;


ram_seq_item rsp_seq_item;


uvm_analysis_port #(ram_seq_item) mon_ap;

function new(string name = "ram_monitor" , uvm_component parent = null );
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

rsp_seq_item = ram_seq_item::type_id::create("rsp_seq_item");

@(negedge ram_config_vif.clk);

rsp_seq_item.rst_n = ram_config_vif.rst_n;
rsp_seq_item.din = ram_config_vif.din;
rsp_seq_item.rx_valid = ram_config_vif.rx_valid;
rsp_seq_item.tx_valid = ram_config_vif.tx_valid;
rsp_seq_item.dout = ram_config_vif.dout;



mon_ap.write(rsp_seq_item);
`uvm_info("run_phase", rsp_seq_item.convert2string(),UVM_HIGH)
end
endtask

endclass

endpackage

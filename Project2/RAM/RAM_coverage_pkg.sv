package ram_coverage_pkg ; 

import ram_seq_item_pkg::* ;
import uvm_pkg::* ; 
`include "uvm_macros.svh"


class ram_coverage extends uvm_component ; 

`uvm_component_utils(ram_coverage)

ram_seq_item seq_item_cov ;
uvm_analysis_export#(ram_seq_item) cov_export ;
uvm_tlm_analysis_fifo#(ram_seq_item) cov_fifo ; 


covergroup cg;
    reset_cp  : coverpoint  seq_item_cov.rst_n {
    bins zero = {0};
    bins one = {1};
    bins one_then_zero = (1 => 0);
    bins zero_then_one = (0 => 1);
    option.auto_bin_max = 0;
}

    din_cp : coverpoint seq_item_cov.din {
	bins min = {10'd0};
	bins max = {10'h3FF};
	option.auto_bin_max = 0;
} 
    rx_valid_cp  : coverpoint seq_item_cov.rx_valid {
	bins zero = {0};
    	bins one = {1};
    	bins one_then_zero = (1 => 0);
    	bins zero_then_one = (0 => 1);
	option.auto_bin_max = 0;
}
    tx_valid_cp : coverpoint seq_item_cov.tx_valid {
	bins zero = {0};
    	bins one = {1};
    	bins one_then_zero = (1 => 0);
    	bins zero_then_one = (0 => 1);
	option.auto_bin_max = 0;
} 
   /* dout_cp : coverpoint seq_item_cov.dout {
	bins min = {8'd0};
	bins max = {8'hFF};
	option.auto_bin_max = 0;
}*/

endgroup


function new (string name = "RAM_coverage" ,uvm_component parent= null ) ; 
    super.new(name , parent) ;
    cg =new() ; 
  
endfunction

function void build_phase (uvm_phase phase);

    super.build_phase(phase) ; 
    cov_export=new("cov_export",this) ; 
    cov_fifo=new("cov_fifo",this) ; 

endfunction

function void connect_phase(uvm_phase phase) ; 

    super.connect_phase(phase)                   ; 
    cov_export.connect(cov_fifo.analysis_export) ; 
    
endfunction

task run_phase (uvm_phase phase);
    
    super.run_phase(phase) ;
    forever begin
        cov_fifo.get(seq_item_cov) ; 
        cg.sample() ; 

    end 

endtask 


endclass

endpackage

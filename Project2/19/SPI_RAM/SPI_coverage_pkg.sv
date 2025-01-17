package spi_coverage_pkg ; 

import spi_seq_item_pkg::* ;
import uvm_pkg::* ; 
`include "uvm_macros.svh"


class spi_coverage extends uvm_component ; 

`uvm_component_utils(spi_coverage)

spi_seq_item seq_item_cov ;
uvm_analysis_export#(spi_seq_item) cov_export ;
uvm_tlm_analysis_fifo#(spi_seq_item) cov_fifo ; 


covergroup cg;
    reset_cp  : coverpoint  seq_item_cov.rst_n {
    bins zero = {0};
    bins one = {1};
    bins one_then_zero = (1 => 0);
    bins zero_then_one = (0 => 1);
    option.auto_bin_max = 0;
}
    MOSI_cp1 : coverpoint seq_item_cov.MOSI[10:8] 
			{
	          bins MOSI_wr_address = {3'b000};
	          bins MOSI_wr_data = {3'b001};
	          bins MOSI_rd_address = {3'b110};
		  	bins MOSI_rd_data = {3'b111};
			option.auto_bin_max = 0;
			}			

	       MOSI_cp2 : coverpoint seq_item_cov.MOSI[7:0] 
			{
	          bins MOSI_first_addr = {8'h00};
	          bins MOSI_last_addr = {8'hFF};
	          bins rest_MOSI = {[8'h01 : 8'hFE]};
			  option.auto_bin_max = 0;
			}	
			
			
	       SS_n_cp : coverpoint seq_item_cov.SS_n 
			{
				bins SS_n_0 = {0} ; 
				bins SS_n_1 = {1} ;
				option.auto_bin_max = 0;
			}

endgroup


function new (string name = "spi_coverage" ,uvm_component parent= null ) ; 
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
        cg.sample(); 
    end 

endtask 


endclass

endpackage

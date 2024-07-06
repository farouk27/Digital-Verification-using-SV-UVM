package spi_env_pkg ; 

import uvm_pkg::* ; 
import spi_agent_pkg::* ; 
import spi_coverage_pkg::*; 
`include "uvm_macros.svh"

class spi_env extends uvm_env  ; 
`uvm_component_utils(spi_env)

spi_agent agent ; 
spi_coverage cvg_collector ; 


function new (string name = "spi_env" ,uvm_component parent= null ) ; 
    super.new(name , parent) ; 
endfunction


function void build_phase (uvm_phase phase );
    super.build_phase(phase);

    agent = spi_agent::type_id::create("agent", this ); 
    cvg_collector = spi_coverage::type_id::create("cvg_collector", this ); 
   
endfunction

function void connect_phase (uvm_phase phase ) ; 
    //super.connect_phase(phase) ;
    agent.agt_ap.connect(cvg_collector.cov_export) ;
endfunction


endclass

endpackage

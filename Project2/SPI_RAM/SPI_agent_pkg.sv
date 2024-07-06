package spi_agent_pkg ; 

import spi_monitor_pkg::* ; 
import spi_driver_pkg::* ; 
import spi_sequencer_pkg::* ; 
import spi_seq_item_pkg::* ; 
import spi_config_obj_pkg::* ; 

import uvm_pkg ::* ; 
`include "uvm_macros.svh"


class spi_agent extends uvm_agent ; 


`uvm_component_utils(spi_agent)

uvm_analysis_port#(spi_seq_item) agt_ap ; 


spi_driver driver ; 
spi_sequencer sqr; 
spi_config_obj agent_config_obj ; 
spi_monitor monitor ; 
 

function new (string name = "spi_agent" ,uvm_component parent= null ) ; 
    super.new(name , parent) ;
endfunction


function void build_phase (uvm_phase phase );
    super.build_phase(phase);

    if(!uvm_config_db #(spi_config_obj)::get(this , "" , "CFG" , agent_config_obj )) 
         `uvm_fatal("agent build phase" , " Agent - Unable to get configuration object ") ;

    driver= spi_driver::type_id::create("driver", this ); 
    sqr= spi_sequencer::type_id::create("sqr", this ); 
    monitor = spi_monitor::type_id::create("monitor", this ); 
    agt_ap = new("agt_ap" , this ) ; 

endfunction


function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    monitor.mon_ap.connect(agt_ap) ; 

    driver.spi_config_vif = agent_config_obj.spi_config_vif ; 
    monitor.spi_config_vif = agent_config_obj.spi_config_vif ; 
    
    driver.seq_item_port.connect(sqr.seq_item_export) ;

endfunction

endclass

endpackage 

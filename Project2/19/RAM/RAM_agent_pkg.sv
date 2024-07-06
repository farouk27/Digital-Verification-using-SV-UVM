package ram_agent_pkg ; 

import ram_monitor_pkg::* ; 
import ram_driver_pkg::* ; 
import ram_sequencer_pkg::* ; 
import ram_seq_item_pkg::* ; 
import ram_config_obj_pkg::* ; 

import uvm_pkg ::* ; 
`include "uvm_macros.svh"


class ram_agent extends uvm_agent ; 


`uvm_component_utils(ram_agent)

uvm_analysis_port#(ram_seq_item) agt_ap ; 


ram_driver driver ; 
ram_sequencer sqr; 
ram_config_obj agent_config_obj ; 
ram_monitor monitor ; 
 

function new (string name = "ram_agent" ,uvm_component parent= null ) ; 
    super.new(name , parent) ;
endfunction


function void build_phase (uvm_phase phase );
    super.build_phase(phase);

    if(!uvm_config_db #(ram_config_obj)::get(this , "" , "CFG" , agent_config_obj )) 
         `uvm_fatal("agent build phase" , " Agent - Unable to get configuration object ") ;

    driver= ram_driver::type_id::create("driver", this ); 
    sqr= ram_sequencer::type_id::create("sqr", this ); 
    monitor = ram_monitor::type_id::create("monitor", this ); 
    agt_ap = new("agt_ap" , this ) ; 

endfunction


function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
    monitor.mon_ap.connect(agt_ap) ; 

    driver.ram_config_vif = agent_config_obj.ram_config_vif ; 
    monitor.ram_config_vif = agent_config_obj.ram_config_vif ; 
    
    driver.seq_item_port.connect(sqr.seq_item_export) ;

endfunction

endclass

endpackage 

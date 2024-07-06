package spi_test_pkg ; 

import uvm_pkg::* ; 
`include "uvm_macros.svh"

import spi_env_pkg::* ; 
import rst_seq::*;
import main_seq::*;
import spi_config_obj_pkg ::* ; 


class spi_test extends uvm_test ; 

`uvm_component_utils(spi_test) 

// creating a virtual interface
virtual spi_wrapper_interface spi_config_vif ; 

spi_env environment ; 
spi_config_obj configuration_object ; 

reset_sequence rst_seq;
random_sequence main_seq;

function new (string name = "spi_test" ,uvm_component parent= null ) ; 
    super.new(name , parent) ; 
endfunction


function void build_phase (uvm_phase phase);

    super.build_phase(phase) ; 
    environment = spi_env::type_id::create("environment", this) ;
    configuration_object = spi_config_obj::type_id::create("configuration_object", this) ;
	
	main_seq = random_sequence::type_id::create("main_seq");
    rst_seq = reset_sequence::type_id::create("rst_seq");

    if(!uvm_config_db #(virtual spi_wrapper_interface)::get(this , "" , "SPI_IF" , configuration_object.spi_config_vif ) )
        `uvm_fatal("build phase" , " Test - Unable to get interafce object ") ; 
    
    uvm_config_db #(spi_config_obj)::set(this , "*" , "CFG" , configuration_object ) ; 
    
endfunction
int i = 0;

task run_phase (uvm_phase phase);
    super.run_phase(phase) ; 

    phase.raise_objection(this);
	
	`uvm_info("run_phase", "Reset Asserted", UVM_HIGH);
	rst_seq.start(environment.agent.sqr);
	`uvm_info("run_phase", "Reset Deasserted", UVM_HIGH);
	

    repeat(300) begin
	
       ` uvm_info("run_phase", "Stimulus Generation Started", UVM_HIGH);
        main_seq.start(environment.agent.sqr);
        `uvm_info("run_phase", "Stimulus Generation Ended", UVM_HIGH);
	i++;
 	$display("Test_Num: %d" , i);
	end
    phase.drop_objection(this) ; 


endtask

endclass

endpackage




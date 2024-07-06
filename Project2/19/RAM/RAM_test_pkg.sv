package ram_test_pkg ; 

import uvm_pkg::* ; 
`include "uvm_macros.svh"

import ram_env_pkg::* ; 
import Wr_Addr_seq::* ; 
import Rd_Addr_seq::* ; 
import Rd_Data_seq::* ; 
import Wr_Data_seq::* ;
import rst_seq::* ; 
import ram_config_obj_pkg ::* ; 


class ram_test extends uvm_test ; 

`uvm_component_utils(ram_test) 

// creating a virtual interface
virtual RAM_if ram_config_vif ; 

ram_env environment ; 

ram_config_obj configuration_object ; 

write_address_sequence wr_addr_seq ; 
write_data_sequence wr_data_seq ; 

read_address_sequence rd_addr_seq ;
read_data_sequence rd_data_seq ;

reset_sequence reset_seq ; 



function new (string name = "ram_test" ,uvm_component parent= null ) ; 
    super.new(name , parent) ; 
endfunction


function void build_phase (uvm_phase phase);

    super.build_phase(phase) ; 
    environment = ram_env::type_id::create("environment", this) ;
    configuration_object = ram_config_obj::type_id::create("configuration_object", this) ;

    wr_addr_seq  = write_address_sequence::type_id::create("wr_addr_seq", this) ;
    wr_data_seq  = write_data_sequence::type_id::create("wr_data_seq", this) ;

    rd_addr_seq  = read_address_sequence::type_id::create("rd_addr_seq", this) ;
    rd_data_seq  = read_data_sequence::type_id::create("rd_data_seq", this) ;

    reset_seq = reset_sequence::type_id::create("reset_seq", this) ;


    if(!uvm_config_db #(virtual RAM_if)::get(this , "" , "RAM_IF" , configuration_object.ram_config_vif ) )
        `uvm_fatal("build phase" , " Test - Unable to get interafce object ") ; 
    
    uvm_config_db #(ram_config_obj)::set(this , "*" , "CFG" , configuration_object ) ; 
    
endfunction


task run_phase (uvm_phase phase);
    super.run_phase(phase) ; 

    phase.raise_objection(this) ;
    `uvm_info("run phase ","Reset asserted " , UVM_HIGH) 
    reset_seq.start(environment.agent.sqr) ; 
    `uvm_info("run phase ","Reset Deasserted " , UVM_HIGH) 
repeat(1000) begin
    `uvm_info("run phase ", "Stimulus generation started  " , UVM_HIGH) 
     wr_addr_seq.start(environment.agent.sqr) ;

     wr_data_seq.start(environment.agent.sqr) ; 

     rd_addr_seq.start(environment.agent.sqr) ; 

     rd_data_seq.start(environment.agent.sqr) ;

    `uvm_info("run phase ","Stimulus generation Ended" , UVM_HIGH) 
end
    phase.drop_objection(this) ; 


endtask

endclass

endpackage




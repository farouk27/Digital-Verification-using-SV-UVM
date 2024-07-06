package ram_env_pkg ; 

import uvm_pkg::* ; 
import ram_agent_pkg::* ; 
import ram_scoreboard_pkg::* ; 
import ram_coverage_pkg::*; 
`include "uvm_macros.svh"

class ram_env extends uvm_env  ; 

`uvm_component_utils(ram_env)

ram_agent agent ; 
ram_scoreboard score_board_env ; 
ram_coverage cvg_collector ; 


function new (string name = "ram_env" ,uvm_component parent= null ) ; 
    super.new(name , parent) ; 
endfunction


function void build_phase (uvm_phase phase );
    super.build_phase(phase);

    agent = ram_agent::type_id::create("agent", this ); 
    score_board_env = ram_scoreboard::type_id::create("score_board_env", this ); 
    cvg_collector = ram_coverage::type_id::create("cvg_collector", this ); 
   

endfunction

function void connect_phase (uvm_phase phase ) ; 
    //super.connect_phase(phase) ;
    agent.agt_ap.connect(score_board_env.sb_export) ;
    agent.agt_ap.connect(cvg_collector.cov_export) ;
endfunction


endclass

endpackage

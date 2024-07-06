package ram_scoreboard_pkg;

import uvm_pkg::* ;
import ram_seq_item_pkg::* ; 
import ram_config_obj_pkg::*;
`include "uvm_macros.svh"

class ram_scoreboard extends uvm_scoreboard ; 

`uvm_component_utils(ram_scoreboard)

ram_config_obj configuration_object;

uvm_analysis_export#(ram_seq_item) sb_export ;


uvm_tlm_analysis_fifo#(ram_seq_item) sb_fifo ; 


ram_seq_item seq_item_sb ;


logic [7:0] dout_ref  ; 

reg [7:0] EXP_WRITE_ADD, EXP_READ_ADD;
reg [7:0] exp_mem [255:0];

int correct_count = 0 ; 
int error_count = 0 ; 

function new (string name = "ram_scoreboard" ,uvm_component parent= null ) ; 
    super.new(name , parent) ; 
endfunction


function void build_phase (uvm_phase phase );
    super.build_phase(phase);
    sb_export=new("sb_export",this) ; 
    sb_fifo = new("sb_fifo",this) ; 
endfunction

function void connect_phase(uvm_phase phase ) ; 
    super.connect_phase(phase);
    sb_export.connect(sb_fifo.analysis_export) ;

endfunction

task run_phase(uvm_phase phase) ; 
    super.run_phase(phase) ; 

    forever begin
        sb_fifo.get(seq_item_sb) ; 
        ref_model(seq_item_sb) ; 
        
        if(seq_item_sb.dout !== dout_ref )begin
            `uvm_error("run_phase ", $sformatf("Comparison failed , Transaction received by the DUT :%s While the referenece out :%0b" ,
            seq_item_sb.convert2string(),dout_ref ) ); 
            error_count ++ ;
        end
        else  begin
            `uvm_info("run_phase" , $sformatf("Correct DOUT %s" ,seq_item_sb.convert2string() ),UVM_HIGH ) ; 
            correct_count++ ; 
        end
    end

endtask

task ref_model(ram_seq_item seq_item_chk);

    if(!seq_item_chk.rst_n) begin
	seq_item_chk.tx_valid = 'b0;
        EXP_WRITE_ADD =8'b0;
        EXP_READ_ADD =8'b0;
	end
    else if(seq_item_chk.rx_valid == 1 ) begin
        if (seq_item_chk.din[9:8] == 2'b00) begin 
            EXP_WRITE_ADD = seq_item_chk.din[7:0];
	    seq_item_chk.tx_valid = 1'b0;
        end 
	else if(seq_item_chk.din[9:8] == 2'b01)  begin// 
         	exp_mem[EXP_WRITE_ADD] = seq_item_chk.din[7:0];
		seq_item_chk.tx_valid = 1'b0;
        end
	else if(seq_item_chk.din[9:8] == 2'b10)  begin// 
         	EXP_READ_ADD = seq_item_chk.din[7:0];
		seq_item_chk.tx_valid = 1'b0;
        end

	else if(seq_item_chk.din[9:8] == 2'b11)  begin// 
         	dout_ref = exp_mem[EXP_READ_ADD];
      		seq_item_chk.tx_valid = 1'b1;
        end
    end
  else
	seq_item_chk.tx_valid = 1'b0;
endtask

function void report_phase(uvm_phase phase) ; 

    super.report_phase(phase) ; 
    `uvm_info("report_phase" , $sformatf("Total successful transactions  %0d" ,correct_count ),UVM_MEDIUM ) ; 
    `uvm_info("report_phase" , $sformatf("Total failed transactions  %0d" ,error_count ),UVM_MEDIUM ) ; 

endfunction 

endclass





endpackage

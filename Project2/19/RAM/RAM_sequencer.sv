package ram_sequencer_pkg;

import ram_seq_item_pkg :: *;
import uvm_pkg :: *;
`include "uvm_macros.svh"

class ram_sequencer extends uvm_sequencer #(ram_seq_item);

	`uvm_component_utils(ram_sequencer)

	function new(string name = "ram_sequencer", uvm_component parent = null);

		super.new(name, parent);
	
	endfunction	

endclass

endpackage

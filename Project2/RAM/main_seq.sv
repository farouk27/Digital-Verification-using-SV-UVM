package main_seq;

import uvm_pkg::*;
import ram_seq_item_pkg::*;
`include "uvm_macros.svh"

class random_sequence extends uvm_sequence #(ram_seq_item);

`uvm_object_utils(random_sequence)

ram_seq_item sequence_item;

function new(string name = "random_sequence");

super.new(name);

endfunction

task body;

	for(int i = 0;i< sequence_item.tests;i++) begin
		
		sequence_item = ram_seq_item::type_id::create("sequence_item");

		start_item(sequence_item);

		assert(sequence_item.randomize());
		finish_item(sequence_item);

	end
endtask


endclass
endpackage



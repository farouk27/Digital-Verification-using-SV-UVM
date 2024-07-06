package main_seq;

import uvm_pkg::*;
import spi_seq_item_pkg::*;
`include "uvm_macros.svh"

class random_sequence extends uvm_sequence #(spi_seq_item);

`uvm_object_utils(random_sequence)

spi_seq_item sequence_item;

function new(string name = "random_sequence");

super.new(name);

endfunction

task body;

	for(int i = 0;i< sequence_item.tests;i++) begin
		
		sequence_item = spi_seq_item::type_id::create("sequence_item");

		start_item(sequence_item);

		assert(sequence_item.randomize());
		finish_item(sequence_item);

	end
endtask


endclass
endpackage



package Wr_Data_seq;

import uvm_pkg::*;
import ram_seq_item_pkg::*;
`include "uvm_macros.svh"

class write_data_sequence extends uvm_sequence #(ram_seq_item);

`uvm_object_utils(write_data_sequence)


ram_seq_item sequence_item;

int i =0;

function new(string name = "write_data_sequence");

super.new(name);

endfunction


task body;


		sequence_item = ram_seq_item::type_id::create("sequence_item");

		start_item(sequence_item);

		assert(sequence_item.randomize());
		sequence_item.din[9:8]=2'b01;
		sequence_item.din[7:0]=sequence_item.datain_array[i];
		i++;
		finish_item(sequence_item);

endtask


endclass
endpackage

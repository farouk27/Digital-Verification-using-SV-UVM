package rst_seq;

import uvm_pkg::*;
import spi_seq_item_pkg::*;
`include "uvm_macros.svh"

class reset_sequence extends uvm_sequence #(spi_seq_item);

`uvm_object_utils(reset_sequence)

spi_seq_item sequence_item;

function new(string name = "reset_sequence");

super.new(name);

endfunction

task body;


sequence_item = spi_seq_item::type_id::create("sequence_item");

start_item(sequence_item);

sequence_item.rst_n = 1'b0;

finish_item(sequence_item);

endtask

endclass
endpackage




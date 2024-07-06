package ram_seq_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

class ram_seq_item extends uvm_sequence_item;

`uvm_object_utils(ram_seq_item)

  rand bit rst_n;
  bit [9:0] din;
  rand bit rx_valid;
  bit tx_valid;
  logic [7:0] dout;

  parameter MAX_VALUE = 10'h3FF;
  parameter MIN_VALUE = 10'h0;
  parameter tests = 1000;
  rand logic [9:0] datain_array [tests-1:0];
  rand logic [7:0] address_array [tests-1:0];


function new(string name = "ram_seq_item");

super.new(name);


endfunction

function string convert2string();

	return $sformatf("%s reset = 0b%0b , din = 0b%0b , rx_valid = 0b%0b , tx_valid = 0b%0b , dout = 0b%0b", 
        super.convert2string(),rst_n,din,rx_valid,tx_valid,dout);

endfunction

function string convert2string_stimulus();

	return $sformatf("reset = 0b%0b , din = 0b%0b , rx_valid = 0b%0b , tx_valid = 0b%0b , dout = 0b%0b ",rst_n,din,rx_valid,tx_valid,dout);

endfunction


constraint rst_n_c {
	rst_n dist  {1:=99 , 0:=1};
}

constraint rx_valid_c {
   rx_valid dist {1:/90 , 0:/10};
}

constraint din_c {
   din dist { MAX_VALUE :/10 , MIN_VALUE :/10 , [MIN_VALUE+1:MAX_VALUE-1] };
}

endclass

endpackage


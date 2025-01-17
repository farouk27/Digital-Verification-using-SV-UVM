package spi_seq_item_pkg;

import uvm_pkg::*;
`include "uvm_macros.svh"

class spi_seq_item extends uvm_sequence_item;

`uvm_object_utils(spi_seq_item)
parameter FRAME_SIZE = 11;
parameter tests = 300;
bit [2:0] old_value_10_8;
		/*				input 				*/
		rand bit rst_n ;
		rand bit [FRAME_SIZE-1:0]  MOSI ; 
		rand bit SS_n ; 
		
		/*				outputs 			*/
		bit  MISO ; 
		
function new(string name = "spi_seq_item");

super.new(name);


endfunction

function string convert2string();

	return $sformatf("%s rst_n = 0b%0b , MOSI = 0b%0b , SS_n = 0b%0b , MISO = 0b%0b ", 
        super.convert2string(),rst_n,MOSI,SS_n,MISO);

endfunction

function string convert2string_stimulus();

	return $sformatf("rst_n = 0b%0b , MOSI = 0b%0b , SS_n = 0b%0b",rst_n,MOSI,SS_n);

endfunction

	/*				constraints 					*/
		constraint rst_n_c {
			rst_n dist {1:=99 , 0:=1} ; 
		}

		constraint  ss_n_c {
			SS_n dist {0:=98 , 1:=2};
		}

		constraint MOSI_c {
			(old_value_10_8==3'b000) -> MOSI[10:8]==3'b001 ; 
			(old_value_10_8==3'b110) -> MOSI[10:8]==3'b111 ; 
		}

		constraint MOSI_7_0{
			MOSI[7:0] inside {[0:255]};
		}

		function void post_randomize();
			old_value_10_8 = MOSI[10:8] ; 
		endfunction 

endclass

endpackage


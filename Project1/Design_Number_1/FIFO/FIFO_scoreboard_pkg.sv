package FIFO_scoreboard_pkg;

import FIFO_transaction_pkg ::*;
import shared_pkg ::*;

class FIFO_scoreboard;
/********	PARAMETARS	********/
parameter	FIFO_WIDTH	= 16;
parameter	FIFO_DEPTH	= 8;
/********	VARIABLES	********/
bit	[FIFO_WIDTH-1:0]	data_out_ref;
bit				wr_ack_ref, overflow_ref;
bit				full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref;
/********	FIFO MODEL 	********/
bit	[2:0]			w_addr , r_addr;
bit	[3:0]			counter;

bit	[FIFO_WIDTH - 1 : 0]	FIFO_MEM	[FIFO_DEPTH];

function new();
	w_addr		= 0;
	r_addr		= 0;
	counter		= 0;
	empty_ref	= 1;
endfunction

function void flags_calc;
	
	if(counter == 0)
		empty_ref = 1'b1;
	else
		empty_ref = 1'b0;

	if(counter == 1)
		almostempty_ref = 1'b1;
	else
		almostempty_ref = 1'b0;

	if(counter == (FIFO_DEPTH ))
		full_ref = 1'b1;
	else
		full_ref = 1'b0;

	if(counter == (FIFO_DEPTH - 1))
		almostfull_ref = 1'b1;
	else
		almostfull_ref = 1'b0;
endfunction

function void reference_model(input FIFO_transaction FIFO_txn);
	flags_calc;

	if(!FIFO_txn.rst_n)
	begin
		w_addr	= 0;
		r_addr	= 0;

		counter	= 0;

		overflow_ref = 1'b0;
		underflow_ref = 1'b0;
		wr_ack_ref = 1'b0;
	end
	
	else
	begin
		overflow_ref = (FIFO_txn.wr_en && full_ref)? 1'b1 : 1'b0;
		underflow_ref = (FIFO_txn.rd_en && empty_ref)? 1'b1 : 1'b0;
			begin
				if(FIFO_txn.rd_en && (!empty_ref))
				begin
					data_out_ref = FIFO_MEM[r_addr];
					r_addr ++;
				end
			end

			begin
				if(FIFO_txn.wr_en && counter < (FIFO_DEPTH))
				begin
					FIFO_MEM[w_addr] = FIFO_txn.data_in;
					wr_ack_ref = 1'b1;
					w_addr ++;
				end
				else
				begin
					wr_ack_ref = 1'b0;
				end
			end

			begin
				if({FIFO_txn.wr_en, FIFO_txn.rd_en} == 2'b11)
				begin
					if(empty_ref)
						counter ++ ;
					else if(full_ref)
						counter -- ;
				end
				else if( ({FIFO_txn.wr_en, FIFO_txn.rd_en} == 2'b10) && !full_ref) 
					counter ++ ;
				else if ( ({FIFO_txn.wr_en, FIFO_txn.rd_en} == 2'b01) && !empty_ref)
					counter -- ;
			end
		
	end
	flags_calc;
endfunction

function void check_data(input FIFO_transaction received_txn);
	logic	[7:0]	concat_ref_flags , concat_obj_flags;

	reference_model(received_txn);
	
	concat_ref_flags = {wr_ack_ref, overflow_ref,full_ref, empty_ref, almostfull_ref, almostempty_ref, underflow_ref};
	concat_obj_flags = {received_txn.wr_ack, received_txn.overflow,received_txn.full, received_txn.empty, received_txn.almostfull, received_txn.almostempty, received_txn.underflow};
	if((data_out_ref == received_txn.data_out) && (concat_ref_flags == concat_obj_flags))
	begin
		correct_count ++;
	end
	else
	begin
		error_count ++;
		$display("ERROR HAPPEND AT TIME = %t" , $time());
	end 

endfunction

endclass

endpackage

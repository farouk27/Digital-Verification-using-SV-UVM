package	FIFO_coverage_pkg;

import FIFO_transaction_pkg ::*;

class	FIFO_coverage;

FIFO_transaction F_cvg_txn;

/****************	COVERGROUP	***********************/
covergroup cg;

	wr_en_cp	: coverpoint F_cvg_txn.wr_en;
	rd_en_cp	: coverpoint F_cvg_txn.rd_en;
	/*********	THE OUTPUT FLAGS     ***********/
	wr_ack_cp	: coverpoint F_cvg_txn.wr_ack;
	overflow_cp	: coverpoint F_cvg_txn.overflow;
	full_cp		: coverpoint F_cvg_txn.full;
	empty_cp	: coverpoint F_cvg_txn.empty;
	almostfull_cp	: coverpoint F_cvg_txn.almostfull;
	almostempty_cp	: coverpoint F_cvg_txn.almostempty;
	underflow_cp	: coverpoint F_cvg_txn.underflow;
	/************************************************/
	wr_en_rd_en_cross	: cross	wr_en_cp , rd_en_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(rd_en_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(rd_en_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(rd_en_cp) intersect {0});
					}
	/******************************************************************************************************************************/
	wr_en_wr_ack_cross	: cross	wr_en_cp , wr_ack_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(wr_ack_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(wr_ack_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(wr_ack_cp) intersect {0});
					}
	wr_en_overflow_cross	: cross	wr_en_cp , overflow_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(overflow_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(overflow_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(overflow_cp) intersect {0});
					}
	wr_en_full_cross	: cross	wr_en_cp , full_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(full_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(full_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(full_cp) intersect {0});
					}
	wr_en_empty_cross	: cross	wr_en_cp , empty_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(empty_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(empty_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(empty_cp) intersect {0});
					}
	wr_en_almostfull_cross	: cross	wr_en_cp , almostfull_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(almostfull_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(almostfull_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(almostfull_cp) intersect {0});
					}
	wr_en_almostempty_cross	: cross	wr_en_cp , almostempty_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(almostempty_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(almostempty_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(almostempty_cp) intersect {0});
					}
	wr_en_underflow_cross	: cross	wr_en_cp , underflow_cp{
						bins detect_ones = (binsof(wr_en_cp) intersect {1}) && (binsof(underflow_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(wr_en_cp) intersect {0}) && (binsof(underflow_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(wr_en_cp) intersect {0,1}) && (binsof(underflow_cp) intersect {0});
					}
	/*******************************************************************************************************************************/
	rd_en_wr_ack_cross	: cross	rd_en_cp , wr_ack_cp{
						bins detect_ones = (binsof(rd_en_cp) intersect {1}) && (binsof(wr_ack_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(rd_en_cp) intersect {0}) && (binsof(wr_ack_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(rd_en_cp) intersect {0,1}) && (binsof(wr_ack_cp) intersect {0});
					}
	rd_en_overflow_cross	: cross	rd_en_cp , overflow_cp{
						bins detect_ones = (binsof(rd_en_cp) intersect {1}) && (binsof(overflow_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(rd_en_cp) intersect {0}) && (binsof(overflow_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(rd_en_cp) intersect {0,1}) && (binsof(overflow_cp) intersect {0});
					}
/*
	dosen't make sense to check this case
	rd_en_full_cross	: cross	rd_en_cp , full_cp{
						bins detect_ones = (binsof(rd_en_cp) intersect {1}) && (binsof(full_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(rd_en_cp) intersect {0}) && (binsof(full_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(rd_en_cp) intersect {0,1}) && (binsof(full_cp) intersect {0});
					}
*/
	rd_en_empty_cross	: cross	rd_en_cp , empty_cp{
						bins detect_ones = (binsof(rd_en_cp) intersect {1}) && (binsof(empty_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(rd_en_cp) intersect {0}) && (binsof(empty_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(rd_en_cp) intersect {0,1}) && (binsof(empty_cp) intersect {0});
					}
	rd_en_almostfull_cross	: cross	rd_en_cp , almostfull_cp{
						bins detect_ones = (binsof(rd_en_cp) intersect {1}) && (binsof(almostfull_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(rd_en_cp) intersect {0}) && (binsof(almostfull_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(rd_en_cp) intersect {0,1}) && (binsof(almostfull_cp) intersect {0});
					}
	rd_en_almostempty_cross	: cross	rd_en_cp , almostempty_cp{
						bins detect_ones = (binsof(rd_en_cp) intersect {1}) && (binsof(almostempty_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(rd_en_cp) intersect {0}) && (binsof(almostempty_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(rd_en_cp) intersect {0,1}) && (binsof(almostempty_cp) intersect {0});
					}
	rd_en_underflow_cross	: cross	rd_en_cp , underflow_cp{
						bins detect_ones = (binsof(rd_en_cp) intersect {1}) && (binsof(underflow_cp) intersect {1});
						ignore_bins ignored_1 = (binsof(rd_en_cp) intersect {0}) && (binsof(underflow_cp) intersect {0,1});
						ignore_bins ignored_2 = (binsof(rd_en_cp) intersect {0,1}) && (binsof(underflow_cp) intersect {0});
					}
endgroup

/****************	FUNCTIONS	***********************/
function void sample_data (input FIFO_transaction F_txn);
	
	F_cvg_txn.data_in	= F_txn.data_in;
	F_cvg_txn.rst_n		= F_txn.rst_n;
	F_cvg_txn.wr_en		= F_txn.wr_en;
	F_cvg_txn.rd_en		= F_txn.rd_en;
	F_cvg_txn.data_out	= F_txn.data_out;
	F_cvg_txn.wr_ack	= F_txn.wr_ack;
	F_cvg_txn.overflow	= F_txn.overflow;
	F_cvg_txn.full		= F_txn.full;
	F_cvg_txn.empty		= F_txn.empty;
	F_cvg_txn.almostfull	= F_txn.almostfull;
	F_cvg_txn.almostempty	= F_txn.almostempty;
	F_cvg_txn.underflow	= F_txn.underflow;

	cg.sample;
endfunction
///////////////////////////////////////////////////////////////
function new;
	cg		= new;
	F_cvg_txn	= new;
endfunction
/*************************************************************/
endclass

endpackage


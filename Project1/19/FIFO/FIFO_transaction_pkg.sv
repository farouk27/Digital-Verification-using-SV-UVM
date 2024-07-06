package	FIFO_transaction_pkg;

class	FIFO_transaction;
/********	PARAMETARS	********/
parameter	FIFO_WIDTH	= 16;
parameter	FIFO_DEPTH	= 8;
parameter	WR_EN_ON_DIST	= 70;
parameter	RD_EN_ON_DIST	= 30;
/********	INPUTS		********/
rand	bit	[FIFO_WIDTH-1:0]	data_in;
rand	bit				rst_n, wr_en, rd_en;
/********	OUTPUTS		********/
bit	[FIFO_WIDTH-1:0]	data_out;
bit				wr_ack, overflow;
bit				full, empty, almostfull, almostempty, underflow;
/***************************************/

/********	CONSTRAINTS	********/
constraint	rst_n_const {
				rst_n dist {1:=98 , 0:=2};
			}

constraint	wr_en_const {
				wr_en dist {1:=(WR_EN_ON_DIST) , 0:=(100 - WR_EN_ON_DIST)};
			}

constraint	rd_en_const {
			rd_en dist {1:=(RD_EN_ON_DIST) , 0:=(100 - RD_EN_ON_DIST)};
			}
endclass







endpackage

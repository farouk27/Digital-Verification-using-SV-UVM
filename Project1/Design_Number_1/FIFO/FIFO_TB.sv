import FIFO_coverage_pkg ::*;
import FIFO_scoreboard_pkg ::*;
import FIFO_transaction_pkg ::*;
import shared_pkg ::*;

module FIFO_TB(FIFO_if.TEST F_if);
/**********	VARIABLES	*************/
FIFO_transaction	FIFO_OBJ;
FIFO_coverage		FIFO_TXN;
FIFO_scoreboard		FIFO_CHECK;

localparam	TESTS	= 2000;
/**********	TEST SENARIO	*************/
initial
begin
	initializer;
	for(int i = 0 ; i < TESTS ; i++)
	begin
		assert(FIFO_OBJ.randomize());
		object_assign;
		FIFO_TXN.sample_data(FIFO_OBJ);
		FIFO_CHECK.check_data(FIFO_OBJ);
		@(negedge F_if.clk);
	end

test_finished	= 1;
@(negedge F_if.clk);
$stop;
end
/**********	TASKS	*************/
task	initializer;
	
	test_finished	= 0;
	F_if.data_in	= 0;
	F_if.wr_en	= 0;
	F_if.rd_en	= 0;
	FIFO_TXN	= new;
	FIFO_CHECK	= new;
	FIFO_OBJ	= new;
	system_reset;
endtask
//////////////////////////////////////
task	system_reset;
	
	F_if.rst_n = 0;
	@(negedge F_if.clk);
	F_if.rst_n = 1;
endtask
//////////////////////////////////////
task	object_assign;
	
	F_if.data_in	= FIFO_OBJ.data_in;
	F_if.wr_en	= FIFO_OBJ.wr_en;
	F_if.rd_en	= FIFO_OBJ.rd_en;
	F_if.rst_n	= FIFO_OBJ.rst_n;
	@(negedge F_if.clk);
	F_if.wr_en		= 1'b0;
	F_if.rd_en		= 1'b0;

	FIFO_OBJ.data_out	= F_if.data_out;
	FIFO_OBJ.wr_ack		= F_if.wr_ack;
	FIFO_OBJ.overflow	= F_if.overflow;
	FIFO_OBJ.full		= F_if.full;
	FIFO_OBJ.empty		= F_if.empty;
	FIFO_OBJ.almostfull	= F_if.almostfull;
	FIFO_OBJ.almostempty	= F_if.almostempty;
	FIFO_OBJ.underflow	= F_if.underflow;
endtask
//////////////////////////////////////
endmodule

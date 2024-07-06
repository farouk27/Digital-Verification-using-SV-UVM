////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
/////////////////////////////////////////////////////////////ss///////////////////
module FIFO(FIFO_if.DUT F_if);
parameter FIFO_WIDTH = F_if.FIFO_WIDTH;
parameter FIFO_DEPTH = F_if.FIFO_DEPTH;

localparam max_fifo_addr = $clog2(FIFO_DEPTH);

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count;

always @(posedge F_if.clk or negedge F_if.rst_n) begin
	if (!F_if.rst_n) begin
		wr_ptr <= 0;
	end
	else if (F_if.wr_en && count < (FIFO_DEPTH)) begin
		mem[wr_ptr] <= F_if.data_in;
		F_if.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
	end
	else begin 
		F_if.wr_ack <= 0; 
		if (F_if.full & F_if.wr_en)
			F_if.overflow <= 1;
		else
			F_if.overflow <= 0;
	end
end

always @(posedge F_if.clk or negedge F_if.rst_n) begin
	if (!F_if.rst_n) begin
		rd_ptr <= 0;
	end
	else if (F_if.rd_en && count != 0) begin
		F_if.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
	else
	begin
		if(F_if.empty && F_if.rd_en)
			F_if.underflow  <= 1'b1;
		else
			F_if.underflow  <= 1'b0;
	end
end

always @(posedge F_if.clk or negedge F_if.rst_n) begin
	if (!F_if.rst_n) begin
		count <= 0;
	end
	else begin
		if({F_if.wr_en, F_if.rd_en} == 2'b11)
		begin 
			if(F_if.empty)
				count <= count + 1;
			else if(F_if.full)
				count <= count - 1;
		end
		else if	( ({F_if.wr_en, F_if.rd_en} == 2'b10) && !F_if.full) 
			count <= count + 1;
		else if ( ({F_if.wr_en, F_if.rd_en} == 2'b01) && !F_if.empty)
			count <= count - 1;
	end
end

assign F_if.full = (count == (FIFO_DEPTH))? 1 : 0;
assign F_if.empty = (count == 0)? 1 : 0;
assign F_if.almostfull = (count == FIFO_DEPTH-1)? 1 : 0; 
assign F_if.almostempty = (count == 1)? 1 : 0;


//`ifdef SIM
property rst_check;
@(posedge F_if.clk) (!F_if.rst_n) |=> ((wr_ptr == 0) && (rd_ptr == 0) && (count == 0));
endproperty

rst_check_ap: assert property(rst_check);
rst_check_cp: cover property(rst_check);
//////////////////////////////////////////////////////////
property full_flag;
@(posedge F_if.clk) disable iff (!F_if.rst_n) (count == (FIFO_DEPTH)) |-> F_if.full;
endproperty

full_flag_ap: assert property(full_flag);
full_flag_cp: cover property(full_flag);
//////////////////////////////////////////////////////////
property empty_flag;
@(posedge F_if.clk) disable iff (!F_if.rst_n) (count == 0) |-> F_if.empty;
endproperty

empty_flag_ap: assert property(empty_flag);
empty_flag_cp: cover property(empty_flag);
//////////////////////////////////////////////////////////
property almostfull_flag;
@(posedge F_if.clk) disable iff (!F_if.rst_n) (count == FIFO_DEPTH-1) |-> F_if.almostfull;
endproperty

almostfull_flag_ap: assert property(almostfull_flag);
almostfull_flag_cp: cover property(almostfull_flag);
//////////////////////////////////////////////////////////
property almostempty_flag;
@(posedge F_if.clk) disable iff (!F_if.rst_n) (count == 1) |-> F_if.almostempty;
endproperty

almostempty_flag_ap: assert property(almostempty_flag);
almostempty_flag_cp: cover property(almostempty_flag);
//////////////////////////////////////////////////////////
property overflow_flag;
@(posedge F_if.clk) disable iff (!F_if.rst_n) (!(F_if.wr_en && count < (FIFO_DEPTH)) && (F_if.full & F_if.wr_en)) |=> F_if.overflow;
endproperty

overflow_flag_ap: assert property(overflow_flag);
overflow_flag_cp: cover property(overflow_flag);
//////////////////////////////////////////////////////////
property underflow_flag;
@(posedge F_if.clk) disable iff (!F_if.rst_n) (!(F_if.rd_en && count != 0) && (F_if.empty && F_if.rd_en)) |=> F_if.underflow;
endproperty

underflow_flag_ap: assert property(underflow_flag);
underflow_flag_cp: cover property(underflow_flag);
//////////////////////////////////////////////////////////
property wr_ack_flag;
@(posedge F_if.clk) disable iff (!F_if.rst_n) (F_if.wr_en && count < (FIFO_DEPTH)) |=> F_if.wr_ack;
endproperty

wr_ack_flag_ap: assert property(wr_ack_flag);
wr_ack_flag_cp: cover property(wr_ack_flag);
//////////////////////////////////////////////////////////
property counter_up;
@(posedge F_if.clk) disable iff (!F_if.rst_n) ( ({F_if.wr_en, F_if.rd_en} == 2'b10) && !F_if.full) |=> (($past(count) + 1) == count);
endproperty

counter_up_ap: assert property(counter_up);
counter_up_cp: cover property(counter_up);
//////////////////////////////////////////////////////////
property counter_down;
@(posedge F_if.clk) disable iff (!F_if.rst_n) ( ({F_if.wr_en, F_if.rd_en} == 2'b01) && !F_if.empty) |=> (($past(count) - 1) == count);
endproperty

counter_down_ap: assert property(counter_down);
counter_down_cp: cover property(counter_down);
//////////////////////////////////////////////////////////
//`endif
endmodule
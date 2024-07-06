module ram_sva (RAM_if.ASSERTIONS r_if); 
// this file will contain all the system verilog assertions.
// check on the sequance that you know that it must achived.

/******************************************************************************************/
property check_reset ; 
	@(posedge r_if.clk) $fell(r_if.rst_n) |-> (r_if.tx_valid==0) ; 
endproperty

assert property (check_reset) ; 
cover property (check_reset) ; 
/******************************************************************************************/

/******************************************************************************************/
property check_tx_valid_transition ; 
@(posedge r_if.clk) disable iff(!r_if.rst_n) (r_if.din[9:8]==2'b11)&&(r_if.rx_valid) |=> $rose(r_if.tx_valid) ; 
endproperty

assert property (check_tx_valid_transition) ; 
cover property (check_tx_valid_transition) ; 
/******************************************************************************************/

/******************************************************************************************/
property tx_remain_low_to_nextRead ;
@(posedge r_if.clk) disable iff(!r_if.rst_n) (r_if.tx_valid) |=> ((!r_if.tx_valid) throughout (r_if.din[9:8]==2'b11)[->1]) ; 
endproperty

assert property (tx_remain_low_to_nextRead) ; 
cover property (tx_remain_low_to_nextRead) ;
/******************************************************************************************/

/******************************************************************************************/
property write_address_next_write_data ;
@(posedge r_if.clk) disable iff(!r_if.rst_n) (r_if.din[9:8]==2'b00) |=> (r_if.din[9:8]==2'b01) ; 
endproperty

assert property (write_address_next_write_data) ; 
cover property (write_address_next_write_data) ;
/******************************************************************************************/

/******************************************************************************************/
property read_address_next_read_data ;
@(posedge r_if.clk) disable iff(!r_if.rst_n) (r_if.din[9:8]==2'b10) |=> (r_if.din[9:8]==2'b11) ; 
endproperty

assert property (read_address_next_read_data) ; 
cover property (read_address_next_read_data) ;
/******************************************************************************************/

endmodule

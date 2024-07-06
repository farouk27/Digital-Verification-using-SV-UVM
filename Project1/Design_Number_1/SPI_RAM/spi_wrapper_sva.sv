module spi_wrapper_sva(spi_wrapper_interface.DUT w_if); 

// example from ram

// /******************************************************************************************/
// property check_reset ; 
// 	@(posedge r_if.clk) $fell(r_if.rst_n) |-> (r_if.dout==0) ; 
// endproperty

// assert property (check_reset) ; 
// cover property (check_reset) ; 
// /******************************************************************************************/
property wr_address_wr_data ;
@(posedge w_if.clk) disable iff(!w_if.rst_n) (w_if.MOSI==1'b0) |=> (w_if.MOSI==1'b0) |=> (w_if.MOSI==1'b0) |=> (w_if.MOSI==1'b0) |=> (w_if.MOSI==1'b0) |=> (w_if.MOSI==1'b1); 
endproperty

assert property (wr_address_wr_data) ; 
cover property (wr_address_wr_data) ;

property rd_address_rd_data ;
@(posedge w_if.clk) disable iff(!w_if.rst_n) (w_if.MOSI==1'b1) |=> (w_if.MOSI==1'b1) |=> (w_if.MOSI==1'b0) |=> (w_if.MOSI==1'b1) |=> (w_if.MOSI==1'b1) |=> (w_if.MOSI==1'b1);  
endproperty

assert property (rd_address_rd_data) ; 
cover property (rd_address_rd_data) ;


endmodule


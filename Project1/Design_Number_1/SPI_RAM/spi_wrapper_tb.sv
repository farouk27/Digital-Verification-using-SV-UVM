// import packages . 
import spi_wrapper_package::* ; 

module spi_wrapper_tb (spi_wrapper_interface.TEST w_if);

WRAPPER_transaction w_trans ; 

initial begin 

	initialize() ; 
	assert_rest() ;
		 

	// randomize multiple times 
	// set values of the interface .

	repeat (10000) begin 
		assert(w_trans.randomize()); 
		set_interface_value();
		set_Mosi_interface(); 	

	end

	@(negedge w_if.clk)

	$stop(); 

end 

always@(posedge w_if.clk)
begin
	w_trans.cg.sample();
end

task set_Mosi_interface(); 

	foreach(w_trans.MOSI[i]) begin
	@(negedge w_if.clk)
  	w_if.MOSI = w_trans.MOSI[i] ;
	end

	@(negedge w_if.clk) 
	w_if.SS_n = 1'b1 ; 

	repeat(8)
	begin
		@(negedge w_if.clk)
  		w_trans.MISO = w_if.MISO;
	end
endtask

task set_interface_value() ; 
	@(negedge w_if.clk)
         w_if.rst_n = w_trans.rst_n ;
	 w_if.SS_n = w_trans.SS_n ;
endtask 

task initialize; 
   	w_if.SS_n = 1'b1 ; 
	w_if.MOSI = 1'b0 ; 
	w_trans = new ;
endtask 


task assert_rest; 
w_if.rst_n = 1'b0 ; 
@(negedge w_if.clk)
w_if.rst_n = 1'b1 ; 
endtask 


endmodule : spi_wrapper_tb
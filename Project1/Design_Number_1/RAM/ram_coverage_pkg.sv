package ram_coverage_pkg;
import ram_package ::* ; 

class  ram_coverage;
// make instance of your transaction class which contain the constrains. and your input output signals. 
ram_transaction ram_trans; 

/*					COVERGROUP 					*/
covergroup cg ;
	din_9_8_cp : coverpoint ram_trans.din[9:8] 
	{
		bins din_00 = {2'b00} ; 
		bins din_10 = {2'b10} ; 
		bins din_01 = {2'b01} ; 
		bins din_11 = {2'b11} ;
		bins din_00_01 = (2'b00 => 2'b01) ; 
		bins din_10_11 = (2'b10 => 2'b11) ;
	}

	// din_7_0_cp : coverpoint ram_trans.din[7:0] ; 


	rx_valid_cp : coverpoint ram_trans.rx_valid 
	{
		// ignore_bins zero = {0} ; 
		bins zero = {0} ; 
		bins one = {1} ; 
	} 

	tx_valid_cp : coverpoint ram_trans.tx_valid 
	{
		bins tx_0 = {0} ; 
		bins tx_1 = {1} ;
		bins tx_trans_0_1 = (0=>1);
		bins tx_trans_1_0 = (1=>0); 
	}
	

endgroup 

function new ; 
	cg = new ; 
	ram_trans = new ; 
endfunction 


endclass 

endpackage 
package ram_package; 
/*			parameters 				*/
parameter IN_WIDTH = 10 ; 
parameter OUT_WIDTH = 8 ; 

/*			define class which contain all the signals that you will randmize		*/
	class ram_transaction ; 
		/*			inputs 					*/
		rand bit [IN_WIDTH-1:0] din ; 
		rand bit rx_valid ; 
		rand bit rst_n ; 

		/*			outputs 					*/
		bit [OUT_WIDTH-1:0] dout ; 
		bit tx_valid ; 		


	// save the prev value of din
		bit [1:0] old_value_9_8_din ; 

	/*				constrains 					*/
	constraint rst_n_c {
		rst_n dist  {1:=99 , 0:=1};
	}

	constraint rx_valid_c {
		rx_valid dist {1:/90 , 0:/10};
	}

	constraint din_9_8_c {
		(old_value_9_8_din==2'b00) -> din[9:8] == 2'b01 ;
		(old_value_9_8_din==2'b10) -> din[9:8] == 2'b11 ; 
		(old_value_9_8_din==2'b01||old_value_9_8_din==2'b11) -> din[9:8] dist {2'b00:/50 , 2'b10:/50} ; 
	}

	// we may add constrain on the bits din [7:0].

	function void post_randomize();
		old_value_9_8_din = din[9:8] ;	
	endfunction 

	endclass

endpackage : ram_package
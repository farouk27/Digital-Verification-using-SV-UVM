package spi_wrapper_package;

/*			parameters 				*/
parameter FRAME_SIZE = 11 ; 


/*			define class which contain all the signals that you will randmize		*/
	class WRAPPER_transaction ; 
	
		/*				input 				*/
		rand bit rst_n ;
		rand bit [FRAME_SIZE-1:0]  MOSI ; 
		bit SS_n ; 
		
		/*				outputs 			*/
		bit  MISO ; 

    // save the prev value of MOSI
		bit [2:0] old_value_10_8 ; 

	/*				constraints 					*/
		constraint rst_n_c {
			rst_n dist {1:=99 , 0:=1} ; 
		}

		// constraint  ss_n_c {
		// 	SS_n dist {0:=99 , 1:=1};
		//  }

		constraint MOSI_c {
			(old_value_10_8==3'b000) -> MOSI[10:8]==3'b001 ; 
			(old_value_10_8==3'b110) -> MOSI[10:8]==3'b111 ; 
		}

		function void post_randomize();
			old_value_10_8 = MOSI[10:8] ; 
		endfunction 


		/*				add cover points 			*/
	covergroup cg;
	      MOSI_cp1 : coverpoint MOSI[10:8] 
			{
	          bins MOSI_wr_address = {3'b000};
	          bins MOSI_wr_data = {3'b001};
	          bins MOSI_rd_address = {3'b110};
		  	bins MOSI_rd_data = {3'b111};
			}			

	       MOSI_cp2 : coverpoint MOSI[7:0] 
			{
	          bins MOSI_first_addr = {8'h00};
	          bins MOSI_last_addr = {8'hFF};
	          bins rest_MOSI [] = {[8'h01 : 8'hFE]};
			}	
			
			
	       SS_n_cp : coverpoint SS_n 
			{
				bins SS_n_0 = {0} ; 
				bins SS_n_1 = {1} ;
			}

			// you may intersted in output coverpoints . 


	endgroup


	function new () ;
		cg = new ; 
	endfunction 


	endclass 
	
endpackage : spi_wrapper_package
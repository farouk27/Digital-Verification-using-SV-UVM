// package wrapper_coverage_pkg;
// 	import spi_wrapper_package::*; 
 

// 	class wrapper_coverage ; 
// // make instance of your transaction class which contain the constrains. and your input output signals. 
// 			WRAPPER_transaction wrap_trans ;
			
			
// /*					COVERGROUP 					*/
// 		covergroup cg;
//       MOSI_cp1 : coverpoint wrap_trans.MOSI[10:8] 
// 		{
//           bins MOSI_wr_address = {3'b000};
//           bins MOSI_wr_data = {3'b001};
//           bins MOSI_rd_address = {3'b110};
// 	  	bins MOSI_rd_data = {3'b111};
// 		}			

//        MOSI_cp2 : coverpoint wrap_trans.MOSI[7:0] 
// 		{
//           bins MOSI_first_addr = {8'h00};
//           bins MOSI_last_addr = {8'hFF};
//           bins rest_MOSI [] = {[8'h01 : 8'hFE]};
// 		}	
		
		
//        SS_n_cp : coverpoint wrap_trans.SS_n 
// 	{
// 		bins SS_n_0 = {0} ; 
// 		bins SS_n_1 = {1} ;
// 		bins SS_n_trans_0_1 = (0=>1);
// 		bins SS_n_trans_1_0 = (1=>0); 
// 	}

// 		// you may intersted in output coverpoints . 


// 		endgroup


// 		function new () ;
// 			cg = new ; 
// 			wrap_trans = new ; 
// 		endfunction 


// 	endclass 
// endpackage
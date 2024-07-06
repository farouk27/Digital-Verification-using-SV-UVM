interface spi_wrapper_interface (
		input bit clk 
);

logic MOSI, MISO , rst_n , SS_n ;

modport DUT (
	input clk , MOSI , rst_n , SS_n , 
	output MISO 
);

modport  TEST (
	input  clk , MISO , 
	output MOSI , rst_n , SS_n
);


modport MONITOR (
	input MOSI , MISO , rst_n  ,SS_n , clk 
);


	
endinterface
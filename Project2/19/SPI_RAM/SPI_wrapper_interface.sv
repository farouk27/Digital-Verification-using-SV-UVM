interface spi_wrapper_interface (
		input bit clk 
);

logic MOSI, MISO , rst_n , SS_n ;

modport DUT (
	input clk , MOSI , rst_n , SS_n , 
	output MISO 
);

modport MONITOR (
	input MOSI , MISO , rst_n  ,SS_n , clk 
);


	
endinterface
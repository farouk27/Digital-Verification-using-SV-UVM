module spi_wrapper(spi_wrapper_interface.DUT w_if);
	
// logic MOSI , clk , rst_n , SS_n ;
// logic MISO ;

// assign MOSI = w_if.MOSI ; 
// assign MISO  = w_if.MISO ; 
// assign clk = w_if.clk ; 
// assign rst_n  = w_if.rst_n ; 
// assign SS_n = w_if.SS_n ; 



wire [9:0] W1;
wire W2,W3;
wire [7:0] W4;

project m1(.MOSI(w_if.MOSI),.MISO(w_if.MISO),.clk(w_if.clk),.rst_n(w_if.rst_n),.SS_n(w_if.SS_n),.rx_data(W1),.rx_valid(W2),.tx_data(W4),.tx_valid(W3));

spi_ram m2(.clk(w_if.clk),.rst_n(w_if.rst_n),.din(W1),.rx_valid(W2),.dout(W4),.tx_valid(W3));


endmodule


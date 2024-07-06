module spi_wrapper_top(); 

bit clk = 0 ;
parameter clock_period = 10 ;  

initial begin 
	clk = 0 ; 
	forever #(clock_period/2) clk = ~clk ; 
end 

// call dut , interface , test , monitor 

spi_wrapper_interface w_if (clk); 
spi_wrapper dut (w_if); 
spi_wrapper_tb tb (w_if) ; 
SPI_MONITOR mon (w_if) ; 

 
endmodule
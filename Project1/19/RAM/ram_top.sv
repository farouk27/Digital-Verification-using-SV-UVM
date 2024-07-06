module ram_top() ; 

parameter clock_period =10 ; 
// generate your clock 
bit clk ; 

initial begin 
	clk = 0 ; 
	forever #(clock_period/2) clk = ~clk ;
end

/*			connect all the modules together 				*/
RAM_if r_if (clk) ; 
spi_ram dut (r_if) ; 
RAM_TB tb (r_if); 
RAM_MONITOR mon(r_if); 

// bind design with sva.
bind spi_ram ram_sva ram_sva_instan(r_if);

endmodule


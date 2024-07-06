import ram_package::*;
import ram_coverage_pkg::*;

module RAM_TB(RAM_if.TEST r_if) ; 

ram_transaction ram_trans ; 
ram_coverage    ram_cov ; 


initial begin 
	r_if.din = 'b0 ; 
	r_if.rx_valid = 0 ; 
	assert_reset(); 

	ram_trans = new ; 
	ram_cov = new ; 

	repeat(1000)begin 
		@(negedge r_if.clk);
		assert(ram_trans.randomize()); 
		/*		set interface value 	*/
		set_interface_values();

		// you must check result here and wait for clock cycle . 
		// ram_cov.sample_data(ram_trans) ;

		ram_cov.cg.sample();
	end
	$stop ; 
end

task set_interface_values ; 
// randomized inputs.
r_if.rst_n = ram_trans.rst_n ; 
r_if.din = ram_trans.din ; 
r_if.rx_valid = ram_trans.rx_valid ; 



ram_cov.ram_trans.rst_n = r_if.rst_n ; 
ram_cov.ram_trans.din = r_if.din ; 
ram_cov.ram_trans.rx_valid = r_if.rx_valid ; 

// @(negedge r_if.clk);
ram_cov.ram_trans.dout = r_if.dout ; 
ram_cov.ram_trans.tx_valid = r_if.tx_valid ; 
endtask 

task assert_reset ; 
r_if.rst_n = 1'b0 ; 
@(negedge r_if.clk) 
r_if.rst_n = 1'b1 ; 
endtask 



// task check_result (); 
// // this will call the golden model.
// // compare the expected output with the output from your dut.
// endtask
// task golden_model(); 
// endtask 


endmodule
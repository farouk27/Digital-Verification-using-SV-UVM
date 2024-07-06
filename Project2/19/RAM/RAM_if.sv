interface RAM_if(
	input bit clk 
);

/*				parameters 				*/
parameter IN_WIDTH = 10 ; 
parameter OUT_WIDTH = 8 ; 

/*			interface signals 				*/
logic [IN_WIDTH-1:0] din ; 
logic rx_valid , rst_n , tx_valid ; 
logic [OUT_WIDTH-1:0] dout ; 

/*			modports for TB and dout		*/
modport DUT (
	input clk , din , rx_valid , rst_n ,
	output tx_valid , dout  
);

modport MONITOR (
	input clk , din , rx_valid , rst_n ,tx_valid , dout 
);

modport ASSERTIONS (
input clk , din , rx_valid , rst_n ,tx_valid , dout 

);
endinterface 

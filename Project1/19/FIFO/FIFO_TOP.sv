module	FIFO_TOP;
parameter clk_period = 10;
bit	clk;

initial
begin
	clk = 1'b0;	
end

always
begin
	#(clk_period/2) clk = ~clk;
end 

FIFO_if	FIFO_INTERFACE(
.clk	(clk)
);

FIFO		DUT	(FIFO_INTERFACE);
FIFO_TB		TB	(FIFO_INTERFACE);
FIFO_MONITOR	MONITOR();
endmodule

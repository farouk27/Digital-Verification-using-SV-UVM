import shared_pkg ::*;

module	FIFO_MONITOR;

always@(*)
begin
	if(test_finished)
	begin
		$display("/****************************************/");
		$display("ERRORS:	%d" , error_count);
		$display("CORRECT:	%d" , correct_count);
		$display("/****************************************/");
	end
end

endmodule
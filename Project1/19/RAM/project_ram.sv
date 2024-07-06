module spi_ram(RAM_if.DUT r_if);

// input [9:0] din;
// input rx_valid;
// input clk,rst_n;
// output reg tx_valid;
// output reg[7:0] dout;


reg [7:0] WRITE_ADD,READ_ADD;
reg[7:0] mem[255:0];

integer i;

// this design will be more better if we change the design to be case statement.

always@(posedge r_if.clk or negedge r_if.rst_n) begin
if(!r_if.rst_n) begin
     r_if.tx_valid<=0 ;
     for(i=0 ; i<= 255 ; i=i+1)
          mem[i] <= 0 ; 
     r_if.dout<=0;
     WRITE_ADD<=0 ;
     READ_ADD <=0 ;
end
// ALSO we need to make tx_valid=0 in the cases that we are not read from the mem.
else if(r_if.rx_valid) begin
      if(r_if.din[9:8]==2'b00) 
      begin
          WRITE_ADD<=r_if.din[7:0];
          r_if.tx_valid<=0;
      end

      else if(r_if.din[9:8]==2'b01) begin
           mem[WRITE_ADD]<=r_if.din[7:0];
            r_if.tx_valid<=0;
      end

      else if(r_if.din[9:8]==2'b10) begin
           READ_ADD<=r_if.din[7:0];
            r_if.tx_valid<=0;
      end

      else if(r_if.din[9:8]==2'b11) begin
           r_if.dout <= mem[READ_ADD];
           r_if.tx_valid<=1;
      end
end

else begin 
r_if.dout <=0 ; 
r_if.tx_valid <= 0 ; 
end
 
end


endmodule





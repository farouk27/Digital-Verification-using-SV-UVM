module spi_ram(din , rx_valid , clk , rst_n , tx_valid , dout);

input [9:0] din;
input rx_valid;
input clk,rst_n;
output reg tx_valid;
output reg[7:0] dout;


reg [7:0] WRITE_ADD,READ_ADD;
reg[7:0] mem[255:0];

integer i;

// this design will be more better if we change the design to be case statement.

always@(posedge clk or negedge rst_n) begin
if(!rst_n) begin
     for (i=0 ; i<255 ; i++) begin 
          mem[i] <= i ; 
     end
     tx_valid<=0 ;
     dout<=0;
     WRITE_ADD<=0 ;
     READ_ADD <=0 ;
end
// ALSO we need to make tx_valid=0 in the cases that we are not read from the mem.
else if(rx_valid) begin
      if(din[9:8]==2'b00) 
      begin
          WRITE_ADD<=din[7:0];
          tx_valid<=0;
      end

      else if(din[9:8]==2'b01) begin
           mem[WRITE_ADD]<=din[7:0];
            tx_valid<=0;
      end

      else if(din[9:8]==2'b10) begin
           READ_ADD<=din[7:0];
            tx_valid<=0;
      end

      else if(din[9:8]==2'b11) begin
           dout <= mem[READ_ADD];
           tx_valid<=1;
      end
end

end

endmodule





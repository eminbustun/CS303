module controller(
    input clk,
    input rst,
    input beginn, 
    input reset,
    input zero,
    input endd,
    output load,
    output start,
    output reg countdown
    );
    
    assign load = reset;
   // assign countdown = beginn;
    assign start = beginn;
  
    
    always @ (posedge clk, negedge rst)
      begin
       if (beginn) begin
           countdown <= 1;
      end
        else if (~rst) begin
            countdown <= 0;
        end
        else if (reset) begin
           countdown <= 0;
         end

        else if (zero & endd) begin 
            countdown <= 0;
        end
   end
endmodule
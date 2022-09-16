module downcounter(
    input rst, c1khz,
    input count, load, 
    input [3:0] pm10,
    input [3:0] pm1,
    input [3:0] ps10,
    input [3:0] ps1,
    output reg [3:0] m10,
    output reg [3:0] m1,
    output reg [3:0] s10,
    output reg [3:0] s1,
    output zero);
 
   assign zero = (m10 == 0) & (m1 == 0) & (s10 == 0) & (s1 == 0);
    always @(posedge c1khz, negedge rst)
	begin
    	  if (load)
	  begin
             m10 <= pm10;
	     m1 <= pm1;
	     s10 <= ps10;
	     s1 <= ps1;
	  end
	  else if(~rst)
	  begin
	    s1 <= 0;
	    s10 <= 0;
	    m1 <= 0;
	    m10 <= 0;
	  end
	  else if (c1khz & !zero & count)
	  begin
	    if(s1 != 4'b1111)
		begin
	    	s1 <= s1 - 2'b1;
		end
	    if(s1 - 2'b1 == 4'b1111)
		begin
		s1 <= 9;
		end
	    if (s1 == 0 & s10 != 4'b1111)
	    begin 
 	      s10 <= s10 -2'b1;
		if(s10 - 2'b1 == 4'b1111)
		begin 
 	        s10 <= 5;
	    	end
	    end

	    if (s1 == 0 & s10 == 0)
	    begin
	       m1 <= m1 - 2'b1;
		if(m1 - 2'b1 == 4'b1111)
		begin 
 	        m1 <= 9;
		m10 <= m10-2'b1;
	    	end
	    end
	    
	    
	    
	 end
	     
	    
   end
endmodule
module divisorFrecuencia_tb();
	
	//input
	logic clock;
	
	//output
	logic clock25MHz;	

	//intantiate device under test
	divisorFrecuencia DUT(clock, clock25MHz);

	//apply inputs one at a time
	//checking results
	initial begin
        clock = 0; #10;
	end

    always begin
        clock = ~clock; #10;
    end

endmodule
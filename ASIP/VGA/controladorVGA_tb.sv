module controladorVGA_tb();
	
    //Inputs
    logic clock; //Clock de 25MHz

    //Outputs
    logic hsync;
    logic vsync;
    logic video_on;
    logic [9:0] pixelX;
    logic [9:0] pixelY;	

	//intantiate device under test
	controladorVGA DUT(clock, hsync, vsync, video_on, pixelX, pixelY);

	//apply inputs one at a time
	//checking results
	initial begin
        clock = 0; #10;
	end

    always begin
        clock = ~clock; #10;
    end

endmodule
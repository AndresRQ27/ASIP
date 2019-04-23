module regionPantalla_tb();
	
    //Inputs
    logic clock;
    logic [9:0] posicionX;
    logic [9:0] posicionY;
    logic [2:0] readValueMemory;

    //Outputs
    logic [7:0] red;
    logic [7:0] green;
    logic [7:0] blue;

	//intantiate device under test
	regionPantalla DUT(clock, readValueMemory, posicionX, posicionY, red, green, blue);

	//apply inputs one at a time
	//checking results
	initial begin
        clock = 0; posicionX = 'd0; posicionY = 'd0; #10;
        readValueMemory = 3'b000; clock = ~clock; #10;
        
        posicionX = 'd1; posicionY = 'd0; clock = ~clock; #10;
        readValueMemory = 3'b001; clock = ~clock; #10;

        posicionX = 'd2; posicionY = 'd0; clock = ~clock; #10;
        readValueMemory = 3'b010; clock = ~clock; #10;

        posicionX = 'd3; posicionY = 'd0; clock = ~clock; #10;
        readValueMemory = 3'b100; clock = ~clock; #10;

        posicionX = 'd4; posicionY = 'd0; clock = ~clock; #10;
        readValueMemory = 3'b011; clock = ~clock; #10;

        posicionX = 'd5; posicionY = 'd0; clock = ~clock; #10;
        readValueMemory = 3'b101; clock = ~clock; #10;

        posicionX = 'd6; posicionY = 'd0; clock = ~clock; #10;
        readValueMemory = 3'b110; clock = ~clock; #10;

        posicionX = 'd7; posicionY = 'd0; clock = ~clock; #10;
        readValueMemory = 3'b111; clock = ~clock; #10;
	end

endmodule
/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// This module will store the memory for the processor
// Will be able to store a Width x Height image

module Memory#(	parameter Width = 5, 
						parameter Height = 10,
						parameter ColorBits = 3)
						(	clk, 
									XWrite, YWrite, WriteValue,
									XRead, YRead, ReadValue);
	
	// Inputs and outputs
	input logic clk;
	
	input logic [9-1:0] XWrite;
	input logic [8-1:0] YWrite;
	input logic [ColorBits-1:0] WriteValue;
	
	input logic [9-1:0] XRead;
	input logic [8-1:0] YRead;
	output logic [ColorBits-1:0] ReadValue;
	
	// 2D Array definition
	reg [ColorBits-1:0] Image [0:Width-1] [0:Height-1];
	
	// Auxiliar for initialization
	integer x_iterator;
	integer y_iterator;
	

	
	// Run once at initialization
	initial begin
	
		//ReadValue = 0;
		
		// Initialize the image in 0 => Goes to black
		for (x_iterator = 0; x_iterator < Width; x_iterator = x_iterator + 1) begin
			for (y_iterator = 0; y_iterator < Height; y_iterator = y_iterator + 1) begin
				
				if ( 32'd0 < y_iterator && 32'd25 > y_iterator ) begin
					//Image[x_iterator-1][y_iterator-1] = 3'b010;
					Image[x_iterator][y_iterator] = 3'b010;
					//Image[x_iterator+1][y_iterator+1] = 3'b010;
				end else begin
					Image[x_iterator][y_iterator] = 3'b000;
				end
			end
		end
	end	
	
	always @(posedge clk) begin
		
		// Read Process
		ReadValue = Image[XRead][YRead];
		
		// Write Process
		Image[XWrite][YWrite] = WriteValue;
	
	end 
	
	
endmodule
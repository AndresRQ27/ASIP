/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Memory's testbench

module Memory_tb ();

	// Parameters
	parameter Width = 5;
	parameter Height = 10;
	parameter ColorBits = 3;
	
	/* Clock Signal */
	reg clk;

	// Components
	logic [9-1:0] XWrite;
	logic [8-1:0] YWrite;
	logic [ColorBits-1:0] WriteValue;
	
	logic [9-1:0] XRead;
	logic [8-1:0] YRead;
	logic [ColorBits-1:0] ReadValue;


	// Device Under Test
	Memory #(	Width, Height, ColorBits) 
			DUT (	clk, 
						XWrite, YWrite, WriteValue,
						XRead, YRead, ReadValue);


	// The testbench values
	initial begin
	
		$display("Testbench for Memory");
		
		clk = 1'b0;
		
		#1; WriteValue = 3'b101; XWrite = 9'b0; YWrite = 9'b0;
		#1; XRead = 0; YRead = 0;
		#1; WriteValue = 3'b010; XWrite = 9'b10; YWrite = 9'b100;
		#1; XRead = 9'b10; YRead = 9'b100;
		#1; WriteValue = 3'b111; XWrite = 9'b100; YWrite = 9'b1001;
		#1; XRead = 9'b100; YRead = 9'b1001;
		#3;
		
		$finish;
		
	end
	
	/* Toggle the clock */
	always begin
		#1 clk = ~clk;
	end

endmodule 
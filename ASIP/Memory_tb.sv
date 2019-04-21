/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Memory's testbench

module Memory_tb ();

	// Parameters
	parameter Width = 320;
	parameter Height = 240;
	parameter ColorBits = 8;
	
	/* Clock Signal */
	reg clk;

	// Components
	logic [$ceil($clog2(Width))-1:0] XWrite;
	logic [$ceil($clog2(Height))-1:0] YWrite;
	logic [ColorBits-1:0] RWrite;
	logic [ColorBits-1:0] GWrite;
	logic [ColorBits-1:0] BWrite;
	
	logic [$ceil($clog2(Width))-1:0] XRead;
	logic [$ceil($clog2(Height))-1:0] YRead;
	logic [ColorBits-1:0] RRead;
	logic [ColorBits-1:0] GRead;
	logic [ColorBits-1:0] BRead;


	// Device Under Test
	Memory #(	Width, Height, ColorBits) 
			DUT (	clk, 
							XWrite, YWrite, RWrite, GWrite, BWrite,
							XRead, YRead, RRead, GRead, BRead);


	// The testbench values
	initial begin
	
		$display("Testbench for Memory");
		
		clk = 1'b0;

		
		$finish;
		
		
		
		
		
		
	end
	
	/* Toggle the clock */
	always begin
		#1 clk = ~clk;
	end

endmodule 
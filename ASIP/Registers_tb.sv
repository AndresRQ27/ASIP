/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Registers's testbench

module Registers_tb ();

	// Parameters
	parameter RegisterSize = 32;
	parameter AmountOfRegisters = 16;
	
	/* Clock Signal */
	reg clk;

	// Components
	logic reset;
	logic [3:0] writeRegister;
	logic [RegisterSize-1:0] writeValue;
	logic [3:0] readRegister;
	
	logic [RegisterSize-1:0] pc;
	logic [RegisterSize-1:0] readValue;

	// Device Under Test
	Registers #(	RegisterSize, AmountOfRegisters ) 
			DUT (	clk, reset, pc, writeRegister, writeValue, readRegister, readValue);


	// The testbench values
	initial begin
	
		$display("Testbench for Registers");
		
		clk = 1'b0;
		readRegister = 4'b0000;		
		#1;
		writeRegister = 4'b0000; writeValue = 32'hffffffff;
		#1;
		readRegister = 4'b0000;		
		#1;
		reset = 1;
		#1;
		writeRegister = 4'b1111; writeValue = 32'h0000ffff;
		
		$finish;
		
		
		
		
		
		
	end
	
	/* Toggle the clock */
	always begin
		#1 clk = ~clk;
	end

endmodule 
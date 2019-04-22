/**
* Costa Rica Institute of Technology
* @author Kendall González
* Computer Architecture
* ASIP
*/

// Instruction Memory's testbench

module InstructionMemory_tb();

	// Parameters
	parameter PCSize = 32; 
	parameter InstructionSize = 32;
	parameter AmountOfInstructions = 128;

	// Components
	logic [PCSize-1:0] PC;
	logic [InstructionSize-1:0] Instruction;


	// Device Under Test
	InstructionMemory #(	PCSize, InstructionSize, AmountOfInstructions) 
			DUT (	PC, Instruction );


	// The testbench values
	initial begin
	
		$display("Testbench for Instruction Memory");
		
		PC = 0;
		
		#1 PC = PC + 4;
		#1 PC = PC + 4;
		#1 PC = PC + 4;
		#1 PC = PC + 4;
		#1 PC = PC + 4;
		#3;
		
		$finish;
		
	end

endmodule 